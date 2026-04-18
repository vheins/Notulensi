# Example Output: refactoring

**Expected Output Shape:**
```typescript
// Extracted types for clarity and reuse
interface User { id: string; name: string; }
type FetchState<T> = { data: T | null; loading: boolean; error: string | null; };

// Custom hook isolates data fetching — component stays pure presentational
function useUsers(): FetchState<User[]> {
  const [state, setState] = React.useState<FetchState<User[]>>({
    data: null, loading: true, error: null
  });

  React.useEffect(() => {
    fetch('/api/users')
      .then(r => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json() as Promise<User[]>;
      })
      .then(data => setState({ data, loading: false, error: null }))
      .catch(e => setState({ data: null, loading: false, error: e.message }));
  }, []);

  return state;
}

function UserList() {
  const { data: users, loading, error } = useUsers();
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  return <ul>{users!.map(u => <li key={u.id}>{u.name}</li>)}</ul>;
}
```

Change Log:
1. Extracted `useUsers` hook — separates data fetching from rendering; makes component testable without mocking fetch
2. Added `User` and `FetchState<T>` types — eliminates implicit `any`, catches type errors at compile time
3. Added HTTP status check (`r.ok`) — original silently treated 4xx/5xx as success
4. Consolidated state into single object — prevents impossible states (loading=true + error set simultaneously)


**Expected Output Shape:**
```go
func getUser(c *gin.Context) {
    id := c.Param("id")

    // Validate that id is a non-empty string before hitting the DB
    if id == "" {
        c.JSON(http.StatusBadRequest, gin.H{"error": "user id is required"})
        return
    }

    var user User
    result := db.Where("id = ?", id).First(&user)

    // Distinguish record-not-found from actual DB errors — different HTTP semantics
    if errors.Is(result.Error, gorm.ErrRecordNotFound) {
        c.JSON(http.StatusNotFound, gin.H{"error": "user not found"})
        return
    }
    if result.Error != nil {
        // Log full error internally; don't expose DB internals to client
        log.Printf("getUser DB error for id=%s: %v", id, result.Error)
        c.JSON(http.StatusInternalServerError, gin.H{"error": "internal server error"})
        return
    }

    c.JSON(http.StatusOK, user)
}
```

Change Log:
1. Added empty `id` check — original would pass empty string to DB query
2. Separated `ErrRecordNotFound` from generic errors — original returned 500 for missing users (should be 404)
3. Used `http.Status*` constants — more readable than magic numbers
4. Added internal logging before 500 response — original swallowed DB error details
