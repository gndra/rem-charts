{{/*
Expand the name of the chart.
*/}}
{{- define "vapor-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vapor-proxy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "vapor-proxy.url" -}}
{{- printf "http://%s_%s_svc_%g.mesh" .Release.Name .Release.Namespace .Values.service.port }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vapor-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vapor-proxy.labels" -}}
helm.sh/chart: {{ include "vapor-proxy.chart" . }}
{{ include "vapor-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vapor-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vapor-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
