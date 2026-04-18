# Example Output: authentication-token-debugging

**Expected Output Shape:**
```
1. Error Classification
TokenExpiredError — the exp claim (1700003600) is in the past. The token was valid for 1 hour and has expired.

2. Root Cause Analysis
The client is sending an expired access token. The application does not implement token refresh — it expects the user to re-login when the token expires.

3. Fix
Implement token refresh middleware:

// Middleware: attempt refresh on 401
async function refreshOnExpiry(err, req, res, next) {
  if (err.name !== 'TokenExpiredError') return next(err);
  const refreshToken = req.cookies.refreshToken;
  if (!refreshToken) return res.status(401).json({ error: 'Session expired' });
  try {
    const payload = jwt.verify(refreshToken, process.env.REFRESH_SECRET);
    const newAccessToken = jwt.sign({ sub: payload.sub }, process.env.JWT_SECRET, { expiresIn: '15m' });
    res.setHeader('X-New-Access-Token', newAccessToken);
    req.user = payload;
    next();
  } catch {
    res.status(401).json({ error: 'Refresh token expired, please login again' });
  }
}

4. Security Hardening
- Access token TTL: 15 minutes (not 1 hour)
- Refresh token TTL: 7 days, stored in httpOnly cookie
- Implement refresh token rotation: issue new refresh token on each refresh
- Add clock skew tolerance: jwt.verify(token, secret, { clockTolerance: 30 })

5. Testing
it('returns 401 with expired token', async () => {
  const expired = jwt.sign({ sub: 'user1' }, SECRET, { expiresIn: -1 });
  const res = await request(app).get('/api/me').set('Authorization', `Bearer ${expired}`);
  expect(res.status).toBe(401);
});
```


**Expected Output Shape:**
```
1. Error Classification
invalid_grant — the OAuth2 authorization code was already exchanged for tokens. Authorization codes are single-use and expire quickly (typically 10 minutes).

2. Root Cause Analysis
Two likely causes:
A) The authorization code exchange endpoint is called twice (double-submit, retry logic, or browser back button)
B) The code was intercepted and used by an attacker before the legitimate client

3. Fix
Add idempotency protection on the token exchange endpoint:

# Store used codes in Redis with TTL matching code expiry
async def exchange_code(code: str, db: Redis):
    if await db.get(f"used_code:{code}"):
        raise HTTPException(status_code=400, detail="Authorization code already used")
    await db.setex(f"used_code:{code}", 600, "1")  # mark as used for 10 minutes
    # proceed with token exchange

4. Security Hardening
- Use PKCE (Proof Key for Code Exchange) to prevent code interception
- Set authorization code TTL to 60 seconds (not 10 minutes)
- Implement code binding to client IP or device fingerprint
- Log and alert on duplicate code usage attempts (potential attack signal)

5. Testing
def test_code_cannot_be_reused(client, auth_code):
    response1 = client.post("/token", data={"code": auth_code})
    assert response1.status_code == 200
    response2 = client.post("/token", data={"code": auth_code})
    assert response2.status_code == 400
    assert response2.json()["detail"] == "Authorization code already used"
```
