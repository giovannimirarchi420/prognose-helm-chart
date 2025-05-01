{{/*
Helper to generate the database URL.
*/}}
{{- define "resource-management.database.url" -}}
{{- if .Values.postgresql.enabled -}}
{{- printf "jdbc:postgresql://%s-postgres-service:%d/%s" .Release.Name 5432 .Values.postgresql.auth.database -}}
{{- else -}}
{{- .Values.be.config.dbUrl | quote -}}
{{- end -}}
{{- end -}}

{{/*
Helper to generate the database username.
*/}}
{{- define "resource-management.database.username" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.username | quote -}}
{{- else -}}
{{- .Values.be.secrets.dbUser | quote -}}
{{- end -}}
{{- end -}}

{{/*
Helper to generate the database password.
*/}}
{{- define "resource-management.database.password" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.password | quote -}}
{{- else -}}
{{- .Values.be.secrets.dbPassword | quote -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
Usage:
{{ include "resource-management.labels" (dict "context" . "component" "backend") }}
*/}}
{{- define "resource-management.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .context.Chart.Name .context.Chart.Version | quote }}
app.kubernetes.io/name: {{ .context.Chart.Name }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end -}}

{{/*
Selector labels
Usage:
{{ include "resource-management.selectorLabels" (dict "context" . "component" "backend") }}
*/}}
{{- define "resource-management.selectorLabels" -}}
app.kubernetes.io/name: {{ .context.Chart.Name }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end -}}
