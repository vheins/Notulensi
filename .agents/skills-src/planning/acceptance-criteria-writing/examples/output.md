# Example Output: acceptance-criteria-writing

**Expected Output Shape:**
```
1. Happy Path Criteria
- When the user submits a valid registered email address on the forgot-password form, the system shall send a password reset email within 30 seconds.
- When the user clicks the reset link in the email, the system shall display the new password form if the token is valid and not expired.
- When the user submits a new password that meets the complexity requirements, the system shall update the password and redirect the user to the login page.
- The system shall invalidate the reset token immediately after it is used successfully.
- When the password is successfully reset, the system shall send a confirmation email to the user's registered address.

2. Edge Case Criteria
- When the user submits an email address that is not registered, the system shall display the same success message as a valid email (to prevent user enumeration).
- When the user requests a second reset token before the first expires, the system shall invalidate the first token and issue a new one.
- When the user submits the reset form with the same password as their current password, the system shall accept it without error.
- When the user clicks an expired reset link, the system shall display an error message and offer a link to request a new reset email.

3. Error and Failure Criteria
- When the user submits a password shorter than 8 characters, the system shall display an inline error: "Password must be at least 8 characters."
- When the user submits a password without an uppercase letter or number, the system shall display the specific missing requirement.
- When the email service is unavailable, the system shall return an error message and log the failure; the user shall be prompted to try again.
- When the reset token has been tampered with (invalid signature), the system shall return a 400 error and not reveal token details.

4. Non-Functional Criteria
- The password reset endpoint shall respond within 500ms at p95 under normal load.
- Reset tokens shall be cryptographically random (minimum 32 bytes of entropy) and stored as hashed values in the database.
- The new password form shall be accessible via keyboard navigation and compatible with screen readers (WCAG 2.1 AA).

Testability Notes: Criterion 2.1 (email enumeration prevention) requires manual verification that response timing is consistent. Criterion 4.2 (token entropy) requires a security audit or automated cryptographic test.
```


**Expected Output Shape:**
```
1. Happy Path Criteria
- When the user selects a supported file type under 25MB, the system shall upload the file to S3 and display it in the project file list within 10 seconds.
- When the upload is in progress, the system shall display a progress bar showing the percentage uploaded.
- When the upload completes successfully, the system shall display the file name, size, uploader name, and upload timestamp in the file list.
- The system shall generate a unique, non-guessable S3 key for each uploaded file.

2. Edge Case Criteria
- When the user uploads a file with a name containing special characters (e.g., spaces, accents), the system shall sanitize the filename and store it correctly.
- When the user uploads a duplicate filename in the same workspace, the system shall append a timestamp suffix rather than overwriting the existing file.
- When the user's network connection drops mid-upload, the system shall display an error and allow the user to retry the upload.

3. Error and Failure Criteria
- When the user selects a file larger than 25MB, the system shall reject the upload before it starts and display: "File exceeds the 25MB size limit."
- When the user selects an unsupported file type, the system shall display: "File type not supported. Allowed types: PDF, DOCX, XLSX, PNG, JPG."
- When S3 is unavailable, the system shall display a user-friendly error and log the failure with the file metadata for retry.

4. Non-Functional Criteria
- File upload shall complete within 10 seconds for a 10MB file on a standard broadband connection.
- S3 pre-signed URLs used for upload shall expire within 5 minutes of generation.
- The file upload input shall be keyboard-accessible and include an ARIA label for screen reader compatibility.

Testability Notes: Criterion 3.3 (S3 unavailability) requires mocking S3 in integration tests. Criterion 4.1 (upload speed) requires a performance test with a real 10MB file.
```
