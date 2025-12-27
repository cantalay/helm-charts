{{- define "expo-app.name" -}}
expo-app
{{- end }}

{{- define "expo-app.fullname" -}}
{{ include "expo-app.name" . }}
{{- end }}
