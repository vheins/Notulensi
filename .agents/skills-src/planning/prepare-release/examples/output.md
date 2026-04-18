# Example Output: prepare-release

## Release Preparation: v1.5.0

### Version Bump

| File | Before | After |
|------|--------|-------|
| `package.json` | `"version": "1.4.2"` | `"version": "1.5.0"` |
| `package-lock.json` | `"version": "1.4.2"` | `"version": "1.5.0"` |

### CHANGELOG.md Entry

```markdown
## [1.5.0] - 2026-03-21

### Added
- Multi-currency payment support (USD, EUR, GBP, SGD)
- Daily exchange rate sync via cron job
- Currency selector on checkout page

### Changed
- `OrderService.create()` now accepts optional `currency_code` parameter
- Checkout flow updated to pass currency to Stripe PaymentIntent

### Fixed
- Order total rounding error for quantities > 1000

### Migration Required
- Run: `npm run migrate` — adds `currency_code` and `exchange_rate` columns to `orders`
- Run: `npm run seed:exchange-rates` — seeds initial exchange rates
```

### Git Commands

```bash
git add CHANGELOG.md package.json package-lock.json
git commit -m "chore: bump version to 1.5.0"
git tag -a v1.5.0 -m "Release v1.5.0"
git push origin master --tags
```

### Pre-Release Checklist

- [ ] All tests passing (`npm test`)
- [ ] Migration tested on staging
- [ ] CHANGELOG entry reviewed
- [ ] Version bumped in all files
- [ ] Git tag created and pushed
