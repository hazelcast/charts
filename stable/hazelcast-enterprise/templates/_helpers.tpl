{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "hazelcast.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hazelcast.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hazelcast.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "hazelcast.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "hazelcast.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service to use
*/}}
{{- define "hazelcast.serviceName" -}}
{{- if .Values.service.create -}}
    {{ template "hazelcast.fullname" .}}
{{- else -}}
    {{ default "default" .Values.service.name }}
{{- end -}}
{{- end -}}

{{/*
Generate the Hazelcast configuration, ensuring that any conflicting discovery configurations are resolved.
Remove the default value for the 'service-name' field when other discovery mechanisms are explicitly used.
*/}}
{{- define "hazelcast.config" -}}
{{- $config := .Values.hazelcast.yaml | deepCopy -}}
{{- $k8sJoin := $config.hazelcast.network.join.kubernetes -}}
{{- if and $k8sJoin -}}
  {{- if or (index $k8sJoin "service-dns") (index $k8sJoin "service-label-name") (index $k8sJoin "pod-label-name") -}}
      {{- $_ := unset $k8sJoin "service-name" -}}
  {{- end -}}
{{- end -}}
{{- toYaml $config -}}
{{- end -}}

{{/*
Create a default fully qualified Management Center app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mancenter.fullname" -}}
{{ (include "hazelcast.fullname" .) | trunc 53 | }}-mancenter
{{- end -}}

{{/*
Create the name of the Management Center app.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "mancenter.name" -}}
{{- printf "%s" .Chart.Name | trunc 53 | trimSuffix "-" | }}-mancenter
{{- end -}}


{{/*
Renders a value that contains template.
Usage:
{{ include "common.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $ ) }}
*/}}
{{- define "common.tplvalues.render" -}}
{{- $value := typeIs "string" .value | ternary .value (.value | toYaml) }}
{{- if contains "{{" (toJson .value) }}
    {{- tpl $value .context }}
{{- else }}
    {{- $value }}
{{- end }}
{{- end -}}
