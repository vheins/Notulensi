# Example Input: refactoring

### Example 1: TypeScript + React
**Input:**
- `{{tech_stack}}`: TypeScript + React + hooks
- `{{code}}`:
```typescript
function UserList() {
  const [users, setUsers] = React.useState([]);
  const [loading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(null);

  React.useEffect(() => {
    setLoading(true);
    fetch('/api/users').then(r => r.json()).then(data => {
      setUsers(data);
      setLoading(false);
    }).catch(e => {
      setError(e.message);
      setLoading(false);
    });
  }, []);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  return <ul>{users.map(u => <li key={u.id}>{u.name}</li>)}</ul>;
}
```
- `{{refactoring_goals}}`: "Improve readability, extract data fetching logic, add proper TypeScript types"


### Example 2: Go + Gin
**Input:**
- `{{tech_stack}}`: Go + Gin
- `{{code}}`:
```go
func getUser(c *gin.Context) {
    id := c.Param("id")
    var user User
    result := db.Where("id = ?", id).First(&user)
    if result.Error != nil {
        c.JSON(500, gin.H{"error": result.Error.Error()})
        return
    }
    c.JSON(200, user)
}
```
- `{{refactoring_goals}}`: "Improve error handling, distinguish not-found from server errors, add input validation"
