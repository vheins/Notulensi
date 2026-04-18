# Example Output: deployment-failure-diagnosis

**Expected Output Shape:**
```
1. Failure Stage Identification
Health check failure — ECS task starts but fails the ALB health check. Container exits with code 1.

2. Root Cause
PORT env var changed from 3000 to 8080 but the health check command still uses port 3000. The health check curl fails → ECS marks task as unhealthy → ALB deregisters target → deployment fails.

3. Fix
Update health check in task definition to use the correct port:
Before: "http://localhost:3000/health"
After:  "http://localhost:${PORT}/health"  or  "http://localhost:8080/health"

Also update ALB target group health check port from 3000 to 8080 in AWS console or Terraform.

4. Rollback
aws ecs update-service --cluster prod --service app-service \
  --task-definition app-task:PREVIOUS_REVISION --force-new-deployment

5. Prevention
- Add a local health check test before pushing: docker run --env PORT=8080 app curl localhost:8080/health
- Use a deployment smoke test in GitHub Actions after ECS stabilizes
- Store PORT in a single source of truth (SSM Parameter Store) referenced by both app and health check
```


**Expected Output Shape:**
```
1. Failure Stage Identification
Container deployment — Kubernetes cannot pull the Docker image from GitLab registry. ImagePullBackOff indicates authentication failure.

2. Root Cause
The Kubernetes deployment has no imagePullSecrets configured. The new GKE cluster does not have credentials to pull from the private GitLab container registry.

3. Fix
Step 1: Create a Kubernetes secret with GitLab registry credentials:
  kubectl create secret docker-registry gitlab-registry \
    --docker-server=registry.gitlab.com \
    --docker-username=<gitlab-username> \
    --docker-password=<gitlab-deploy-token> \
    --namespace=production

Step 2: Add imagePullSecrets to the deployment:
  spec:
    imagePullSecrets:
      - name: gitlab-registry
    containers:
      - image: registry.gitlab.com/myorg/api:${CI_COMMIT_SHA}

Step 3: Re-apply and verify:
  kubectl apply -f k8s/deployment.yaml
  kubectl get pods -w

4. Rollback
kubectl rollout undo deployment/api -n production

5. Prevention
- Add imagePullSecrets to all deployment manifests as a standard template
- Use Workload Identity (GKE) to avoid managing registry credentials manually
- Add a pre-deploy check in CI: kubectl auth can-i get pods --as=system:serviceaccount:production:default
```
