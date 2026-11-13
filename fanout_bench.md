# local
```sh
FANOUT_LOCAL=target/fanout_bench/local-legacy ./target/release/examples/fanout_bench
```
```
backend  : LocalFileSystem(target/fanout_bench/local-legacy)
workload : 100 databases, 60s, ~20 txns/s aggregate, tick 1000ms, sizes 100-5000 KB
prefix   : fanout-39434/db-<i>

setup    : 100 databases seeded + opened in 1.2s, RSS 29.4 MB  (1000 list, 0 get during open)


===== results =====
databases          : 100
correctness        : 100/100 restored exactly
writes issued      : 1140  (~18.8/s aggregate)
RSS after setup    : 29.4 MB  (100 idle drivers, replication not yet running)
peak RSS in run    : 59.4 MB  (steady-state replication of all 100)
peak RSS w/ verify : 83.4 MB  (also restoring all 100 at once; a bench artifact)
CPU total          : 12.59 s
over-fold snapshots: 0
max staged backlog : 0 bytes

object-store ops during the 61s run (delta):
  put              1912   (  31.6/s)
  mpu_init            0   (   0.0/s)
  mpu_part            0   (   0.0/s)
  mpu_complete        0   (   0.0/s)
  get              1608   (  26.6/s)
  list                0   (   0.0/s)
  delete              0   (   0.0/s)
  copy                0   (   0.0/s)
  Class A (billed: put+mpu+list+copy) 1912  (31.6/s). deletes are free on GCS.
  list ops/s is the idle tax: it scales with databases x compaction/retention cadence, 
  not with write volume.

cleanup  : deleting fanout-39434/ from the bucket... 1912 objects removed
```

# rustfs
- bucket: literstream-legacy
- object_count: 1,263
- size: 46.9 MiB
```sh
./fanout_bench.sh
```
```
backend  : http://127.0.0.1:9000/literstream-legacy
workload : 100 databases, 60s, ~20 txns/s aggregate, tick 1000ms, sizes 100-5000 KB
prefix   : fanout-40168/db-<i>

setup    : 100 databases seeded + opened in 2.6s, RSS 75.2 MB  (1000 list, 0 get during open)


===== results =====
databases          : 100
correctness        : 100/100 restored exactly
writes issued      : 600  (~9.9/s aggregate)
RSS after setup    : 75.2 MB  (100 idle drivers, replication not yet running)
peak RSS in run    : 106.6 MB  (steady-state replication of all 100)
peak RSS w/ verify : 115.1 MB  (also restoring all 100 at once; a bench artifact)
CPU total          : 8.34 s
over-fold snapshots: 0
max staged backlog : 0 bytes

object-store ops during the 60s run (delta):
  put              1279   (  21.2/s)
  mpu_init            0   (   0.0/s)
  mpu_part            0   (   0.0/s)
  mpu_complete        0   (   0.0/s)
  get               944   (  15.6/s)
  list                0   (   0.0/s)
  delete              0   (   0.0/s)
  copy                0   (   0.0/s)
  Class A (billed: put+mpu+list+copy) 1279  (21.2/s). deletes are free on GCS.
  list ops/s is the idle tax: it scales with databases x compaction/retention cadence, 
  not with write volume.

cleanup  : deleting fanout-40168/ from the bucket... 1262 objects removed
```

# garage-v2.5.0
```sh
GARAGE_KEYS_DIR=~/dev/gh/workspace/garage/target/keys/default ./fanout_bench.sh
```
```
backend  : http://s3.localhost:9010/default
workload : 100 databases, 60s, ~20 txns/s aggregate, tick 1000ms, sizes 100-5000 KB
prefix   : fanout-69956/db-<i>

setup    : 100 databases seeded + opened in 14.6s, RSS 67.0 MB  (1000 list, 0 get during open)


===== results =====
databases          : 100
correctness        : 100/100 restored exactly
writes issued      : 1080  (~17.9/s aggregate)
RSS after setup    : 67.0 MB  (100 idle drivers, replication not yet running)
peak RSS in run    : 129.3 MB  (steady-state replication of all 100)
peak RSS w/ verify : 143.0 MB  (also restoring all 100 at once; a bench artifact)
CPU total          : 9.93 s
over-fold snapshots: 0
max staged backlog : 0 bytes

object-store ops during the 60s run (delta):
  put              1862   (  30.9/s)
  mpu_init            0   (   0.0/s)
  mpu_part            0   (   0.0/s)
  mpu_complete        0   (   0.0/s)
  get              1762   (  29.2/s)
  list                0   (   0.0/s)
  delete              0   (   0.0/s)
  copy                0   (   0.0/s)
  Class A (billed: put+mpu+list+copy) 1862  (30.9/s). deletes are free on GCS.
  list ops/s is the idle tax: it scales with databases x compaction/retention cadence, 
  not with write volume.

cleanup  : deleting fanout-69956/ from the bucket... 1862 objects removed
```
Space consumed after cleanup
```sh
du -sh target/garage-literstream-legacy 
```
```
 19M	target/garage-literstream-legacy
```

## rustfs-v1.0.5
```sh
./fanout_bench.sh
```
```
backend  : http://localhost:9000/literstream-legacy
workload : 100 databases, 60s, ~20 txns/s aggregate, tick 1000ms, sizes 100-5000 KB
prefix   : fanout-71584/db-<i>

setup    : 100 databases seeded + opened in 14.6s, RSS 69.5 MB  (1000 list, 0 get during open)


===== results =====
databases          : 100
correctness        : 100/100 restored exactly
writes issued      : 960  (~15.0/s aggregate)
RSS after setup    : 69.5 MB  (100 idle drivers, replication not yet running)
peak RSS in run    : 128.0 MB  (steady-state replication of all 100)
peak RSS w/ verify : 138.4 MB  (also restoring all 100 at once; a bench artifact)
CPU total          : 11.57 s
over-fold snapshots: 0
max staged backlog : 0 bytes

object-store ops during the 64s run (delta):
  put              1749   (  27.3/s)
  mpu_init            0   (   0.0/s)
  mpu_part            0   (   0.0/s)
  mpu_complete        0   (   0.0/s)
  get              1649   (  25.8/s)
  list                0   (   0.0/s)
  delete              0   (   0.0/s)
  copy                0   (   0.0/s)
  Class A (billed: put+mpu+list+copy) 1749  (27.3/s). deletes are free on GCS.
  list ops/s is the idle tax: it scales with databases x compaction/retention cadence, 
  not with write volume.

cleanup  : deleting fanout-71584/ from the bucket... 1749 objects removed
```
Space consumed after cleanup
```sh
du -sh target/data/literstream-legacy
```
```
  0B	target/data/literstream-legacy
```
