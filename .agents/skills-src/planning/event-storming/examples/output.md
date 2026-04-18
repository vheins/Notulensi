# Example Output: event-storming

**Expected Output Shape:**
```
1. Domain Events (Orange)
CartItemAdded — Customer adds product to cart; payload: cartId, productId, quantity
OrderPlaced — Customer submits checkout; payload: orderId, customerId, items[], totalAmount
PaymentProcessed — Payment gateway confirms charge; payload: orderId, paymentId, amount
InventoryReserved — Warehouse reserves stock for order; payload: orderId, items[], warehouseId
OrderShipped — Warehouse ships order; payload: orderId, trackingNumber, carrier
OrderDelivered — Carrier confirms delivery; payload: orderId, deliveredAt
OrderCancelled — Order cancelled before shipment; payload: orderId, reason, cancelledAt

2. Commands (Blue)
AddItemToCart — issued by: Customer; produces: CartItemAdded; precondition: product in stock
PlaceOrder — issued by: Customer; produces: OrderPlaced; precondition: cart non-empty, address provided
ProcessPayment — issued by: Payment Service; produces: PaymentProcessed; precondition: OrderPlaced
ReserveInventory — issued by: Inventory Service; produces: InventoryReserved; precondition: PaymentProcessed
ShipOrder — issued by: Warehouse Staff; produces: OrderShipped; precondition: InventoryReserved
ConfirmDelivery — issued by: Carrier System; produces: OrderDelivered; precondition: OrderShipped

3. Aggregates (Yellow)
Cart — handles: AddItemToCart; emits: CartItemAdded; invariant: total items ≤ 50
Order — handles: PlaceOrder, CancelOrder; emits: OrderPlaced, OrderCancelled; invariant: cannot cancel after shipment
Payment — handles: ProcessPayment; emits: PaymentProcessed; invariant: idempotent (no double charge)
Inventory — handles: ReserveInventory, ReleaseInventory; emits: InventoryReserved; invariant: available stock ≥ 0
Shipment — handles: ShipOrder, ConfirmDelivery; emits: OrderShipped, OrderDelivered

4. Bounded Contexts
Shopping Context: Cart aggregate; produces: CartItemAdded, OrderPlaced; consumes: nothing
Payment Context: Payment aggregate; produces: PaymentProcessed; consumes: OrderPlaced
Inventory Context: Inventory aggregate; produces: InventoryReserved; consumes: PaymentProcessed
Fulfillment Context: Shipment aggregate; produces: OrderShipped, OrderDelivered; consumes: InventoryReserved
Notification Context: no aggregates; consumes: OrderPlaced, OrderShipped, OrderDelivered, OrderCancelled

5. Event Flow Timeline
Step 1: Customer issues AddItemToCart → Cart processes → CartItemAdded emitted
Step 2: Customer issues PlaceOrder → Order processes → OrderPlaced emitted ⚠️ (pivotal event)
Step 3: Payment Service issues ProcessPayment → Payment processes → PaymentProcessed emitted ⚠️ (hotspot: payment failure path)
Step 4: Inventory Service issues ReserveInventory → Inventory processes → InventoryReserved emitted ⚠️ (hotspot: out-of-stock scenario)
Step 5: Warehouse Staff issues ShipOrder → Shipment processes → OrderShipped emitted
Step 6: Carrier System issues ConfirmDelivery → Shipment processes → OrderDelivered emitted

Pivotal Events: OrderPlaced (triggers payment + inventory chain), PaymentProcessed (gates fulfillment)
Hotspots: Step 3 (payment failure handling), Step 4 (stock unavailability after payment)
```


**Expected Output Shape:**
```
1. Domain Events (Orange)
AccountRegistered — Company admin creates account; payload: accountId, email, companyName
EmailVerified — Admin verifies email address; payload: accountId, verifiedAt
TeamMemberInvited — Admin invites team member; payload: accountId, inviteeEmail, role
InvitationAccepted — Invitee accepts invitation; payload: accountId, userId, acceptedAt
SubscriptionStarted — Company selects and activates a plan; payload: accountId, planId, startedAt, billingCycle
TrialStarted — Company begins free trial; payload: accountId, trialEndsAt
TrialExpired — Trial period ends without conversion; payload: accountId, expiredAt

2. Commands (Blue)
RegisterAccount — issued by: Company Admin; produces: AccountRegistered; precondition: email not already registered
VerifyEmail — issued by: Admin (via email link); produces: EmailVerified; precondition: AccountRegistered
InviteTeamMember — issued by: Admin; produces: TeamMemberInvited; precondition: EmailVerified
AcceptInvitation — issued by: Invitee; produces: InvitationAccepted; precondition: invitation not expired
StartSubscription — issued by: Admin; produces: SubscriptionStarted; precondition: EmailVerified, payment method added

3. Aggregates (Yellow)
Account — handles: RegisterAccount, VerifyEmail; emits: AccountRegistered, EmailVerified; invariant: one account per email domain
Team — handles: InviteTeamMember, AcceptInvitation; emits: TeamMemberInvited, InvitationAccepted; invariant: invitations expire in 7 days
Subscription — handles: StartSubscription, CancelSubscription; emits: SubscriptionStarted, TrialStarted; invariant: one active subscription per account

4. Bounded Contexts
Identity Context: Account aggregate; produces: AccountRegistered, EmailVerified
Team Context: Team aggregate; produces: TeamMemberInvited, InvitationAccepted; consumes: AccountRegistered
Billing Context: Subscription aggregate; produces: SubscriptionStarted, TrialStarted; consumes: AccountRegistered
Onboarding Context: no aggregates; consumes: AccountRegistered, EmailVerified, SubscriptionStarted (triggers onboarding checklist)

5. Event Flow Timeline
Step 1: Admin issues RegisterAccount → Account processes → AccountRegistered emitted
Step 2: Admin issues VerifyEmail → Account processes → EmailVerified emitted ⚠️ (hotspot: email delivery failure)
Step 3: Admin issues InviteTeamMember → Team processes → TeamMemberInvited emitted
Step 4: Invitee issues AcceptInvitation → Team processes → InvitationAccepted emitted
Step 5: Admin issues StartSubscription → Subscription processes → SubscriptionStarted emitted ⚠️ (pivotal event)

Pivotal Events: EmailVerified (gates all downstream actions), SubscriptionStarted (activates product access)
Hotspots: Step 2 (email delivery reliability), Step 5 (payment method collection friction)
```
