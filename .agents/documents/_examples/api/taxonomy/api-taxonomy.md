# API Specification: Taxonomy

## Navigation
- [Overview](../../modules/taxonomy/overview.md) | [Feature](../../modules/taxonomy/taxonomy-management.md) | [Testing](../../testing/taxonomy/test-taxonomy.md)

## 1. Standards
- **Base URL:** `/api/v1`
- **Auth:** `Bearer <token>`

## 2. Endpoints

### 2.1 List Taxonomies
- `GET /taxonomies`
- **200 OK:**
```json
{
  "data": [
    {
      "id": "uuid",
      "slug": "product_category",
      "name": "Product Category",
      "is_hierarchical": true
    }
  ]
}
```

### 2.2 Get Terms
- `GET /taxonomies/{slug}/terms`
- **200 OK:**
```json
{
  "data": [
    {
      "id": "uuid",
      "slug": "electronics",
      "name": "Electronics",
      "parent_id": null,
      "children": []
    }
  ]
}
```

### 2.3 Attach to Entity
- `POST /taxonomy-attachments`
- **Request:**
```json
{
  "entity_type": "product",
  "entity_id": "product-uuid-123",
  "term_slug": "electronics",
  "taxonomy_slug": "product_category"
}
```
- **201 Created:** `{ "message": "Attached successfully." }`

### 2.4 Detach from Entity
- `DELETE /taxonomy-attachments`
- **Request:**
```json
{
  "entity_type": "product",
  "entity_id": "product-uuid-123",
  "term_slug": "electronics"
}
```
- **204 No Content**
