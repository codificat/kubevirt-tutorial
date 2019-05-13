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

**COPY SAMPLE HERE**
```

And lastly, apply the HCO CustomResource, which will trigger the deployment of all the components:

```shell
kubectl create -f deploy/converged/crds/hco.cr.yaml
```

Sample output:

```shell
kubectl get pods -w --all-namespaces

**COPY OUTPUT SAMPLE HERE**
```
