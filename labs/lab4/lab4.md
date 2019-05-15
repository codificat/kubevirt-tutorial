# Lab 5

## Install the Hyperconverged Cluster Operator

In this section, we are going to use the HCO to install all KubeVirt components. For it to work, we have to first apply some manifests that will create the required Custom Resource Definitions (a copy of the manifests should be already available on each student's machine).

All the manifests can be found in the `~/hco`, spend some time exploring them and all the objects they create.

Now, let's begin with the installation.

``` shell
cd ~/hco
kubectl create ns kubevirt-hyperconverged
kubectl config set-context $(kubectl config current-context) --namespace=kubevirt-hyperconverged
kubectl create -f deploy/converged/crds/hco.crd.yaml
kubectl create -f deploy/converged/crds/kubevirt.crd.yaml
kubectl create -f deploy/converged/crds/cdi.crd.yaml
kubectl create -f deploy/converged/crds/cna.crd.yaml
kubectl create -f deploy/converged/crds/ssp.crd.yaml
kubectl create -f deploy/converged/crds/nodemaintenance_crd.yaml
kubectl create -f deploy/converged/crds/kwebui.crd.yaml
kubectl create -f deploy/converged
```

Sample output:

```shell
kubectl get pods -w

NAME                                               READY   STATUS              RESTARTS   AGE
cdi-operator-64fdf8c7db-sgj66                      0/1     ContainerCreating   0          5s
cluster-network-addons-operator-67fcc95fdd-kzn7r   0/1     ContainerCreating   0          6s
hyperconverged-cluster-operator-57c7df48c6-b4dvj   0/1     ContainerCreating   0          5s
kubevirt-ssp-operator-864cdd5b75-dmzzp             0/1     ContainerCreating   0          6s
kubevirt-web-ui-operator-59f778956-stvqd           0/1     ContainerCreating   0          6s
virt-operator-8fd6c4c4c-95c9k                      0/1     ContainerCreating   0          5s
virt-operator-8fd6c4c4c-mwlpq                      0/1     ContainerCreating   0          5s
kubevirt-ssp-operator-864cdd5b75-dmzzp             1/1     Running             0          55s
cluster-network-addons-operator-67fcc95fdd-kzn7r   1/1     Running             0          99s
kubevirt-web-ui-operator-59f778956-stvqd           0/1     Running             0          2m21s
kubevirt-web-ui-operator-59f778956-stvqd           1/1     Running             0          2m28s
hyperconverged-cluster-operator-57c7df48c6-b4dvj   1/1     Running             0          3m8s
cdi-operator-64fdf8c7db-sgj66                      1/1     Running             0          3m24s
virt-operator-8fd6c4c4c-mwlpq                      0/1     Running             0          3m39s
virt-operator-8fd6c4c4c-95c9k                      0/1     Running             0          3m42s
virt-operator-8fd6c4c4c-mwlpq                      1/1     Running             0          3m47s
virt-operator-8fd6c4c4c-95c9k                      1/1     Running             0          3m55s
```

And lastly, apply the HCO CustomResource, which will trigger the deployment of all the components:

```shell
kubectl create -f deploy/converged/crds/hco.cr.yaml
```

Sample output:

```shell
kubectl get pods -w --all-namespaces

NAMESPACE                   NAME                                                     READY   STATUS              RESTARTS   AGE
...

kubevirt-hyperconverged     cdi-apiserver-d88b544bb-nj6zf                            0/1     ContainerCreating   0          5s
kubevirt-hyperconverged     cdi-deployment-6875d8bff8-qx8nm                          0/1     ContainerCreating   0          4s
kubevirt-hyperconverged     cdi-operator-64fdf8c7db-sgj66                            1/1     Running             0          5m24s
kubevirt-hyperconverged     cdi-uploadproxy-cddbb95b-dkkk4                           0/1     ContainerCreating   0          5s
kubevirt-hyperconverged     cluster-network-addons-operator-67fcc95fdd-kzn7r         1/1     Running             0          5m25s
kubevirt-hyperconverged     hyperconverged-cluster-operator-57c7df48c6-b4dvj         1/1     Running             0          5m24s
kubevirt-hyperconverged     kubevirt-ssp-operator-864cdd5b75-dmzzp                   1/1     Running             0          5m25s
kubevirt-hyperconverged     kubevirt-web-ui-operator-59f778956-stvqd                 1/1     Running             0          5m25s
kubevirt-hyperconverged     virt-api-7d6bb69679-25wmh                                0/1     ContainerCreating   0          1s
kubevirt-hyperconverged     virt-api-7d6bb69679-f7f27                                0/1     ContainerCreating   0          1s
kubevirt-hyperconverged     virt-operator-8fd6c4c4c-95c9k                            1/1     Running             0          5m24s
kubevirt-hyperconverged     virt-operator-8fd6c4c4c-mwlpq                            1/1     Running             0          5m24s
linux-bridge                bridge-marker-h86dx                                      0/1     ContainerCreating   0          0s
linux-bridge                kube-cni-linux-bridge-plugin-lg6s8                       0/1     ContainerCreating   0          3s
multus                      kube-multus-ds-amd64-swfd7                               0/1     ContainerCreating   0          4s
node-maintenance-operator   node-maintenance-operator-65f5bd8c5c-knt2j               1/1     Running             0          5m25s
prometheus                  alertmanager-kubevirtlab-prometheus-ope-alertmanager-0   2/2     Running             0          18m
prometheus                  kubevirtlab-grafana-bf9db4bd9-7qndp                      2/2     Running             0          19m
prometheus                  kubevirtlab-kube-state-metrics-6544b5778c-54gz6          1/1     Running             0          19m
prometheus                  kubevirtlab-prometheus-node-exporter-czbtb               1/1     Running             0          19m
prometheus                  kubevirtlab-prometheus-ope-operator-78d5bbf8ff-5vlpn     1/1     Running             0          19m
prometheus                  prometheus-kubevirtlab-prometheus-ope-prometheus-0       3/3     Running             1          18m
kubemacpool-system          kubemacpool-mac-controller-manager-bbd84f76d-cnm7x       0/1     Pending             0          0s
kubemacpool-system          kubemacpool-mac-controller-manager-bbd84f76d-cnm7x       0/1     Pending             0          0s
kubemacpool-system          kubemacpool-mac-controller-manager-bbd84f76d-cnm7x       0/1     ContainerCreating   0          0s

...

kubevirt-hyperconverged     cdi-apiserver-d88b544bb-nj6zf                            0/1     Running             0          9s
kubevirt-hyperconverged     cdi-apiserver-d88b544bb-nj6zf                            1/1     Running             0          13s
kubevirt-hyperconverged     cdi-deployment-6875d8bff8-qx8nm                          0/1     Running                      0          21s
kubevirt-hyperconverged     cdi-deployment-6875d8bff8-qx8nm                          1/1     Running                      0          25s
kubevirt-hyperconverged     cdi-uploadproxy-cddbb95b-dkkk4                           0/1     Running                      0          29s
kubevirt-hyperconverged     cdi-uploadproxy-cddbb95b-dkkk4                           1/1     Running                      0          34s
multus                      kube-multus-ds-amd64-swfd7                               1/1     Running                      0          74s
linux-bridge                kube-cni-linux-bridge-plugin-lg6s8                       1/1     Running                      0          116s
kubevirt-hyperconverged     virt-api-7d6bb69679-f7f27                                0/1     Running                      0          2m1s
kubevirt-hyperconverged     virt-api-7d6bb69679-25wmh                                0/1     Running                      0          2m3s
kubevirt-hyperconverged     virt-api-7d6bb69679-f7f27                                1/1     Running                      0          2m16s
kubevirt-hyperconverged     virt-controller-56577d97b5-dh4bw                         0/1     Pending                      0          0s
kubevirt-hyperconverged     virt-handler-gn8l9                                       0/1     Pending                      0          0s
kubevirt-hyperconverged     virt-controller-56577d97b5-dh4bw                         0/1     Pending                      0          0s
kubevirt-hyperconverged     virt-handler-gn8l9                                       0/1     Pending                      0          0s
kubevirt-hyperconverged     virt-controller-56577d97b5-m88pm                         0/1     Pending                      0          0s
kubevirt-hyperconverged     virt-controller-56577d97b5-m88pm                         0/1     Pending                      0          0s
kubevirt-hyperconverged     virt-controller-56577d97b5-dh4bw                         0/1     ContainerCreating            0          0s
kubevirt-hyperconverged     virt-handler-gn8l9                                       0/1     ContainerCreating            0          0s
kubevirt-hyperconverged     virt-controller-56577d97b5-m88pm                         0/1     ContainerCreating            0          0s
kubevirt-hyperconverged     virt-controller-56577d97b5-dh4bw                         0/1     ContainerCreating            0          7s
kubevirt-hyperconverged     virt-controller-56577d97b5-m88pm                         0/1     ContainerCreating            0          7s
kubevirt-hyperconverged     virt-handler-gn8l9                                       0/1     ContainerCreating            0          7s
kubevirt-hyperconverged     virt-api-7d6bb69679-25wmh                                1/1     Running                      0          2m24s
linux-bridge                bridge-marker-h86dx                                      1/1     Running                      0          2m44s
kubemacpool-system          kubemacpool-mac-controller-manager-bbd84f76d-cnm7x       1/1     Running                      0          3m16s
kubevirt-hyperconverged     virt-controller-56577d97b5-dh4bw                         0/1     Running                      0          68s
kubevirt-hyperconverged     virt-controller-56577d97b5-m88pm                         0/1     Running                      0          71s
kubevirt-hyperconverged     virt-handler-gn8l9                                       1/1     Running                      0          77s
kubevirt-hyperconverged     virt-controller-56577d97b5-dh4bw                         1/1     Running                      0          85s
kubevirt-hyperconverged     virt-controller-56577d97b5-m88pm                         1/1     Running                      0          92s
```

Let's verify we can reach KubeVirt API:

```shell
virtctl version

Client Version: version.Info{GitVersion:"v0.17.0", GitCommit:"c0f960702dce718419a767f3913669f539229ff0", GitTreeState:"clean", BuildDate:"2019-05-05T08:09:14Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{GitVersion:"v0.17.0-46+3d98bf75699585", GitCommit:"3d98bf7569958581328676e8aa27c570be971774", GitTreeState:"clean", BuildDate:"2019-05-14T15:38:59Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
```

This concludes this section, please head to the next one!

[Next Lab](../lab3/lab4.md)\
[Previous Lab](../lab1/lab2.md)\
[Home](../../README.md)
