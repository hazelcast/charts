# Hazelcast Jet Enterprise

The Hazelcast Jet Enterprise provides critical management features for scaling in-memory event stream processing across your IT landscape,including Management Center, Security Suite, Lossless Recovery, Rolling Job upgrades, and Enterprise PaaS Deployment Environments.

Hazelcast Jet Enterprise is designed to run in any cloud with Discovery Service Provider Interfaces for AWS, Azure, Apache jclouds, Consul, etcd, Eureka, Heroku, Kubernetes, and Zookeeper. It provides native integrations for IaaS environments AWS and Azure Marketplaces as well as PaaS environments Pivotal® Cloud Foundry and Red Hat OpenShift Container Platform. Hazelcast Jet Enterprise also includes deployment integrations for Docker and Kubernetes.

Visit [Hazelcast Jet Enterprise](https://hazelcast.com/products/jet/enterprise/) to learn more about the architecture, road-map and use cases.

## Quick Start

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
    $ helm repo update
    $ helm install my-release hazelcast/hazelcast-jet-enterprise        # Helm 3
    $ helm install --name my-release hazelcast/hazelcast-jet-enterprise # Helm 2

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

## Introduction

This chart bootstraps a [Hazelcast Jet Enterprise](https://github.com/hazelcast/hazelcast-jet-docker) and [Hazelcast Jet Management Center](https://github.com/hazelcast/hazelcast-jet-management-center-docker) deployments on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

-   Kubernetes 1.9+

## Installing the Chart

To install the chart with the release name `my-release`:

    $ helm install my-release hazelcast/hazelcast-jet-enterprise        # Helm 3
    $ helm install --name my-release hazelcast/hazelcast-jet-enterprise # Helm 3

The command deploys Hazelcast Jet Enterprise on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

    $ helm delete my-release

The command removes all the Kubernetes components associated with thechart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Hazelcast chart and their default values.

|Parameter|Description|Default|
|--- |--- |--- |
|image.repository|Hazelcast Jet Image name|hazelcast/hazelcast-jet-enterprise|
|image.tag|Hazelcast Jet Image tag|{VERSION}|
|image.pullPolicy|Image pull policy|IfNotPresent|
|image.pullSecrets|Specify docker-registry secret names as an array|nil|
|cluster.memberCount|Number of Hazelcast Jet members|2|
|jet.licenseKey|License Key for Hazelcast Jet Enterprise|nil|
|jet.licenseKeySecretName|Kubernetes Secret Name, where Hazelcast Jet Enterprise Key is stored (can be used instead of licenseKey)|nil|
|jet.javaOpts|Additional JAVA_OPTS properties for Hazelcast Jet member|nil|
|jet.loggingLevel|Level of Hazelcast Jet logs (SEVERE, WARNING, INFO, CONFIG, FINE, FINER, and FINEST); note that changing this value requires setting securityContext.runAsUser to nil|
|jet.yaml.hazelcast-jet and jet.yaml.hazelcast|Hazelcast Jet and IMDG YAML configurations (hazelcast-jet.yaml and hazelcast.yaml embedded into values.yaml)|{DEFAULT_JET_YAML} and {DEFAULT_HAZELCAST_YAML}|
|jet.configurationFiles|Hazelcast configuration files|nil|
|hostPort|Port under which Hazelcast Jet PODs are exposed on the host machines|nil|
|affinity|Hazelcast Node affinity|nil|
|tolerations|Hazelcast Node tolerations|nil|
|nodeSelector|Hazelcast Node labels for pod assignment|nil|
|gracefulShutdown.enabled|Turn on and off Graceful Shutdown|true|
|gracefulShutdown.maxWaitSeconds|Maximum time to wait for the Hazelcast Jet POD to shut down|600|
|livenessProbe.enabled|Turn on and off liveness probe|true|
|livenessProbe.initialDelaySeconds|Delay before liveness probe is initiated|30|
|livenessProbe.periodSeconds|How often to perform the probe|10|
|livenessProbe.timeoutSeconds|When the probe times out|5|
|livenessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|livenessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|livenessProbe.path|URL path that will be called to check liveness.|/hazelcast/health/node-state|
|livenessProbe.port|Port that will be used in liveness probe calls.|nil|
|livenessProbe.scheme|HTTPS or HTTP scheme.|HTTP|
|readinessProbe.enabled|Turn on and off readiness probe|true|
|readinessProbe.initialDelaySeconds|Delay before readiness probe is initiated|30|
|readinessProbe.periodSeconds|How often to perform the probe|10|
|readinessProbe.timeoutSeconds|When the probe times out|1|
|readinessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|readinessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|readinessProbe.path|URL path that will be called to check readiness.|/hazelcast/health/ready|
|readinessProbe.port|Port that will be used in readiness probe calls.|nil|
|readinessProbe.scheme|HTTPS or HTTP scheme.|HTTP|
|resources|CPU/Memory resource requests/limits|nil|
|service.type|Kubernetes service type (`ClusterIP`, `LoadBalancer`, or `NodePort` )|ClusterIP|
|service.clusterIP|IP of the service, ``None'' makes the service headless|None|
|service.port|Kubernetes service port|5701|
|rbac.create|Enable installing RBAC Role authorization|true|
|serviceAccount.create|Enable installing Service Account|true|
|serviceAccount.name|Name of Service Account, if not set, the name is generated using the fullname template|nil|
|securityContext.enabled|Enables Security Context for Hazelcast Jet and Hazelcast Jet Management Center|true|
|securityContext.runAsUser|User ID used to run the Hazelcast Jet and Hazelcast Jet Management Center containers|65534|
|securityContext.runAsGroup|Primary Group ID used to run all processes in the Hazelcast Jet and Hazelcast Jet Management Center containers|65534|
|securityContext.fsGroup|Group ID associated with the Hazelcast Jet and Hazelcast Jet Management Center container|65534|
|securityContext.readOnlyRootFilesystem|Enables readOnlyRootFilesystem in the Hazelcast Jet and Hazelcast Jet Management Center security containers|true|
|metrics.enabled|Turn on and off JMX Prometheus metrics available at `/metrics`|false|
|metrics.service.type|Type of the metrics service|ClusterIP|
|metrics.service.port|Port of the `/metrics` endpoint and the metrics service|8080|
|metrics.service.annotations|Annotations for the Prometheus discovery||
|customVolume|Configuration for a volume which will be mounted as `/data/custom` (e.g. to mount a volume with custom JARs)|nil|
|managementcenter.enabled|Turn on and off Hazelcast Jet Management Center application|true|
|managementcenter.image.repository|Hazelcast Jet Management Center Image name|hazelcast/hazelcast-jet-management-center|
|managementcenter.image.tag|Hazelcast Jet Management Center Image tag (NOTE: must be the same or one minor release greater than Hazelcast image version)|{VERSION}|
|managementcenter.image.pullPolicy|Image pull policy|IfNotPresent|
|managementcenter.image.pullSecrets|Specify docker-registry secret names as an array|nil|
|managementcenter.javaOpts|Additional JAVA_OPTS properties for Hazelcast Jet Management Center|nil|
|managementcenter.licenseKey|License Key for Hazelcast Jet Management Center|nil|
|managementcenter.licenseKeySecretName|Kubernetes Secret Name, where Jet Management Center License Key is stored (can be used instead of licenseKey)|nil|
|managementcenter.affinity|Hazelcast Jet Management Center node affinity|nil|
|managementcenter.tolerations|Hazelcast Jet Management Center node tolerations|nil|
|managementcenter.nodeSelector|Hazelcast Jet Management Center node labels for pod assignment|nil|
|managementcenter.resources|CPU/Memory resource requests/limits|nil|
|managementcenter.service.type|Kubernetes service type (`ClusterIP`, `LoadBalancer`, or `NodePort`)|ClusterIP|
|managementcenter.service.port|Kubernetes service port|8081|
|managementcenter.livenessProbe.enabled|Turn on and off liveness probe|true|
|managementcenter.livenessProbe.initialDelaySeconds|Delay before liveness probe is initiated|30|
|managementcenter.livenessProbe.periodSeconds|How often to perform the probe|10|
|managementcenter.livenessProbe.timeoutSeconds|When the probe times out|5|
|managementcenter.livenessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|managementcenter.livenessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|managementcenter.readinessProbe.enabled|Turn on and off readiness probe|true|
|managementcenter.readinessProbe.initialDelaySeconds|Delay before readiness probe is initiated|30|
|managementcenter.readinessProbe.periodSeconds|How often to perform the probe|10|
|managementcenter.readinessProbe.timeoutSeconds|When the probe times out|1|
|managementcenter.readinessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|managementcenter.readinessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

    # Helm 3
    $ helm install my-release \
      --set cluster.memberCount=3,serviceAccount.create=false \
        hazelcast/hazelcast-jet-enterprise

    # Helm 2
    $ helm install --name my-release \
      --set cluster.memberCount=3,serviceAccount.create=false \
        hazelcast/hazelcast-jet-enterprise

The above command sets number of Hazelcast Jet members to 3 and disables REST endpoints.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

    $ helm install my-release -f values.yaml hazelcast/hazelcast-jet-enterprise        # Helm 3
    $ helm install --name my-release -f values.yaml hazelcast/hazelcast-jet-enterprise # Helm 2

> **Tip**: You can use the default values.yaml

## Custom Hazelcast IMDG and Jet configuration

Custom Hazelcast IMDG and Hazelcast Jet configuration can be specified inside `values.yaml`, as the `jet.yaml.hazelcast` and `jet.yaml.hazelcast-jet` properties.

    jet:
      yaml:
        hazelcast:
          network:
            join:
              multicast:
                enabled: false
              kubernetes:
                enabled: true
                service-name: ${serviceName}
                namespace: ${namespace}
                resolve-not-ready-addresses: true
          management-center:
            enabled: ${hazelcast.mancenter.enabled}
            url: ${hazelcast.mancenter.url}
        hazelcast-jet:
          instance:
            flow-control-period: 100
            backup-count: 1
            scale-up-delay-millis: 10000
            lossless-restart-enabled: false
          edge-defaults:
            queue-size: 1024
            packet-size-limit: 16384
            receive-window-multiplier: 3
          metrics:
            enabled: true
            jmx-enabled: true
            retention-seconds: 120
            collection-interval-seconds: 5
            metrics-for-data-structures: false

Alternatively, above parameters can be modified directly via `helm` commands. For example,

    # Helm 3
    $ helm install my-jet-release \
      --set jet.yaml.hazelcast-jet.instance.backup-count=2,jet.yaml.hazelcast.network.kubernetes.service-name=jet-service \
        hazelcast/hazelcast-jet

    # Helm 2
    $ helm install --name my-jet-release \
      --set jet.yaml.hazelcast-jet.instance.backup-count=2,jet.yaml.hazelcast.network.kubernetes.service-name=jet-service \
        hazelcast/hazelcast-jet

## Adding custom JAR files to the classpath

You can mount any volume which contains your JAR files to the pods created by helm chart using `customVolume` configuration.

When the `customVolume` set, it will mount provided volume to the pod on `/data/custom` path. This path also appended to the classpath of running Java process.

For example, if you have existing host path Persistent Volume and Persistent Volume Claims like below;

    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: jet-hostpathpv-volume
      labels:
        type: local
    spec:
      storageClassName: manual
      capacity:
        storage: 1Gi
      accessModes:
        - ReadWriteOnce
      hostPath:
        path: "/path/to/my/jars"
    ---
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: jet-pv-claim
    spec:
      storageClassName: manual
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 1Gi

You can configure your Helm chart to use it like below in your `values.yaml` file.

    customVolume:
      persistentVolumeClaim:
        claimName: jet-pv-claim

See [Volumes](https://kubernetes.io/docs/concepts/storage/) section on the Kubernetes documentation for other available options.

## Notable changes

### 1.4.0

Hazelcast REST Endpoints are no longer enabled by default and the parameter `jet.rest` is no longer available. If you want to enable REST, please add the related `endpoint-groups` to the Hazelcast Configuration (`jet.yaml.hazelcast`). For example:

    rest-api:
      enabled: true
      endpoint-groups:
        HEALTH_CHECK:
          enabled: true
        CLUSTER_READ:
          enabled: true
        CLUSTER_WRITE:
          enabled: true
