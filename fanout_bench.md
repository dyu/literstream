```sh
FANOUT_LOCAL=target/fanout_bench/local ./target/release/examples/fanout_bench
```
```
backend  : LocalFileSystem(target/fanout_bench/local)
workload : 100 databases, 60s, ~20 txns/s aggregate, tick 1000ms, sizes 100-5000 KB
prefix   : fanout-20759/db-<i>

setup    : 100 databases seeded + opened in 1.1s, RSS 31.7 MB  (1000 list, 0 get during open)


===== results =====
databases          : 100
correctness        : 100/100 restored exactly
writes issued      : 1140  (~18.8/s aggregate)
RSS after setup    : 31.7 MB  (100 idle drivers, replication not yet running)
peak RSS in run    : 64.0 MB  (steady-state replication of all 100)
peak RSS w/ verify : 80.0 MB  (also restoring all 100 at once; a bench artifact)
CPU total          : 11.84 s
over-fold snapshots: 0
max staged backlog : 0 bytes

object-store ops during the 60s run (delta):
  put              2014   (  33.3/s)
  mpu_init            0   (   0.0/s)
  mpu_part            0   (   0.0/s)
  mpu_complete        0   (   0.0/s)
  get              1843   (  30.5/s)
  list                0   (   0.0/s)
  delete              0   (   0.0/s)
  copy                0   (   0.0/s)
  Class A (billed: put+mpu+list+copy) 2014  (33.3/s). deletes are free on GCS.
  list ops/s is the idle tax: it scales with databases x compaction/retention cadence, 
  not with write volume.

cleanup  : deleting fanout-20759/ from the bucket... 2014 objects removed
```
