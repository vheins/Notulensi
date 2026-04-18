# Example Output: accessibility-test-case-writing

## Example 1: React Login Form

```typescript
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { axe, toHaveNoViolations } from 'jest-axe';
import { LoginForm } from './LoginForm';

expect.extend(toHaveNoViolations);

describe('LoginForm — Accessibility', () => {
  it('has no axe violations in default state', async () => {
    const { container } = render(<LoginForm onSubmit={jest.fn()} />);
    expect(await axe(container)).toHaveNoViolations();
  });

  it('has no axe violations in error state', async () => {
    const { container } = render(<LoginForm onSubmit={jest.fn()} error="Invalid credentials" />);
    expect(await axe(container)).toHaveNoViolations();
  });

  it('all inputs have associated labels', () => {
    render(<LoginForm onSubmit={jest.fn()} />);
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument();
  });

  it('error message is announced to screen readers', async () => {
    render(<LoginForm onSubmit={jest.fn()} error="Invalid credentials" />);
    const alert = screen.getByRole('alert');
    expect(alert).toHaveTextContent('Invalid credentials');
  });

  it('form is keyboard navigable in correct tab order', async () => {
    render(<LoginForm onSubmit={jest.fn()} />);
    const email = screen.getByLabelText(/email/i);
    const password = screen.getByLabelText(/password/i);
    const submit = screen.getByRole('button', { name: /sign in/i });

    email.focus();
    expect(document.activeElement).toBe(email);
    await userEvent.tab();
    expect(document.activeElement).toBe(password);
    await userEvent.tab();
    expect(document.activeElement).toBe(submit);
  });

  it('submit button has accessible name', () => {
    render(<LoginForm onSubmit={jest.fn()} />);
    expect(screen.getByRole('button', { name: /sign in/i })).toBeInTheDocument();
  });
});
```
