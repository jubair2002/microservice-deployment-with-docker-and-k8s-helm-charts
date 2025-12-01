{{/*
Expand the name of the chart.
*/}}
{{- define "microservice-application.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "microservice-application.fullname" -}}
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
{{- define "microservice-application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "microservice-application.labels" -}}
helm.sh/chart: {{ include "microservice-application.chart" . }}
{{ include "microservice-application.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "microservice-application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "microservice-application.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "microservice-application.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "microservice-application.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate service URLs
*/}}
{{- define "microservice-application.authUrl" -}}
http://auth-service:{{ .Values.services.auth.port }}
{{- end }}

{{- define "microservice-application.userUrl" -}}
http://user-service:{{ .Values.services.user.port }}
{{- end }}

{{- define "microservice-application.surveyUrl" -}}
http://survey-service:{{ .Values.services.survey.port }}
{{- end }}

{{- define "microservice-application.paymentUrl" -}}
http://payment-service:{{ .Values.services.payment.port }}
{{- end }}