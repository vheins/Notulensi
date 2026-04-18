# Example Input: cors-error-resolution

### Example 1: Node.js + Express — Credentialed Request
**Input:**
- `{{tech_stack}}`: Node.js + Express
- `{{error_message}}`: `Access to fetch at 'https://api.example.com/users' from origin 'https://app.example.com' has been blocked by CORS policy: The value of the 'Access-Control-Allow-Origin' header in the response must not be the wildcard '*' when the request's credentials mode is 'include'`
- `{{request_details}}`: POST https://api.example.com/users, Origin: https://app.example.com, credentials: 'include' (cookies sent)
- `{{server_config}}`: `app.use(cors({ origin: '*' }))`


### Example 2: Python + FastAPI — Custom Headers Preflight
**Input:**
- `{{tech_stack}}`: Python + FastAPI
- `{{error_message}}`: `Request header field X-Custom-Token is not allowed by Access-Control-Allow-Headers in preflight response`
- `{{request_details}}`: POST https://api.example.com/data, Origin: https://dashboard.example.com, custom header: X-Custom-Token
- `{{server_config}}`: `app.add_middleware(CORSMiddleware, allow_origins=["https://dashboard.example.com"], allow_methods=["*"])`
