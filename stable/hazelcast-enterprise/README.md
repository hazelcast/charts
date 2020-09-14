# Hazelcast Enterprise

[Hazelcast IMDG Enterprise](https://hazelcast.com/products/enterprise/) is the most widely used in-memory data grid with hundreds of thousands of installed clusters around the world. It offers caching solutions ensuring that data is in the right place when it’s needed for optimal performance.

## Quick Start

    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
    $ helm repo update
    $ helm install my-release --set hazelcast.licenseKey=<license_key> hazelcast/hazelcast-enterprise

For users who already added `hazelcast` repo to their local helm client before; you need to run `helm repo add` command again to use latest charts from our new chart repo:

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

This chart bootstraps a [Hazelcast Enterprise](https://github.com/hazelcast/hazelcast-docker/tree/master/hazelcast-enterprise-kubernetes) and [Management Center](https://github.com/hazelcast/management-center-docker) deployments on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

-   Kubernetes 1.9+

## Installing the Chart

To install the chart with the release name `my-release`:

    $ helm install my-release --set hazelcast.licenseKey=<license_key> hazelcast/hazelcast-enterprise

The command deploys Hazelcast on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

    $ helm delete my-release

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Hazelcast chart and their default values.

|Parameter|Description|Default|
|--- |--- |--- |
|image.repository|Hazelcast Image name|hazelcast/hazelcast-enterprise-kubernetes|
|image.tag|Hazelcast Image tag|{VERSION}|
|image.pullPolicy|Image pull policy|IfNotPresent|
|image.pullSecrets|Specify docker-registry secret names as an array|nil|
|cluster.memberCount|Number of Hazelcast members|2|
|hazelcast.licenseKey|Hazelcast Enterprise License Key|nil|
|hazelcast.licenseKeySecretName|Kubernetes Secret Name, where Hazelcast Enterprise License Key is stored (can be used instead of licenseKey)|nil|
|hazelcast.ssl|Enable SSL for Hazelcast|false|
|hazelcast.updateClusterVersionAfterRollingUpgrade|Enable Hazelcast cluster auto version upgrade after the rolling upgrade procedure|true|
|hazelcast.javaOpts|Additional JAVA_OPTS properties for Hazelcast member|nil|
|hazelcast.loggingLevel|Level of Hazelcast logs (SEVERE, WARNING, INFO, CONFIG, FINE, FINER, and FINEST); note that changing this value requires setting securityContext.runAsUser to 0 and securityContext.readOnlyRootFilesystem to false|nil|
|hazelcast.existingConfigMap|ConfigMap which contains Hazelcast configuration file(s) that are used instead hazelcast.yaml embedded into values.yaml|nil|
|hazelcast.yaml|Hazelcast YAML Configuration (hazelcast.yaml embedded into values.yaml)|{DEFAULT_HAZELCAST_YAML}|
|hazelcast.configurationFiles|Hazelcast configuration files|nil|
|annotations| Hazelcast Statefulset annotations| nil
|affinity|Hazelcast Node affinity|nil|
|tolerations|Hazelcast Node tolerations|nil|
|nodeSelector|Hazelcast Node labels for pod assignment|nil|
|hostPort|Port under which Hazelcast PODs are exposed on the host machines|nil|
|customPorts|Whole ports section to customize how Hazelcast container ports are defined|nil|
|gracefulShutdown.enabled|Turn on and off Graceful Shutdown|true|
|gracefulShutdown.maxWaitSeconds|Maximum time to wait for the Hazelcast POD to shut down|600|
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
|resources.limits.cpu|CPU resource limit|default|
|resources.limits.memory|Memory resource limit|default|
|resources.requests.cpu|CPU resource requests|default|
|resources.requests.memory|Memory resource requests|default|
|service.create|Enable installing Service|true|
|service.name|Name of Service, if not set, the name is generated using the fullname template|nil|
|service.type|Kubernetes service type (`ClusterIP`, `LoadBalancer`, or `NodePort`|ClusterIP|
|service.clusterIP|IP of the service, `None` makes the service headless|None|
|service.port|Kubernetes service port|5701|
|rbac.create|Enable installing RBAC Role authorization|true|
|serviceAccount.create|Enable installing Service Account|true|
|serviceAccount.name|Name of Service Account, if not set, the name is generated using the fullname template|nil|
|securityContext.enabled|Enables Security Context for Hazelcast and Management Center|true|
|securityContext.runAsUser|User ID used to run the Hazelcast and Management Center containers|65534|
|securityContext.runAsGroup|Primary Group ID used to run all processes in the Hazelcast Jet and Hazelcast Jet Management Center containers|65534|
|securityContext.fsGroup|Group ID associated with the Hazelcast and Management Center container|65534|
|securityContext.readOnlyRootFilesystem|Enables readOnlyRootFilesystem in the Hazelcast security context|true|
|hotRestart.enabled|Turn on and off Hazelcast Hot Restart feature (Hazelcast configuration must be also updated with the map/cache configuration)|false|
|hotRestart.existingClaim|Name of the existing Persistence Volume Claim, if not defined, a new is created|nil|
|hotRestart.accessModes|Access Modes of the new Persistent Volume Claim|ReadWriteOnce|
|hotRestart.size|Size of the new Persistent Volume Claim|8Gi|
|hotRestart.hostPath|Path of node machine used for persistent storage; if defined, it’s used instead of Persistent Volume Claim|nil|
|metrics.enabled|Turn on and off JMX Prometheus metrics available at `/metrics`|false|
|metrics.service.type|Type of the metrics service|ClusterIP|
|metrics.service.port|Port of the `/metrics` endpoint and the metrics service|8080|
|metrics.service.annotations|Annotations for the Prometheus discovery||
|secretsMountName|Secret name that is mounted as `/data/secrets/` (e.g. with keystore/trustore files)|nil|
|customVolume|Configuration for a volume mounted as `/data/custom` (e.g. to mount a volume with custom JARs)|nil|
|mancenter.enabled|Turn on and off Management Center application|true|
|mancenter.image.repository|Hazelcast Management Center Image name|hazelcast/management-center|
|mancenter.image.tag|Hazelcast Management Center Image tag (NOTE: must be the same or one minor release greater than Hazelcast image version)|{VERSION}|
|mancenter.image.pullPolicy|Image pull policy|IfNotPresent|
|mancenter.image.pullSecrets|Specify docker-registry secret names as an array|nil|
|mancenter.image.contextPath|the value for the MC_CONTEXT_PATH environment variable, thus overriding the default context path for Hazelcast Management Center|nil|
|mancenter.ssl|Enable SSL for Management Center|false|
|mancenter.javaOpts|Additional JAVA_OPTS properties for Hazelcast Management Center|nil|
|mancenter.licenseKey|License Key for Hazelcast Management Center, if not provided, can be filled in the web interface|nil|
|mancenter.licenseKeySecretName|Kubernetes Secret Name, where Management Center License Key is stored (can be used instead of licenseKey)|nil|
|mancenter.adminCredentialsSecretName|Kubernetes Secret Name for admin credentials. Secret has to contain `username` and `password` literals. please check Management Center documentation for password requirements|nil|
|mancenter.annotations|Management Center Statefulset annotations|nil|
|mancenter.affinity|Management Center Node affinity|nil|
|mancenter.tolerations|Management Center Node tolerations|nil|
|mancenter.nodeSelector|Hazelcast Management Center node labels for pod assignment|nil|
|mancenter.resources|CPU/Memory resource requests/limits|nil|
|mancenter.persistence.enabled|Enable Persistent Volume for Hazelcast Management|true|
|mancenter.persistence.existingClaim|Name of the existing Persistence Volume Claim, if not defined, a new is created|nil|
|mancenter.persistence.accessModes|Access Modes of the new Persistent Volume Claim|ReadWriteOnce|
|mancenter.persistence.size|Size of the new Persistent Volume Claim|8Gi|
|mancenter.service.type|Kubernetes service type (`ClusterIP`, `LoadBalancer`, or `NodePort`)|LoadBalancer|
|mancenter.service.port|Kubernetes service port|5701|
|mancenter.livenessProbe.enabled|Turn on and off liveness probe|true|
|mancenter.livenessProbe.initialDelaySeconds|Delay before liveness probe is initiated|30|
|mancenter.livenessProbe.periodSeconds|How often to perform the probe|10|
|mancenter.livenessProbe.timeoutSeconds|When the probe times out|5|
|mancenter.livenessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|mancenter.livenessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|mancenter.readinessProbe.enabled|Turn on and off readiness probe|true|
|mancenter.readinessProbe.initialDelaySeconds|Delay before readiness probe is initiated|30|
|mancenter.readinessProbe.periodSeconds|How often to perform the probe|10|
|mancenter.readinessProbe.timeoutSeconds|When the probe times out|1|
|mancenter.readinessProbe.successThreshold|Minimum consecutive successes for the probe to be considered successful after having failed|1|
|mancenter.readinessProbe.failureThreshold|Minimum consecutive failures for the probe to be considered failed after having succeeded.|3|
|mancenter.ingress.enabled|Enable ingress for the management center|false|
|mancenter.ingress.annotations|Any annotations for the ingress|{}|
|mancenter.ingress.hosts|List of hostnames for ingress, see values.yaml for example|[]|
|mancenter.ingress.tls|List of TLS configuration for ingress, see values.yaml for example|[]|


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

    $ helm install my-release \
      --set hazelcast.licenseKey=<license_key>,cluster.memberCount=3 \
        hazelcast/hazelcast-enterprise

The above command sets number of Hazelcast members to 3.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

    $ helm install my-release -f values.yaml hazelcast/hazelcast-enterprise

> **Tip**: You can use the default values.yaml with the `hazelcast.license`
> filled in

## Custom Hazelcast configuration

Custom Hazelcast configuration can be specified inside `values.yaml`, as
the `hazelcast.yaml` property.

    hazelcast:
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
            <!-- Custom Configuration Placeholder -->

Note that some of the Hazelcast Enterprise features requires setting `securityContext.readOnlyRootFilesystem` parameter to `false`. This is the case for the Hot Restart feature or enabling security with OpenSSL.

## Configuring SSL

To enable SSL-protected communication between members and clients, you need first to generate `keystore`/`truststore` and import them as secrets into your Kubernetes environment.

    $ kubectl create secret generic keystore --from-file=./keystore --from-file=./truststore

Then, run your cluster with SSL enabled and keystore secrets mounted into your PODs.

    $ helm install --my-release \
      --set hazelcast.licenseKey=<license_key> \
      --set hazelcast.ssl=true \
      --set secretsMountName=keystore \
      --set hazelcast.javaOpts='-Djavax.net.ssl.keyStore=/data/secrets/keystore -Djavax.net.ssl.keyStorePassword=<keystore_password> -Djavax.net.ssl.trustStore=/data/secrets/truststore -Djavax.net.ssl.trustStorePassword=<truststore_password>' \
      --set mancenter.ssl=true \
      --set mancenter.secretsMountName=keystore \
      --set mancenter.javaOpts='-Dhazelcast.mc.tls.keyStore=/secrets/keystore -Dhazelcast.mc.tls.keyStorePassword=<keystore_password> -Dhazelcast.mc.tls.trustStore=/secrets/truststore -Dhazelcast.mc.tls.trustStorePassword=<truststore_password>' \
      --set mancenter.service.port=8443 \
        hazelcast/hazelcast-enterprise

For more information please check [Hazelcast Kubernetes SSL Code Sample](https://github.com/hazelcast/hazelcast-code-samples/tree/master/hazelcast-integration/kubernetes/samples/ssl).


## Adding custom JAR files to the IMDG/Management Center classpath

You can mount any volume which contains your JAR files to the pods created by helm chart using `customVolume` configuration.

When the `customVolume` set, it will mount provided volume to the pod on `/data/custom` path. This path is also appended to the classpath of running Java process.

For example, if you have existing [Local Persistent Volumes](https://kubernetes.io/blog/2019/04/04/kubernetes-1.14-local-persistent-volumes-ga/) and Persistent Volume Claims like below;

```yaml
  kind: StorageClass
  apiVersion: storage.k8s.io/v1
  metadata:
    name: local-storage
  provisioner: kubernetes.io/no-provisioner
  volumeBindingMode: WaitForFirstConsumer

  ---
  apiVersion: v1
  kind: PersistentVolume
  metadata:
    name: <hz-custom-local-pv / mc-custom-local-pv>
  spec:
    storageClassName: local-storage
    capacity:
      storage: 1Gi
    accessModes:
      - ReadWriteOnce
    local:
      path: </path/to/your/jars>
    nodeAffinity:
      required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - <YOUR_NODE>
  ---

  apiVersion: v1
  kind: PersistentVolumeClaim
  metadata:
    name: < hz-custom-local-pv-claim / mc-custom-local-pv-claim>
  spec:
    storageClassName: local-storage
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
      storage: 1Gi
```

You can configure your Helm chart to use it like below in your `values.yaml` file.

For IMDG:
```yaml
customVolume:
  persistentVolumeClaim:
    claimName: hz-custom-local-pv-claim
```

For Management Center:
```yaml
mancenter:
  ...
  customVolume:
    persistentVolumeClaim:
      claimName: mc-custom-local-pv-claim
```

## Notable changes

### 2.8.0

Hazelcast REST Endpoints are no longer enabled by default and the parameter `hazelcast.rest` is no longer available. If you want to enable REST, please add the related `endpoint-groups` to the Hazelcast Configuration. For example:

    rest-api:
      enabled: true
      endpoint-groups:
        HEALTH_CHECK:
          enabled: true
        CLUSTER_READ:
          enabled: true
        CLUSTER_WRITE:
          enabled: true
