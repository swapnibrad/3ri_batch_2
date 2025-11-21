{{/* Return full image name */}}
{{- define "tomcat-3tier.fullImage" -}}
{{ printf "%s:%s" .Values.image.repository .Values.image.tag }}
{{- end -}}