# Example Input: deployment-failure-diagnosis

### Example 1: GitHub Actions + AWS ECS — Health Check Failure
**Input:**
- `{{tech_stack}}`: GitHub Actions + Docker + AWS ECS + ALB
- `{{deployment_logs}}`: `Step 5/5: Deploying to ECS...\nService updated. Waiting for stability...\nERROR: Service did not stabilize. Task stopped with reason: Task failed ELB health checks in (target-group/app-tg/abc123)\nContainer exit code: 1`
- `{{deployment_config}}`: `healthCheck: { command: ["CMD", "curl", "-f", "http://localhost:3000/health"], interval: 30, retries: 3 }`
- `{{context}}`: Added new /health endpoint in this deployment; PORT env var changed from 3000 to 8080


### Example 2: GitLab CI + Kubernetes — ImagePullBackOff
**Input:**
- `{{tech_stack}}`: GitLab CI + Docker + Kubernetes (GKE)
- `{{deployment_logs}}`: `kubectl apply -f k8s/deployment.yaml\ndeployment.apps/api configured\nWaiting for rollout...\nERROR: pods "api-7d9f8b-xkp2q" is waiting to start: ImagePullBackOff\nFailed to pull image "registry.gitlab.com/myorg/api:abc1234": rpc error: unauthorized: authentication required`
- `{{deployment_config}}`: `image: registry.gitlab.com/myorg/api:${CI_COMMIT_SHA}\nimagePullSecrets: []`
- `{{context}}`: First deployment to this new GKE cluster; image pull secret not configured
