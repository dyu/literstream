#!/bin/sh

set -eo pipefail

CURRENT_DIR=$PWD
# locate
if [ -z "$BASH_SOURCE" ]; then
    SCRIPT_DIR=`dirname "$(readlink -f $0)"`
elif [ -e '/bin/zsh' ]; then
    F=`/bin/zsh -c "print -lr -- $BASH_SOURCE(:A)"`
    SCRIPT_DIR=`dirname $F`
elif [ -e '/usr/bin/realpath' ]; then
    F=`/usr/bin/realpath $BASH_SOURCE`
    SCRIPT_DIR=`dirname $F`
else
    F=$BASH_SOURCE
    while [ -h "$F" ]; do F="$(readlink $F)"; done
    SCRIPT_DIR=`dirname $F`
fi

cd $SCRIPT_DIR

MOD=fanout_bench

mkdir -p target/$MOD

REL_BIN="target/release/examples/$MOD"

if [ "$1" = '0' ] || [ ! -e "$REL_BIN" ]; then
  cargo build --release --example $MOD
fi

[ -z "$FANOUT_LOCAL" ] || { ./$REL_BIN; du -sh $FANOUT_LOCAL; exit 0; }

if [ -e "$GARAGE_KEYS_DIR/secret.txt" ]; then
    export LITESTREAM_S3_ACCESS_KEY=`cat $GARAGE_KEYS_DIR/access.txt`
    export LITESTREAM_S3_SECRET=`cat $GARAGE_KEYS_DIR/secret.txt`
    export LITESTREAM_S3_BUCKET=`basename $GARAGE_KEYS_DIR`
    export LITESTREAM_S3_REGION='garage'
    export LITESTREAM_S3_ENDPOINT='http://s3.localhost:9010'
else
    export LITESTREAM_S3_ACCESS_KEY='rustfs.access.KEY'
    export LITESTREAM_S3_SECRET='rustfs.secret.KEY'
    export LITESTREAM_S3_BUCKET='literstream-legacy'
    export LITESTREAM_S3_REGION='us-east-1'
    export LITESTREAM_S3_ENDPOINT='http://localhost:9000'
fi

echo "endpoint: $LITESTREAM_S3_ENDPOINT | region: $LITESTREAM_S3_REGION"
./$REL_BIN
