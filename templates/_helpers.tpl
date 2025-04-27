{{/*
Expand the name of the chart
*/}}
{{- define "resource-management-chart.name" -}}
{{- .Chart.Name | quote -}}
{{- end -}}

{{/*
Expand the chart version
*/}}
{{- define "resource-management-chart.version" -}}
{{- .Chart.Version | quote -}}
{{- end -}}

{{/*
Expand the full name of the resource
*/}}
{{- define "resource-management-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "resource-management-chart.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels for all resources
*/}}
{{- define "resource-management-chart.labels" -}}
app: {{ include "resource-management-chart.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{/*
Get the value of a key from values.yaml with a default fallback
*/}}
{{- define "resource-management-chart.getValue" -}}
{{- default .Values.default .Values.getValue -}}
{{- end -}}