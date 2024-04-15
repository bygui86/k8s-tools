
# k8s-pod-logs-checker

Logs Checker is a tool that periodically fetches logs from a targeted pod and stores the in a file. It can be used in a
situation where regular log collecting infrastructure (Loki, Grafana etc) is not available.

Container image base: `kubectl`
