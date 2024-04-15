
# IP-checker

IP-checker makes some requests to a specific website to verify the source IP address.

## Environment variables

| Variable                    | Description                                            | Required | Default   | Available values |
|:----------------------------|:-------------------------------------------------------|:---------|:----------|:-----------------|
| HTTP_CHECK_URL              | URL to verify the origin IP with 'http://' prefix      | yes      |           |                  |
| HTTP_HEADER_X_FORWARDED_FOR | HTTP 'X-Forwarded-For' header                          | no       | ''        |                  |
| ROUNDS                      | How many times the IP-checker performs the request     | no       | 1000      |                  |
| INTERVAL                    | Interval in seconds between a request and the next one | no       | 1         |                  |
| TIMEOUT                     | Timeout in seconds for a request                       | no       | 5         |                  |
| DEBUG_LOG                   | Enable debug logging                                   | no       | false     | true, false      |
| K8S_NODE_NAME               | Kubernetes Node name on which the Pod runs             | no       | node-name |                  |
| K8S_NODE_IP                 | Kubernetes Node IP on which the Pod runs               | no       | node-ip   |                  |
| K8S_POD_NAME                | Kubernetes Pod name                                    | no       | pod-name  |                  |
| K8S_POD_IP                  | Kubernetes Pod IP                                      | no       | pod-ip    |                  |

## Some well-known websites

- ifconfig.co
- httpbin.org/ip
- ifconfig.me
- ipecho.net/plain

---

## Links

### issues

- https://stackoverflow.com/questions/1445452/shell-script-for-loop-syntax
- https://stackoverflow.com/questions/30358065/syntax-error-bad-for-loop-variable
- https://serverfault.com/questions/151109/how-do-i-get-the-current-unix-time-in-milliseconds-in-bash
- https://stackoverflow.com/questions/16548528/command-to-get-time-in-milliseconds
