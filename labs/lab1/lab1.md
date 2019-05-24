# Lab 1

## Student Connection Process

In this section, we'll review how to connect to your instance.

### Find your GCP Instance

This lab is designed to accommodate many students. As a result, each one will be given a VM running on GCP with nested virtualization, 4 vcpus and 16GiB of RAM. No previous GCP knowledge is required.

The naming convention for the lab VMs is: **kubevirtlab-\<number\>.gce.sexylinux.net**. You will be assigned a number by the instructor.

All the boxes have been provisioned with an SSH public key, so you can SSH into your instance using the ssh key located into [RSA](./RSA) folder.

```console
$ wget https://raw.githubusercontent.com/tripledes/kubevirt-tutorial/master/labs/lab1/RSA/cnv_lab_rsa
$ chmod 600 cnv_lab_rsa
$ ssh-add cnv_lab_rsa
```

NOTE: The password for this RSA is 'fedora'

### Connecting to your Instance

This lab should be performed on **YOUR ASSIGNED INSTANCE** only, as *kubevirt-user* user, unless otherwise instructed.

**_NOTE_**: Please be respectful and only connect to your assigned instance. All instances on this lab use the **same** public key, so you could accidentally connect to the wrong system. If you have any issues, please inform an instructor/s.

```console
$ ssh -i cnv_lab_rsa kubevirt-user@kubevirtlab-<number>.gce.sexylinux.net

The authenticity of host 'kubevirtlab-2.gce.sexylinux.net (35.188.64.157)' can't be established.
ECDSA key fingerprint is SHA256:36+hPGyR9ZxYRRfMngif8PXLR1yoVFCGZ1kylpNE8Sk.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'kubevirtlab-2.gce.sexylinux.net,35.188.64.157' (ECDSA) to the list of known hosts.
```

This means the host you are about to connect to is not in your *known_hosts* list. Accept the fingerprint for connecting to the instance.

This concludes this section of the lab.

[Next Lab](../lab2/lab2.md)\
[Previous Lab](../lab0/lab0.md)\
[Home](../../README.md)
