# Example Output: cors-error-resolution

**Expected Output Shape:**
```
1. CORS Error Classification
Wildcard origin with credentials — browser blocks requests with credentials (cookies) when server responds with Access-Control-Allow-Origin: *.

2. Request Analysis
Credentialed request (credentials: 'include' sends cookies). Requires:
- Specific origin (not wildcard)
- Access-Control-Allow-Credentials: true

3. Server-Side Fix
Before:
  app.use(cors({ origin: '*' }));

After:
  app.use(cors({
    origin: 'https://app.example.com',  // specific origin, not wildcard
    credentials: true,                   // sets Access-Control-Allow-Credentials: true
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  }));

4. Security Considerations
- Use an origin whitelist array for multiple allowed origins
- Never reflect Origin header without validation
- Add Vary: Origin header (cors package does this automatically)

5. Testing
curl -H "Origin: https://app.example.com" \
  -H "Access-Control-Request-Method: POST" \
  -X OPTIONS -v https://api.example.com/users
# Expect: Access-Control-Allow-Origin: https://app.example.com
# Expect: Access-Control-Allow-Credentials: true
```


**Expected Output Shape:**
```
1. CORS Error Classification
Missing Access-Control-Allow-Headers — the preflight response does not include X-Custom-Token in the allowed headers list.

2. Request Analysis
Preflight triggered by custom header X-Custom-Token. Browser sends OPTIONS request first. Server must respond with Access-Control-Allow-Headers including X-Custom-Token.

3. Server-Side Fix
Before:
  app.add_middleware(CORSMiddleware,
    allow_origins=["https://dashboard.example.com"],
    allow_methods=["*"])

After:
  app.add_middleware(CORSMiddleware,
    allow_origins=["https://dashboard.example.com"],
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["Content-Type", "Authorization", "X-Custom-Token"],  # added
    allow_credentials=True,
  )

4. Security Considerations
- List only the headers your API actually uses in allow_headers
- Avoid allow_headers=["*"] in production — enumerate explicitly

5. Testing
curl -H "Origin: https://dashboard.example.com" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: X-Custom-Token" \
  -X OPTIONS -v https://api.example.com/data
# Expect: Access-Control-Allow-Headers: content-type, authorization, x-custom-token
```
