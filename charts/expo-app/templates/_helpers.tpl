{{/*
Chart name
*/}}
{{- define "expo-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Full name
*/}}
{{- define "expo-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- printf "%s-%s" .Release.Name (include "expo-app.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}
