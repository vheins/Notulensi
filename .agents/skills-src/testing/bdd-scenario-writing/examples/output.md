# Example Output: bdd-scenario-writing

## Example 1: User Login Feature

```gherkin
Feature: User Login
  As a registered user
  I want to log in with my email and password
  So that I can access my account

  Background:
    Given a registered user exists with email "user@example.com" and password "SecurePass123!"

  Scenario: Successful login with valid credentials
    When I submit login with email "user@example.com" and password "SecurePass123!"
    Then I receive a 200 response
    And the response contains a JWT access token
    And the response contains a refresh token

  Scenario: Login fails with wrong password
    When I submit login with email "user@example.com" and password "WrongPassword"
    Then I receive a 401 response
    And the response contains error "Invalid credentials"

  Scenario: Login fails with unregistered email
    When I submit login with email "nobody@example.com" and password "AnyPassword"
    Then I receive a 401 response
    And the response contains error "Invalid credentials"

  Scenario: Account is locked after 5 failed attempts
    When I submit login with wrong password 5 times for "user@example.com"
    Then I receive a 429 response
    And the response contains error "Account temporarily locked"
    And the response contains "retryAfter" in seconds

  Scenario: Locked account cannot login even with correct password
    Given the account "user@example.com" is locked
    When I submit login with email "user@example.com" and password "SecurePass123!"
    Then I receive a 429 response

  Scenario: Login with missing email field
    When I submit login with no email and password "SecurePass123!"
    Then I receive a 400 response
    And the response contains validation error for "email"
```
