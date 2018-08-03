# Hazelcast Helm Charts

This is a repository for Hazelcast Helm Charts. For more information about installing and using Helm, see its
[README.md](https://github.com/kubernetes/helm/tree/master/README.md). To get a quick introduction to Charts see this [chart document](https://github.com/kubernetes/helm/blob/master/docs/charts.md).

Note that the structure and style of this repository and the Helm Charts themselves is similar to the [Official Helm Chart repository](https://github.com/helm/charts).

## How do I install these charts?

Add the Hazelcast repository:

    $ helm repo add hazelcast https://hazelcast.github.io/charts/
    $ helm repo update

Then, you can install the charts by:

    $ helm install hazelcast/<chart>

## How to find us?

In case of any question or issue, please raise a GH issue or contact as directly via [Hazelcast Gitter](https://gitter.im/hazelcast/hazelcast).
