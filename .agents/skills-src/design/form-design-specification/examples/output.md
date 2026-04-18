# Example Output: form-design-specification

## Scenario: Default

> Output yang dihasilkan ketika diberikan input dari `input.md`

**1. Field Inventory**

| Field Name | Type | Label | Placeholder | Required | Validation Rules | Error Messages | Help Text |
|------------|------|-------|-------------|----------|------------------|----------------|-----------|
| firstName | text | First Name | Jane | yes | required, minLength: 2, maxLength: 50 | "First name is required." | — |
| lastName | text | Last Name | Doe | yes | required, minLength: 2, maxLength: 50 | "Last name is required." | — |
| email | email | Email Address | jane@example.com | yes | required, pattern: RFC 5322 email | "Enter a valid email address." | — |
| password | password | Password | •••••••• | yes | required, minLength: 8, pattern: complexity | "Must be 8+ chars with a number." | Must be at least 8 characters. |
| confirmPassword | password | Confirm Password | •••••••• | yes | required, matches: password | "Passwords do not match." | — |
| termsAccepted | checkbox | I agree to the Terms of Service | — | yes | required: true | "You must accept the terms to continue." | — |

**2. Submission Behavior**

- Loading: Submit button shows spinner and "Creating account…"; all fields disabled
- Success: Form replaced with "Account created! Check your email to verify."
- Error: aria-live banner above form: "Something went wrong. Please try again."

**3. Accessibility Notes**

- All labels use `htmlFor` matching field `id`
- `aria-required="true"` on all required fields
- `aria-describedby` links each field to its error message span
- Tab order: firstName → lastName → email → password → confirmPassword → termsAccepted → Submit

**4. Framework Implementation Notes**

```js
// React Hook Form with onBlur mode
const { register, handleSubmit, formState: { errors } } = useForm({ mode: "onBlur" });
// shadcn/ui Input with error state
<Input className={errors.email ? "border-destructive" : ""} {...register("email", { required: "Email is required." })} />
```
