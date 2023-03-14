# Hazelcast Helm Charts

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/hazelcast)](https://artifacthub.io/packages/search?repo=hazelcast)

This is a repository for Hazelcast Helm Charts. For more information about installing and using Helm, see its
[README.md](https://github.com/helm/helm/blob/main/README.md). To get a quick introduction to Charts see this [chart document](https://helm.sh/docs/intro/quickstart/).

See corresponding page from below for each chart for step-by-step installation:

- [Hazelcast-Platform-Operator](https://docs.hazelcast.com/operator/latest/get-started#step-1-deploy-hazelcast-platform-operator)
- [Hazelcast](https://docs.hazelcast.com/hazelcast/latest/kubernetes/helm-hazelcast-chart)
- [Hazelcast Enterprise](https://docs.hazelcast.com/hazelcast/latest/kubernetes/helm-hazelcast-enterprise-chart)

## Quick Start with Hazelcast Platform Operator

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
    $ helm repo update
    $ helm install operator hazelcast/hazelcast-platform-operator --set installCRDs=true

The documentation for the Hazelcast Platform Operator can be found [here](https://docs.hazelcast.com/operator/latest/get-started#step-1-deploy-hazelcast-platform-operator).

## How to find us?

In case of any question or issue, please raise a GH issue, send an email to [Hazelcast Google Groups](https://groups.google.com/forum/#!forum/hazelcast) or contact as directly via [Hazelcast Slack](https://slack.hazelcast.com).
