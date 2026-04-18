# Example Output: snapshot-test-generation

## Example 1: React ProductCard component

```typescript
import { render } from '@testing-library/react';
import { ProductCard } from './ProductCard';

const baseProduct = {
  id: 'p1',
  name: 'Wireless Headphones',
  price: 99.99,
  imageUrl: 'https://example.com/headphones.jpg',
  inStock: true,
};

describe('ProductCard snapshots', () => {
  it('matches snapshot — default state', () => {
    const { container } = render(<ProductCard product={baseProduct} />);
    expect(container.firstChild).toMatchSnapshot();
  });

  it('matches snapshot — with discount badge', () => {
    const { container } = render(
      <ProductCard product={{ ...baseProduct, originalPrice: 149.99 }} />
    );
    expect(container.firstChild).toMatchSnapshot();
  });

  it('matches snapshot — out of stock', () => {
    const { container } = render(
      <ProductCard product={{ ...baseProduct, inStock: false }} />
    );
    expect(container.firstChild).toMatchSnapshot();
  });

  it('matches snapshot — loading skeleton', () => {
    const { container } = render(<ProductCard loading />);
    expect(container.firstChild).toMatchSnapshot();
  });
});
```

**Snapshot update policy:**
- Run `jest --updateSnapshot` only after intentional UI changes
- Always review the diff in PR — snapshot changes must be approved
- Dynamic values (IDs, timestamps) are mocked to static values in test setup

**What NOT to snapshot:**
- `Date.now()` — mock with `jest.useFakeTimers()`
- Random IDs — use fixed seed or mock `crypto.randomUUID`
- Third-party component internals — test behavior, not markup
