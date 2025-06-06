{{/*
Helper to generate the database URL.
*/}}
{{- define "prognose.database.url" -}}
{{- if .Values.postgresql.enabled -}}
{{- printf "jdbc:postgresql://%s-postgres-service:%d/%s" .Release.Name 5432 .Values.postgresql.auth.database -}}
{{- else -}}
{{- .Values.be.config.dbUrl | quote -}}
{{- end -}}
{{- end -}}

{{/*
Helper to generate the database username.
*/}}
{{- define "prognose.database.username" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.username | b64enc | quote -}}
{{- else -}}
{{- .Values.be.secrets.dbUser | b64enc | quote -}}
{{- end -}}
{{- end -}}

{{/*
Helper to generate the database password.
*/}}
{{- define "prognose.database.password" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.password | b64enc | quote -}}
{{- else -}}
{{- .Values.be.secrets.dbPassword | b64enc | quote -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
Usage:
{{ include "prognose.labels" (dict "context" . "component" "backend") }}
*/}}
{{- define "prognose.labels" -}}
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
{{ include "prognose.selectorLabels" (dict "context" . "component" "backend") }}
*/}}
{{- define "prognose.selectorLabels" -}}
app.kubernetes.io/name: {{ .context.Chart.Name }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end -}}
