{{/*
Expand the name of the chart.
*/}}
{{- define "cga-directory-connector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cga-directory-connector.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cga-directory-connector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cga-directory-connector.labels" -}}
helm.sh/chart: {{ include "cga-directory-connector.chart" . }}
{{ include "cga-directory-connector.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cga-directory-connector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cga-directory-connector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Directory Connector image
*/}}
{{- define "cga-directory-connector.imageConcat" -}}
{{- if .Values.image.sha256 }}
{{- printf "%s:%s@sha256:%s" .Values.image.repository .Values.image.tag .Values.image.sha256 -}}
{{- else }}
{{- printf "%s:%s" .Values.image.repository .Values.image.tag -}}
{{- end }}
{{- end }}
