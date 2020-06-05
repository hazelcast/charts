# Hazelcast Helm Charts

This is a repository for Hazelcast Helm Charts. For more information about installing and using Helm, see its
[README.md](https://github.com/kubernetes/helm/tree/master/README.md). To get a quick introduction to Charts see this [chart document](https://helm.sh/docs/intro/quickstart/).

We also have specific instructions for [IBM Cloud](IBM_Cloud.md).

## Quick Start

Add the Hazelcast repository:

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
    $ helm repo update

Then, you can install the charts by:

    $ helm install my-release hazelcast/<chart>

The available list of charts can be found in the [stable](stable) directory.

For users who already added `hazelcast` repo to their local helm client before; you need to run `helm repo add` command again to use latest charts at the new chart repo:

    $ helm repo list
    NAME            URL
    hazelcast       https://hazelcast.github.io/charts/
    ...

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/

    $ helm repo list
    NAME            URL
    hazelcast       https://hazelcast-charts.s3.amazonaws.com/
    ...

Please note that if `hazelcast-enterprise` (or `hazelcast-jet-enterprise`) chart is used, hazelcast enterprise license key must be passed to the helm chart as below. You can contact sales@hazelcast.com for a trial license key.

	$ helm install my-release --set hazelcast.licenseKey=$HAZELCAST_ENTERPRISE_LICENSE_KEY hazelcast/hazelcast-enterprise


## Troubleshooting in Kubernetes Environments

If you have Helm installed in your system, you can start deploying Hazelcast Helm Charts to your kubernetes cluster. This is the list of some common problems you might face while deploying Hazelcast.

### Why is Management Center EXTERNAL-IP not assigned?

[Minikube](https://github.com/kubernetes/minikube) is a tool that makes it easy to run Kubernetes locally. However, It does not come with LoadBalancer so Management Center can't be accessible with external IP.

You can see below that EXTERNAL-IP is pending when you install hazelcast helm charts via `helm install` and execute `kubectl get services` right after.

```
NAME                                                   TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes                                     ClusterIP      10.96.0.1       <none>        443/TCP          3h
service/littering-pig-hazelcast-enterprise             ClusterIP      10.98.41.236    <none>        5701/TCP         3h
service/littering-pig-hazelcast-enterprise-mancenter   LoadBalancer   10.104.97.143   <pending>     8080:30145/TCP   3h
```

However, you can still reach Hazelcast Management Center with the http://MINIKUBE_IP:30145 for the case above. `$(minikube ip)` is the command to retrieve minikube IP address.

### "cluster-admin" not found

In some Kubernetes Clusters, RBAC might not be enabled by default so you might end up seeing RBAC related error while helm install.

```
Error: release funky-woodpecker failed: roles.rbac.authorization.k8s.io “funky-woodpecker-hazelcast-enterprise” is forbidden: attempt to grant extra privileges: [PolicyRule{APIGroups:[“”], Resources:[“endpoints”], Verbs:[“get”]} PolicyRule{APIGroups:[“”], Resources:[“endpoints”], Verbs:[“list”]}] user=&{system:serviceaccount:kube-system:tiller 411da847-9999-11e8-bf5e-ba0dc6d88758 [system:serviceaccounts system:serviceaccounts:kube-system system:authenticated] map[]} ownerrules=[] ruleResolutionErrors=[clusterroles.rbac.authorization.k8s.io “cluster-admin” not found]
```

In that case, you need either enable debug or pass `--set rbac.create=false` into your `helm install` command.

### Why is Management Center Pod in Pending state?

```
NAME                                                            READY     STATUS              RESTARTS   AGE
dining-serval-hazelcast-enterprise-0                            1/1       Running             0          50s
dining-serval-hazelcast-enterprise-1                            0/1       Running             0          19s
dining-serval-hazelcast-enterprise-mancenter-5f56d785dc-h5slc   0/1       Pending             0          50s
```
If you see your Management Center in a Pending State as above, you can try a few things for troubleshooting.

Firstly, you can check if Persistent Volume and PersistentVolumeClaim are already bound.

```
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM                                                  STORAGECLASS   REASON    AGE
pvc-7f4baaff-a63d-11e8-9df7-0800277c0239   8Gi        RWO            Delete           Bound     default/mouthy-alpaca-hazelcast-enterprise-mancenter   standard                 4d

$ kubectl get pvc
NAME                                           STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mouthy-alpaca-hazelcast-enterprise-mancenter   Bound     pvc-7f4baaff-a63d-11e8-9df7-0800277c0239   8Gi        RWO            standard       4d
```

You can see they are bound as above. If they are not, this is the list of potential problems you might be having.

**Creating Storage Class**

Some Kubernetes Providers do not offer default storage class so you have to create one and pass it to helm installation.

Create `storage.yaml` file and apply via `kubectl apply -f storage.yaml`

```
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  zones: us-west-2a, us-west-2b, us-west-2c
```


Use storage class name defined in the storage.yaml file in helm installation.

```
$ helm install my-release --set mancenter.persistence.storageClass=standard hazelcast/<chart>
```
**Persistent Volume Availability Zone**

[AWS EKS](https://aws.amazon.com/eks/) requires your volume to be in the same Availability Zone as Kubernetes Nodes that Management Center Pod is running.
Otherwise, Management Center Pod will be stuck in pending state. You can check `failure-domain.beta.kubernetes.io/zone` labels on the Kubernetes Nodes and Persistent Volume and see PersistentVolume is in one of the node's Availability Zone.

```
$ kubectl get no --show-labels
NAME                                            STATUS    ROLES     AGE       VERSION   LABELS
ip-192-168-101-236.us-west-2.compute.internal   Ready     <none>    42m       v1.10.3   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/instance-type=t2.medium,beta.kubernetes.io/os=linux,failure-domain.beta.kubernetes.io/region=us-west-2,failure-domain.beta.kubernetes.io/zone=us-west-2a,kubernetes.io/hostname=ip-192-168-101-236.us-west-2.compute.internal
ip-192-168-245-179.us-west-2.compute.internal   Ready     <none>    42m       v1.10.3   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/instance-type=t2.medium,beta.kubernetes.io/os=linux,failure-domain.beta.kubernetes.io/region=us-west-2,failure-domain.beta.kubernetes.io/zone=us-west-2c,kubernetes.io/hostname=ip-192-168-245-179.us-west-2.compute.internal
```

```
$ kubectl get pv --show-labels
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM                                                  STORAGECLASS   REASON    AGE       LABELS
pvc-539749c4-9f31-11e8-b9d0-0af5b0ce3266   8Gi        RWO            Delete           Bound     default/dining-serval-hazelcast-enterprise-mancenter   standard                 30s       failure-domain.beta.kubernetes.io/region=us-west-2,failure-domain.beta.kubernetes.io/zone=us-west-2c
```

You need to reinstall hazelcast helm chart until you have both PersistentVolume and Kubernetes Node in the same Availability Zone.

**Persistent Volume Creation Time**

Creating Persistent Volume in some Kubernetes Environments take up to 5 minutes so you can wait for sometime to see if Persistent Volume is created.

```
$ kubectl get pv --watch
```
If you see Persistent Volume created, your Management Center Pod will be turning `Running` state soon.

**Persistence Volume Claim Clean Up**

Deleting the helm release of Hazelcast chart will not automatically delete the PVCs. To see the the PVCs run:

```
$ kubectl get pvc
```

To delete them run:

```
$ kubectl delete pvc <name-of-the-pvc>
```

## How to find us?

In case of any question or issue, please raise a GH issue, send an email to [Hazelcast Google Groups](https://groups.google.com/forum/#!forum/hazelcast) or contact as directly via [Hazelcast Slack](https://slack.hazelcast.com).
