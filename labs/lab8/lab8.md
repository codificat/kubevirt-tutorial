# Lab 8

## Networking with Multus

In this lab, we will Run Virtual machines with multiple nics by leveraging Multus integration.

Multus CNI enables attaching multiple network interfaces to pods in Kubernetes and has integration with Kubevirt.

**WARN: We've introduced errors in the laboratory to avoid copy/paste without understanding :), enjoy!!**

### Open vSwitch Configuration

Since we are using the ovs cni plugin, we need to configure dedicated Open vSwitch bridges.

We already have a provisioned bridge named `br1`, but in order to provision it manually just execute the next command:

```
ovs-vsctl add-br br1
```

To see the data already provisioned execute this command:

```
ovs-vsctl show
```

Output
```
57b1fe30-b115-45cd-85db-7a205fe60912
    Bridge "br1"
        Port "br1"
            Interface "br1"
                type: internal
        Port "eth1"
            Interface "eth1"
                type: internal
    ovs_version: "2.0.0"
```

In a production setup, we would do the same on each of the cluster nodes and add a dedicated interface to the bridge.

### Create a Network Attachment Definition

a `NetworkAttachmentDefinition` `config` section is a configuration for the CNI plugin where we indicate which bridges to associate to the pod/vm.

```
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: ovs-net-1
  namespace: 'multus'
spec:
  config: '{
      "cniVersion": "0.3.1",
      "type": "ovs",
      "bridge": "br1"
    }'
```

Create a new one, pointing to bridge `br1`:

```
kubectl create -f ~/student-materials/multus_nad_br1.yml
```

### Virtual Machine

For a virtual machine to use multiple interfaces, there are a couple of modifications to the VirtualMachine manifest that are required.

- interfaces
- networks

### Create Virtual Machine

Create two vms named **fedora-multus-1** and **fedora-multus-2**, both with a secondary nic pointing to the previously created bridge/network attachment definition:

```
kubectl create -f ~/student-materials/vm_multus1.yml
kubectl create -f ~/student-materials/vm_multus2.yml
```

In this case, we set running to *True* in the definition of those vms so they will launch with no further action

### Access Virtual Machines

There are multiple ways to access the machine.

You can either use vnc from kubevirt-web-ui, `virtctl` or ssh via the cluster ip address.

Locate the ips of the two vms:

```
kubectl get vmi
```

password is *fedora* as defined in the cloud-init section of the manifest.

```
virtctl console fedora-multus-1
virtctl console fedora-multus-2
```

Confirm that `eth1` is available:

```
[root@fedora-multus-1 ~]# ip a
...OUTPUT...
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 20:37:cf:e0:ad:f1 brd ff:ff:ff:ff:ff:ff
```

### Confirm connectivity

Through cloudinit, we also configured fedora-multus-1 vm to have ip 11.0.0.5 and fedora-multus-1 vm to have ip 11.0.0.6 so try to ping or ssh between them:

```
ping 11.0.0.5
ping 11.0.0.6
```

[Next Lab](../lab9/lab9.md)\
[Previous Lab](../lab7/lab7.md)\
[Home](../../README.md)
