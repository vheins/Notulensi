# Example Output: network-latency-diagnosis

**Expected Output Shape:**
```
1. Latency Breakdown
DNS: 800ms (critical — 25% of total)
TCP: 12ms (normal)
TLS: 45ms (acceptable)
App processing: 200ms (normal)
DB query: 2.1s (critical — 66% of total)
Total: ~3.2s

2. Bottleneck Identification
Two bottlenecks:
- DB query: 2.1s — cross-region latency (us-east-1 app → us-west-2 DB = ~70ms RTT × multiple round trips)
- DNS: 800ms — no DNS caching configured in Node.js

3. Root Cause Analysis
DB: Node.js makes multiple round trips to PostgreSQL for a single checkout (N+1 pattern). Each round trip adds 70ms cross-region RTT. 30 round trips × 70ms = 2.1s.
DNS: Node.js does not cache DNS by default. Each new connection resolves DNS from scratch.

4. Optimization Recommendations
Priority 1: Move DB to us-east-1 or use read replica — eliminates 70ms RTT per round trip
Priority 2: Fix N+1 query — reduces round trips from 30 to 1-2
Priority 3: Enable DNS caching: require('dns').setDefaultResultOrder('ipv4first') + dns-cache package
Priority 4: Enable PostgreSQL connection pooling with pgBouncer

5. Monitoring Setup
Alert: p99 latency > 500ms for 2 consecutive minutes
Dashboard: DB query time, DNS resolution time, connection pool utilization
```


**Expected Output Shape:**
```
1. Latency Breakdown
order-service processing: ~0ms (immediate call)
Network transit: 442ms (critical — 98% of total)
inventory-service processing: 8ms (normal)
Total: 450ms

2. Bottleneck Identification
Network path between services — 442ms for same-cluster communication is abnormal (expected <1ms).

3. Root Cause Analysis
Same-cluster service-to-service latency of 442ms strongly indicates a NetworkPolicy misconfiguration causing packets to be dropped and retried, or traffic being routed through an external load balancer instead of the cluster network.

4. Optimization Recommendations
Step 1: Check NetworkPolicy — verify order-service is allowed to reach inventory-service on the correct port
  kubectl describe networkpolicy -n inventory
Step 2: Verify service DNS resolution — ensure order-service uses internal DNS (inventory-service.inventory.svc.cluster.local)
Step 3: Check if traffic is leaving the cluster — use kubectl exec to curl inventory-service directly and measure latency
Step 4: If NetworkPolicy is the issue, add explicit ingress rule for order-service namespace

5. Monitoring Setup
Add Kubernetes network latency metric: inter-pod RTT via eBPF (Cilium Hubble or Pixie)
Alert: inter-service p99 > 10ms within same cluster
```
