# Example Input: code-review

### Example 1: TypeScript + Express + PostgreSQL

**Input:**
- `{{tech_stack}}`: TypeScript + Express + PostgreSQL
- `{{code}}`:
```typescript
app.get('/admin/users', (req, res) => {
  const role = req.headers['x-role'];
  if (role === 'admin') {
    db.query(`SELECT * FROM users WHERE name LIKE '%${req.query.search}%'`)
      .then(result => res.json(result.rows))
      .catch(err => res.json({ error: err }));
  }
});
```
- `{{context}}`: "Admin endpoint to search users by name. Role is passed in a custom header."

---

### Example 2: Python + Django

**Input:**
- `{{tech_stack}}`: Python + Django + Django REST Framework
- `{{code}}`:
```python
class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def list(self, request):
        products = Product.objects.all()
        for product in products:
            product.category_name = product.category.name
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)
```
- `{{context}}`: "API endpoint listing all products with their category names."
