# Lab 3

## Lab overview

In this section we're going to deploy the following three components:

* [KubeVirt Operator](https://github.com/kubevirt/kubevirt)
  * Provides a set of CRDs and components required to manage the VMs
* [CDI Operator](https://github.com/kubevirt/containerized-data-importer)
  * Another set of CRDs to help ease the storage management for KubeVirt VMs
* [KubeVirt Web UI](https://github.com/kubevirt/web-ui)
  * Provides a graphical environment to manage VM based workloads


## Install the KubeVirt Operator

Starting with the KubeVirt Operator, being connected to your assigned instance, execute the following steps.

```console
$ cd ~/kubevirt/kubevirt-operator-manifests
$ kubectl create -f kubevirt-operator.yaml
$ kubectl config set-context $(kubectl config current-context) --namespace=kubevirt
$ kubectl wait deployment virt-operator --for condition=available
deployment.extensions/virt-operator condition met

$ kubectl create -f kubevirt-cr.yaml
$ kubectl wait deployment -l app.kubernetes.io/managed-by=kubevirt-operator --for condition=available
deployment.extensions/virt-api condition met
deployment.extensions/virt-controller condition met
```

Let's explore what's being deployed:

```console
$ kubectl get all -l kubevirt.io

NAME                                   READY   STATUS    RESTARTS   AGE
pod/virt-api-58554748d5-5lzsd          1/1     Running   0          100m
pod/virt-api-58554748d5-rg5rk          1/1     Running   0          100m
pod/virt-controller-76765f49f9-wphx9   1/1     Running   0          99m
pod/virt-controller-76765f49f9-xdhlp   1/1     Running   0          99m
pod/virt-handler-4nv45                 1/1     Running   0          99m
pod/virt-operator-5ddb4674b9-cj2s6     1/1     Running   0          101m
pod/virt-operator-5ddb4674b9-kvd8r     1/1     Running   0          101m

NAME                                  TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/kubevirt-prometheus-metrics   ClusterIP   10.110.103.5   <none>        443/TCP   100m
service/virt-api                      ClusterIP   10.97.212.57   <none>        443/TCP   100m

NAME                          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/virt-handler   1         1         1       1            1           <none>          99m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/virt-api          2/2     2            2           100m
deployment.apps/virt-controller   2/2     2            2           99m
deployment.apps/virt-operator     2/2     2            2           101m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/virt-api-58554748d5          2         2         2       100m
replicaset.apps/virt-controller-76765f49f9   2         2         2       99m
replicaset.apps/virt-operator-5ddb4674b9     2         2         2       101m
```

## Install the CDI operator

```console
$ cd ~/kubevirt/cdi-operator-manifests
$ kubectl create -f cdi-operator.yaml
$ kubectl config set-context $(kubectl config current-context) --namespace=cdi
$ kubectl wait deployment cdi-operator --for condition=available
deployment.extensions/cdi-operator condition met

$ kubectl create -f cdi-operator-cr.yaml
$ kubectl wait deployment -l cdi.kubevirt.io --for condition=available
deployment.extensions/cdi-apiserver condition met
deployment.extensions/cdi-deployment condition met
deployment.extensions/cdi-uploadproxy condition met
```

Now, let's see what we've got deployed:

```console
$ kubectl get all
NAME                                  READY   STATUS    RESTARTS   AGE
pod/cdi-apiserver-d88b544bb-cbm27     1/1     Running   0          85m
pod/cdi-deployment-6875d8bff8-qnp4p   1/1     Running   0          85m
pod/cdi-operator-5f58bbbbcf-gmk2t     1/1     Running   0          87m
pod/cdi-uploadproxy-cddbb95b-6dzkd    1/1     Running   0          85m

NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
service/cdi-api           ClusterIP   10.103.200.116   <none>        443/TCP   85m
service/cdi-uploadproxy   ClusterIP   10.103.55.72     <none>        443/TCP   85m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/cdi-apiserver     1/1     1            1           85m
deployment.apps/cdi-deployment    1/1     1            1           85m
deployment.apps/cdi-operator      1/1     1            1           87m
deployment.apps/cdi-uploadproxy   1/1     1            1           85m

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/cdi-apiserver-d88b544bb     1         1         1       85m
replicaset.apps/cdi-deployment-6875d8bff8   1         1         1       85m
replicaset.apps/cdi-operator-5f58bbbbcf     1         1         1       87m
replicaset.apps/cdi-uploadproxy-cddbb95b    1         1         1       85m
```

## Install the KubeVirt Web UI

```console
$ cd ~/kubevirt/kubevirt-ui-custom-manifests
$ kubectl config set-context $(kubectl config current-context) --namespace=kubevirt
$ kubectl create -f kubevirt_ui.yml
$ kubectl wait pod -l app=kubevirt-web-ui --for condition=Ready --timeout=180s
pod/kubevirt-web-ui-qmpwl condition met
```

Check the three resources deployed for the Web UI:

```console
$ kubectl get all -l app=kubevirt-web-ui
NAME                        READY   STATUS    RESTARTS   AGE
pod/kubevirt-web-ui-qmpwl   1/1     Running   0          78m

NAME                                    DESIRED   CURRENT   READY   AGE
replicationcontroller/kubevirt-web-ui   1         1         1       78m

NAME                      TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/kubevirt-web-ui   NodePort   10.96.35.132   <none>        9000:30000/TCP   78m
```

**NOTE**: Pay special attention to the kubevirt-web-ui service, the UI should be available on your node's assigned hostname at port 30000.

Let's verify we can reach KubeVirt API:

```console
$ virtctl version

Client Version: version.Info{GitVersion:"v0.17.0", GitCommit:"c0f960702dce718419a767f3913669f539229ff0", GitTreeState:"clean", BuildDate:"2019-05-05T08:09:14Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{GitVersion:"v0.17.0", GitCommit:"a067696ed6c25b0eab9dfcd01bbdc045f500f8ca", GitTreeState:"clean", BuildDate:"2019-05-06T14:58:11Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
```

This concludes this section, please head to the next one!

[Next Lab](../lab4/lab4.md)\
[Previous Lab](../lab2/lab2.md)\
[Home](../../README.md)
