# Lab 2

## Review Kubernetes Environment

For the sake of time, some of the required setup has already been taken care of on your instance.

The following was done as part of the deployment:

- Install Kubernetes prerequisites
- Deploy Kubernetes using *kubeadm*
- Deploy OVS CNI
- Deploy local volumes provisioner
- Checked out the HyperConverged Cluster Operator at $HOME

Let's ask for a cluster status:

```shell
kubectl version
```

Output should be similar to the following:

```shell
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-08T17:11:31Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-08T17:02:58Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
```

Now let's check the physical volumes are ready and available:

```shell
kubectl get pv
NAME                CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
local-pv-234582fe   10229Mi    RWO            Delete           Available           local-volumes            2d
local-pv-5d33c489   10229Mi    RWO            Delete           Available           local-volumes            2d
local-pv-6035a584   10229Mi    RWO            Delete           Available           local-volumes            2d
local-pv-a56cebb5   10229Mi    RWO            Delete           Available           local-volumes            2d
local-pv-ba09b443   10229Mi    RWO            Delete           Available           local-volumes            2d
```

And finally, let's check that Prometheus is running and Grafana is exposed:

```shell
NAME                                                         READY   STATUS    RESTARTS   AGE
pod/alertmanager-kubevirtlab-prometheus-ope-alertmanager-0   2/2     Running   0          2d
pod/kubevirtlab-grafana-bf9db4bd9-r8pmt                      2/2     Running   0          2d
pod/kubevirtlab-kube-state-metrics-6544b5778c-gvqc9          1/1     Running   0          2d
pod/kubevirtlab-prometheus-node-exporter-8dp4d               1/1     Running   0          2d
pod/kubevirtlab-prometheus-ope-operator-78d5bbf8ff-rx9kv     1/1     Running   0          2d
pod/prometheus-kubevirtlab-prometheus-ope-prometheus-0       3/3     Running   0          2d

NAME                                              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/alertmanager-operated                     ClusterIP   None             <none>        9093/TCP,6783/TCP   2d
service/kubevirtlab-grafana                       ClusterIP   10.96.1.202      <none>        80/TCP              2d
service/kubevirtlab-grafana-nodeport              NodePort    10.111.14.110    <none>        3000:30300/TCP      2d
service/kubevirtlab-kube-state-metrics            ClusterIP   10.101.96.232    <none>        8080/TCP            2d
service/kubevirtlab-prometheus-node-exporter      ClusterIP   10.99.86.74      <none>        9100/TCP            2d
service/kubevirtlab-prometheus-ope-alertmanager   ClusterIP   10.105.253.180   <none>        9093/TCP            2d
service/kubevirtlab-prometheus-ope-operator       ClusterIP   10.109.209.37    <none>        8080/TCP            2d
service/kubevirtlab-prometheus-ope-prometheus     ClusterIP   10.109.224.249   <none>        9090/TCP            2d
service/prometheus-operated                       ClusterIP   None             <none>        9090/TCP            2d

NAME                                                  DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/kubevirtlab-prometheus-node-exporter   1         1         1       1            1           <none>          2d

NAME                                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kubevirtlab-grafana                   1/1     1            1           2d
deployment.apps/kubevirtlab-kube-state-metrics        1/1     1            1           2d
deployment.apps/kubevirtlab-prometheus-ope-operator   1/1     1            1           2d

NAME                                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/kubevirtlab-grafana-bf9db4bd9                    1         1         1       2d
replicaset.apps/kubevirtlab-kube-state-metrics-6544b5778c        1         1         1       2d
replicaset.apps/kubevirtlab-prometheus-ope-operator-78d5bbf8ff   1         1         1       2d

NAME                                                                    READY   AGE
statefulset.apps/alertmanager-kubevirtlab-prometheus-ope-alertmanager   1/1     2d
statefulset.apps/prometheus-kubevirtlab-prometheus-ope-prometheus       1/1     2d
```

This concludes this section of the lab.

[Next Lab](../lab3/lab3.md)\
[Previous Lab](../lab1/lab1.md)\
[Home](../../README.md)
