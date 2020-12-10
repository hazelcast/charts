{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "hazelcast-jet.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hazelcast-jet.fullname" -}}
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
Create chart name as used by the chart label.
*/}}
{{- define "hazelcast-jet.chart" -}}
{{- printf "%s" .Chart.Name | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "hazelcast-jet.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "hazelcast-jet.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service to use
*/}}
{{- define "hazelcast-jet.serviceName" -}}
{{- if .Values.service.create -}}
    {{ template "hazelcast-jet.fullname" .}}
{{- else -}}
    {{ default "default" .Values.service.name }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified Hazelcast Jet Management Center app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "managementcenter.fullname" -}}
{{ (include "hazelcast-jet.fullname" .) | trunc 45 | }}-management-center
{{- end -}}

{{/*
Create the name of the Management Center app.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "managementcenter.name" -}}
{{- printf "%s" .Chart.Name | trunc 53 | trimSuffix "-" | }}-management-center
{{- end -}}
