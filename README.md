# Hazelcast Helm Charts

This is a repository for Hazelcast Helm Charts. For more information about installing and using Helm, see its
[README.md](https://github.com/kubernetes/helm/tree/master/README.md). To get a quick introduction to Charts see this [chart document](https://github.com/kubernetes/helm/blob/master/docs/charts.md).

Note that the structure and style of this repository and the Helm Charts themselves is similar to the [Official Helm Chart repository](https://github.com/helm/charts).

## Quick Start

Add the Hazelcast repository:

    $ helm repo add hazelcast https://hazelcast.github.io/charts/
    $ helm repo update

Then, you can install the charts by:

    $ helm install hazelcast/<chart>

The available list of charts can be found in the [stable](stable) directory.

## Helm & Tiller

If you don't have `helm` in your system, you can download and install it from [helm github project page](https://github.com/helm/helm#install).

Once you install helm command line tool, you need a Tiller service running in your kubernetes cluster. Following is the set of commands to start Tiller Service.

```
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-admin-binding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account=tiller
```

## Kubernetes Environments

Following Kubernetes Environments are supported by Hazelcast Helm Charts. You need to make sure Helm and Tiller is configured correctly in your kubernetes cluster.

# Minikube

[Minikube](https://github.com/kubernetes/minikube) is a tool that makes it easy to run Kubernetes locally. It does not come with LoadBalancer so Management Center can't be accesible with external IP. 

You can see below that EXTERNAL-IP is pending when you install hazelcast helm charts via `helm install` and execute `kubectl get services` right after.

```
NAME                                                   TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes                                     ClusterIP      10.96.0.1       <none>        443/TCP          3h
service/littering-pig-hazelcast-enterprise             ClusterIP      10.98.41.236    <none>        5701/TCP         3h
service/littering-pig-hazelcast-enterprise-mancenter   LoadBalancer   10.104.97.143   <pending>     8080:30145/TCP   3h
```

However, you can still reach Hazelcast Management Center with the http://MINIKUBE_IP:30145/hazelcast-mancenter for the case above. `$(minikube ip)` is the command to retrieve minikube IP address.

# Azure Kubernetes Service (AKS)

[Azure Kubernetes Service](https://azure.microsoft.com/en-us/services/kubernetes-service/) is a fully managed Kubernetes container orchestration service offered by Microsoft. 

`helm install --set hazelcast.licenseKey=$HAZELCAST_ENTERPRISE_LICENSE_KEY --set rbac.create=false hazelcast/hazelcast-enterprise`

# Google Kubernetes Engines (GKE)

[Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/) is a managed, production-ready environment for deploying containerized applications

`helm install --set hazelcast.licenseKey=$HAZELCAST_ENTERPRISE_LICENSE_KEY hazelcast/hazelcast-enterprise`

## How to find us?

In case of any question or issue, please raise a GH issue, send an email to [Hazelcast Google Groups](https://groups.google.com/forum/#!forum/hazelcast) or contact as directly via [Hazelcast Gitter](https://gitter.im/hazelcast/hazelcast).


 
