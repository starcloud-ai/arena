### 0.1.0

* support mpi operator


### 0.2.0

* Fix max_slots

* Make the job launcher running on the master

### 0.3.0

* Fix tensorboard affinity issue

### 0.4.0

* Support tensorboard loading event log from hdfs path

### 0.5.0

* Support RoCE by using https://github.com/Mellanox/k8s-rdma-sriov-dev-plugin, only support hostNetwork now.

### 0.6.0

* add annotations, for cloud provider customization

### 0.7.0

* Make Hostnetwork as false by default


### 0.8.0

* Fix MPI Job backofflimit typo


### 0.9.0

* Fix MPI Job Tensorboard issue when using `--data`


### 0.10.0

* Fix hostnetwork issue which is introduced by ENI

### 0.11.0

* Remove -mpijob from mpijob name

### 0.12.0

* Fix tensorboard not work on master node

### 0.13.0

* Support Tensorboard for Ingress 

### 0.14.0

* Update git-sync image to fix could not lock config file issue


### 0.15.0

* Add resource limits for mpi-launcher

### 0.16.0

* Add PodSecurityContext support for RunAsUser, RunAsGroup, RunAsNonRoot, SupplementalGroups

### 0.17.0

* Add Priority Class