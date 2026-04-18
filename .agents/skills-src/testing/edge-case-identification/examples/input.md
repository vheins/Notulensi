# Example Input: edge-case-identification

## Example 1: File upload handler

| Variable | Value |
|----------|-------|
| `{{code_context}}` | `uploadFile(file: File, userId: string): Promise<string>` — validates file type (jpg/png/pdf only), max 50MB, uploads to S3, returns public URL |
| `{{tech_stack}}` | Node.js + TypeScript + AWS S3 |
| `{{context}}` | Used in profile picture upload and document submission flows |
