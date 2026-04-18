# Example Output: user-flow-diagram-description

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Flow Overview**

A returning or guest shopper navigates from their Shopping Cart through address entry, payment, and order confirmation. The happy path contains 6 steps.

**2. Node List**

| Node | Type | Name | Description |
|------|------|------|-------------|
| N1 | Entry | Cart Page | User reviews items and initiates checkout |
| N2 | Decision | Auth Check | System checks whether the user is logged in |
| N3 | Screen | Guest/Login Screen | User chooses to log in, register, or continue as guest |
| N4 | Screen | Shipping Address | User enters or confirms their delivery address |
| N5 | Screen | Payment | User enters payment details via Stripe form |
| N6 | Decision | Payment Validation | Stripe processes the charge and returns a result |
| N7 | Exit | Order Confirmation | User sees order summary and confirmation number |
| N8 | Exit | Payment Error | User sees payment failure message with retry option |

**3. Edge List**

| Edge | From → To | Trigger | Label |
|------|-----------|---------|-------|
| E1 | N1 → N2 | Clicks "Checkout" | Proceed to checkout |
| E2 | N2 → N3 | User is not logged in | Not authenticated |
| E3 | N2 → N4 | User is logged in | Authenticated |
| E7 | N6 → N7 | Payment succeeds | Order placed |
| E8 | N6 → N8 | Payment fails | Payment declined |

**4. Error Paths**

- ERR1: Payment declined → user returned to N5 with error banner; can retry with new card
- ERR2: Session timeout → user redirected to N3 (Login); cart preserved via local storage
