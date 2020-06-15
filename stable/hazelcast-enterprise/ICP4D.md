# Set Up Hazelcast IMDG Enterprise On IBM Cloud Pak for Data

## **Prerequisites**
To deploy Hazelcast IMDG Enterprise on Cloud Pak for Data, the following prerequisites must be met:
1. Having an Cloud Pak for Data account with IBM and a working installation of Cloud Pak for Data on your cluster.
2. Having sufficient privileges to that cluster so that you can run `oc` & `helm`(should be helm-3) and log in to the Cloud Pak for Data internal docker registry. How to do this is described in the [Cloud Pak for Data Documentations](https://www.ibm.com/support/producthub/icpdata/docs/content/SSQNUZ_current/cpd/overview/overview.html)
3. The Hazelcast IMDG Enterprise service/Helm chart is already bundled with required software which is enough for running cluster. This bundle contains Management Center as well that enables you to monitor and manage your cluster members running Hazelcast IMDG.
4. The minimum CPU requirement is 0.5 core for each IMDG and Management Center.
5. The minimum memory requirement is 1G for each IMDG and Management Center.
6. The minimum storage requirement is 8G for each IMDG and Management Center.

## **Work Flow**
Deploying Hazelcast IMDG Enterprise on IBM Cloud Pak for Data uses the following workflow that is tested with **CPD 3.0.0** and **OCP 4.3**:

1. After logging into your cluster with your Cloud Pak for Data credentials in your web browser, find Hazelcast IMDG Enterprise in the Service Catalog section.
2. Open the menu in the corner of the Hazelcast IMDG Enterprise tile and click Deploy.
3. You are then forwarded in your browser to this page (the one you are reading).

## **Installation**
Follow the steps to have the Hazelcast IMDG Enterprise up and running on your cluster.

1. Add `latest` RHEL based Hazelcast IMDG Enterprise images into you project, if you want to use different version of the service, please change the `latest` with the version:
    ```
    $ oc import-image hazelcast/hazelcast-4-rhel8:latest --from=registry.connect.redhat.com/hazelcast/hazelcast-4-rhel8 --confirm

    $ oc import-image hazelcast/management-center-4-rhel8:latest --from=registry.connect.redhat.com/hazelcast/management-center-4-rhel8 --confirm
    ```
    You can find all Hazelcasty IMDG Enterprise and Management Center RHEL based images at [RedHat Container Catalog](https://catalog.redhat.com/software/containers/search?vendor_name=Hazelcast).
2. Verfiy Image Streams that are imported:
    ```
    $ oc get all
    NAME                                                       IMAGE REPOSITORY                                                                                           TAGS     UPDATED
    imagestream.image.openshift.io/hazelcast-4-rhel8           default-route-openshift-image-registry.apps.p-ella.ibmplayground.com/hazelcast/hazelcast-4-rhel8           latest
    imagestream.image.openshift.io/management-center-4-rhel8   default-route-openshift-image-registry.apps.p-ella.ibmplayground.com/hazelcast/management-center-4-rhel8   latest
    ```

3. Add Hazelcast helm charts repo:
    ```
    $ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
    $ helm repo update
    ```

4. To install the chart with the release name `hz-mc` and `latest` images. If you have already imported different image versions, please update `image.tag` and `mancenter.image.tag` parameters:
    ```
    $ helm install hz-mc --set hazelcast.licenseKey=<HZ_LICENSE_KEY>\
        --set image.repository=image-registry.openshift-image-registry.svc:5000/hazelcast/hazelcast-4-rhel8 \
        --set image.tag=latest \
        --set securityContext.enabled=false \
        --set mancenter.image.repository=image-registry.openshift-image-registry.svc:5000/hazelcast/management-center-4-rhel8 \
        --set mancenter.image.tag=latest \
        --set mancenter.service.type=ClusterIP \
        hazelcast/hazelcast-enterprise
    ```
    You can find all configurable parameters of the Hazelcast chart and their default values at README.md

5. Run the following `oc` command to verify the deployment:
    ```
    $ oc get all
    NAME                                         READY   STATUS    RESTARTS   AGE
    pod/hz-mc-hazelcast-enterprise-0             1/1     Running   0          2m7s
    pod/hz-mc-hazelcast-enterprise-1             1/1     Running   0          86s
    pod/hz-mc-hazelcast-enterprise-2             1/1     Running   0          48s
    pod/hz-mc-hazelcast-enterprise-mancenter-0   1/1     Running   0          2m7s

    NAME                                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)            AGE
    service/hz-mc-hazelcast-enterprise             ClusterIP   None             <none>        5701/TCP           2m8s
    service/hz-mc-hazelcast-enterprise-mancenter   ClusterIP   172.30.168.184   <none>        8080/TCP,443/TCP   2m8s

    NAME                                                    READY   AGE
    statefulset.apps/hz-mc-hazelcast-enterprise             3/3     2m8s
    statefulset.apps/hz-mc-hazelcast-enterprise-mancenter   1/1     2m8s

    NAME                                                       IMAGE REPOSITORY                                                                                           TAGS     UPDATED
    imagestream.image.openshift.io/hazelcast-4-rhel8           default-route-openshift-image-registry.apps.p-ella.ibmplayground.com/hazelcast/hazelcast-4-rhel8           latest   6 minutes ago
    imagestream.image.openshift.io/management-center-4-rhel8   default-route-openshift-image-registry.apps.p-ella.ibmplayground.com/hazelcast/management-center-4-rhel8   latest   6 minutes ago
    ```

6. Management Center service can be exposed by creating a route with such command:
    ```
    $ oc expose service/hz-mc-hazelcast-enterprise-mancenter
    route.route.openshift.io/hz-mc-hazelcast-enterprise-mancenter exposed

    $ oc get routes
    NAME                                   HOST/PORT                                                                      PATH   SERVICES                               PORT   TERMINATION   WILDCARD
    hz-mc-hazelcast-enterprise-mancenter   hz-mc-hazelcast-enterprise-mancenter-hazelcast.apps.p-ella.ibmplayground.com          hz-mc-hazelcast-enterprise-mancenter   http                 None
    ```
    Then Management Center dashboard can be accessed with URL, http://hz-mc-hazelcast-enterprise-mancenter-hazelcast.apps.p-ella.ibmplayground.com/


## **Installation for Air-gapped Environment**

1. To be able to push Hazelcast IMDG Enterprise and Management Center images to the OCP image registry, you need to expose related service:
    ```
    $ oc project openshift-image-registry
    $ oc expose service/image-registry
    $ HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
    ```

2. Configure docker to recognize the OpenShift registry(HOST) as an insecure registry then try to login the registry route that you exposed:
    ```
    $ docker login -u $(oc whoami) -p $(oc whoami -t) ${HOST}
    ```

3. Go to your project:
   ```
   $ oc project <your-projecct>
   ```

4. Pull RHEL based images into your local and tag images with that route registry’s url and push them to it:
    ```
    $ docker pull registry.connect.redhat.com/hazelcast/management-center-4-rhel8:latest
    $ docker pull registry.connect.redhat.com/hazelcast/hazelcast-4-rhel8:latest

    $ docker tag registry.connect.redhat.com/hazelcast/hazelcast-4-rhel8:latest ${HOST}/hazelcast/hazelcast-4-rhel8:latest
    $ docker push ${HOST}/hazelcast/hazelcast-4-rhel8:latest

    $ docker tag registry.connect.redhat.com/hazelcast/management-center-4-rhel8:latest ${HOST}/hazelcast/management-center-4-rhel8:latest
    $ docker push ${HOST}/hazelcast/management-center-4-rhel8:latest
    ```

5. Verfiy Image Streams that are imported into your project/namespace:
    ```
    $ oc get all
    NAME                                                       IMAGE REPOSITORY                                                                                           TAGS     UPDATED
    imagestream.image.openshift.io/hazelcast-4-rhel8           default-route-openshift-image-registry.apps.p-ella.ibmplayground.com/hazelcast/hazelcast-4-rhel8           latest   9 seconds ago
    imagestream.image.openshift.io/management-center-4-rhel8   default-route-openshift-image-registry.apps.p-ella.ibmplayground.com/hazelcast/management-center-4-rhel8   latest   3 minutes ago
    ```
6. Then follow same deployments steps at [Installation](#installation) section.

## **Uninstall Hazelcast IMDG Enterprise service**
1. Uninstall/delete the `hz-mc` deployment:
    ```
    $ helm delete hz-mc
    release "hz-mc" uninstalled
    ```

2. Delete exsiting Image Stremas from your project:
    ```
    $ oc delete imagestream.image.openshift.io/hazelcast-4-rhel8 imagestream.image.openshift.io/management-center-4-rhel8
    imagestream.image.openshift.io "hazelcast-4-rhel8" deleted
    imagestream.image.openshift.io "management-center-4-rhel8" deleted
    ```

3. Delete Management Center route:
    ```
    oc delete route.route.openshift.io/hz-mc-hazelcast-enterprise-mancenter
    ```