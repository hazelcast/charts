# Hazelcast Platform Operator Helm Chart

A Helm chart to install the Hazelcast Platform Operator

For more information about the ECK Operator, see:
- [Documentation](https://docs.hazelcast.com/operator/latest/)
- [GitHub repo](https://github.com/hazelcast/hazelcast-platform-operator)

## Quick Start with Hazelcast Platform Operator

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
    $ helm repo update
    $ helm install operator hazelcast/hazelcast-platform-operator --set installCRDs=true