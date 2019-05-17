# Lab 4

## Deploy our first Virtual Machine

```console
$ cd ~/student-materials
$ kubectl config set-context $(kubectl config current-context) --namespace=default
$ kubectl create -f vm_containerdisk.yml
virtualmachine.kubevirt.io/vm1 created
```

Check what just happened:

```console
$ kubectl get vm
NAME   AGE   RUNNING   VOLUME
vm1    24s   false
```

Notice the *RUNNING* field, the VM is stopped. That's actually coming from its definition we just applied:

```yaml
...
spec:
  running: false
...
```

Let's use *virtctl* now to actually start our virtual machine:

```console
$ virtctl start vm1
VM vm1 was scheduled to start
```

A *virt-launcher* Pod should be starting, which will spawn the actual virtual machine:

```console
$ kubectl get pods -w
NAME                      READY   STATUS    RESTARTS   AGE
virt-launcher-vm1-2qflc   0/2     Running   0          12s
virt-launcher-vm1-2qflc   0/2     Running   0          12s
virt-launcher-vm1-2qflc   1/2     Running   0          17s
virt-launcher-vm1-2qflc   2/2     Running   0          23s
```

We can also use *kubectl* to check the virtual machine and its instance:

```console
$ kubectl get vm vm1
NAME   AGE   RUNNING   VOLUME
vm1    19m   true
$ kubectl get vmi vm1
NAME   AGE     PHASE     IP            NODENAME
vm1    3m49s   Running   10.244.0.22   sjr-kubemaster.deshome.net
```

We can also use *kubectl* to check the virtual machine and its instance:

```console
$ kubectl get vm vm1
NAME   AGE   RUNNING   VOLUME
vm1    19m   true
$ kubectl get vmi vm1
NAME   AGE     PHASE     IP            NODENAME
vm1    3m49s   Running   10.244.0.22   sjr-kubemaster.deshome.net
```

Using *virtctl* we can connect to the VM's console as follows:

```console
$ virtctl console vm1
Successfully connected to vm1 console. The escape sequence is ^]

Fedora 29 (Cloud Edition)
Kernel 4.18.16-300.fc29.x86_64 on an x86_64 (ttyS0)

vm1 login: fedora
Password: fedora

[fedora@vm1 ~]$ ping -c 1 google.com
PING google.com (172.217.16.238) 56(84) bytes of data.
64 bytes from mad08s04-in-f14.1e100.net (172.217.16.238): icmp_seq=1 ttl=54 time=22.1 ms

--- google.com ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 22.098/22.098/22.098/0.000 ms
[fedora@vm1 ~]$ exit

Fedora 29 (Cloud Edition)
Kernel 4.18.16-300.fc29.x86_64 on an x86_64 (ttyS0)

vm1 login:
```

**NOTE**: To exit the console press *Ctrl+]*

## Recap

**WRITE A SMALL SUMMARY OF WHAT HAVE JUST HAPPENED**

This concludes this section of the lab.

[Next Lab](../lab6/lab6.md)\
[Previous Lab](../lab4/lab4.md)\
[Home](../../README.md)
