# NOTES for OpenSouthCode

* Replace OCP by Kubernetes
* Include Prometheus Operator (missing)
* 2nd Network for multus (This should be already there)
* How many VMs ?
  * 1 Master - No migrations, make the master schedulable
  * 1 Master + 1 Worker - Could include migrations
* Storage (TBD)
  * local storage
    * self-contained solution
  * Shared NFS server ?
    * Easy to set up and manage
    * Low infra requirements
  * Shared Ceph Cluster (standalone)? 
  * Dedicated Rook cluster by student ?
* Besides deploying/exploring HCO, the rest could be done from the UI (?)
* Labs
  * Deploy KubeVirt (HCO) and explore the outcome
    * Add on the VMs a HCO repo clone with a know working tag/commit
    * Explore
      * linux-bridge
      * multus
      * hyperconverged-kubevirt
  * Deploy a first containerDisk based VM
    * No external storage needs
    * Could explore metrics already with this one
  * Import a VM disk using CDI
    * Requires storage
  * Deploy a VM using a DataVolume with source the image imported in the previous lab
  * Deploy a VM (or the same) with an additional network (multus + OVS)

## TODO

* Expose Kubevirt Web UI
* Create node-maintenance-operator NS <- Keep an eye upstream for fixes
