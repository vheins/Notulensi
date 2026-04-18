# Example Output: monolith-decomposition

**Expected Output Shape:**
```
1. Decomposition Phases
Phase 1 (Months 1–3): Extract low-coupling services
- Services: Analytics Service, Notification Service
- Goal: Prove the extraction pattern; eliminate DB query load from analytics
- Success criteria: Analytics queries no longer hit main DB; notifications delivered via new service

Phase 2 (Months 4–6): Extract product catalog
- Services: Product Service
- Goal: Enable independent product deployments
- Success criteria: Product CRUD fully served by new service; monolith reads products via API

Phase 3 (Months 7–10): Extract core transaction services
- Services: Order Service, Payment Service
- Goal: Isolate payment scope for PCI compliance; enable independent order deployments
- Success criteria: All order creation and payment processing through new services

Phase 4 (Months 11–12): Extract user service and decommission monolith
- Services: User Service
- Goal: Complete decomposition; shut down monolith
- Success criteria: Zero traffic to monolith; all services independently deployable

2. Strangler Fig Pattern Application
Routing layer: Add Nginx reverse proxy in front of monolith. Route /api/analytics/* to Analytics Service from day 1.
Incremental cutover: Use feature flags (LaunchDarkly or custom) to route 5% → 25% → 100% of traffic to new service.
Parallel running: Run monolith and new service in parallel for 2 sprints; compare response payloads for divergence.
Verification: Shadow mode — new service processes all requests but responses are discarded; compare with monolith output.

3. Service Extraction Order
1. Analytics Service — coupling score: 1 (only reads from DB, no other modules depend on it); effort: M; tables: events, reports
2. Notification Service — coupling score: 2 (called by orders and payments); effort: S; tables: notification_logs
3. Product Service — coupling score: 3 (read by orders, inventory); effort: M; tables: products, categories
4. Payment Service — coupling score: 2 (called by orders only); effort: L; tables: payments, refunds
5. Order Service — coupling score: 4 (most coupled); effort: XL; tables: orders, order_items
6. User Service — coupling score: 5 (used by all); effort: L; tables: users, addresses, sessions

4. Risk Mitigation per Phase
Phase 1 risks:
- Risk: Analytics event schema diverges from monolith → Mitigation: Define event schema contract before extraction; use schema registry
- Risk: Notification delivery drops during cutover → Mitigation: Run dual-write (monolith + new service) for 1 sprint before cutover
Go/no-go: Error rate < 0.1% on new services for 5 consecutive days

Phase 3 risks:
- Risk: Payment data inconsistency during DB migration → Mitigation: Dual-write to both DBs; reconcile daily
- Risk: Order creation latency increases due to service call overhead → Mitigation: Load test before cutover; set p95 < 500ms threshold

5. Rollback Strategy
Phase 1 rollback trigger: Error rate > 1% on Analytics or Notification Service
Rollback procedure: 1) Flip feature flag to 0% new service traffic, 2) Verify monolith handling all requests, 3) Investigate root cause
Data consistency: Analytics events written to new service during rollback window are replayed from Kafka to monolith DB
Time to rollback: < 5 minutes (feature flag flip)
```


**Expected Output Shape:**
```
1. Decomposition Phases
Phase 1 (Months 1–2): Extract Reports Service
- Goal: Eliminate DB timeout impact on main application
- Success criteria: Reports run on separate DB; main app response time improves by 30%

Phase 2 (Months 3–5): Extract Billing Service
- Goal: Isolate billing for independent deployment and compliance
- Success criteria: Billing changes deployable without full regression; PCI scope reduced

Phase 3 (Months 6–8): Extract Account Service and decommission monolith
- Goal: Complete decomposition
- Success criteria: All traffic served by new services; Django monolith decommissioned

2. Strangler Fig Pattern
Routing: AWS ALB path-based routing; /api/reports/* → Reports Service from Phase 1
Cutover: Blue-green deployment per service; switch ALB target group after verification
Parallel running: 2-week parallel period per service; automated response comparison

3. Service Extraction Order
1. Reports Service — coupling: 1 (read-only, no other apps depend on it); effort: M
2. Billing Service — coupling: 2 (accounts depends on billing status); effort: L
3. Account Service — coupling: 3 (all apps use accounts); effort: M
4. Project/Task Service — coupling: 2 (remaining core); effort: L

4. Risk Mitigation
Phase 2 risks:
- Risk: Billing data migration causes downtime → Mitigation: Migrate with dual-write; no downtime migration using pt-online-schema-change
- Risk: Subscription status inconsistency → Mitigation: Account Service caches billing status via RabbitMQ events; TTL 5 minutes

5. Rollback Strategy
Rollback trigger: Payment failure rate > 0.5% after Billing Service cutover
Procedure: Revert ALB routing to Django monolith; dual-write ensures data consistency
Time to rollback: < 2 minutes (ALB target group switch)
```
