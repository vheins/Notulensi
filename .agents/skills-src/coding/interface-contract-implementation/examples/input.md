# Example Input: interface-contract-implementation

### Example 1: TypeScript — Repository Pattern
**Input:**
- `{{tech_stack}}`: TypeScript + Node.js + Prisma
- `{{interface_definition}}`:
```typescript
interface UserRepository {
  findById(id: string): Promise<User | null>;
  findByEmail(email: string): Promise<User | null>;
  create(data: CreateUserInput): Promise<User>;
  update(id: string, data: UpdateUserInput): Promise<User>;
  delete(id: string): Promise<void>;
  findAll(options?: PaginationOptions): Promise<PaginatedResult<User>>;
}
```
- `{{context}}`: "Prisma ORM with PostgreSQL. User model has: id (uuid), email, name, createdAt. PaginationOptions: { page: number, limit: number }. PaginatedResult: { data: T[], total: number, page: number }."


### Example 2: Java + Spring Boot — Service Interface
**Input:**
- `{{tech_stack}}`: Java 17 + Spring Boot + JPA
- `{{interface_definition}}`:
```java
public interface NotificationService {
    void sendEmail(String to, String subject, String body);
    void sendSms(String phoneNumber, String message);
    List<Notification> getHistory(String userId, int limit);
    void markAsRead(String notificationId);
}
```
- `{{context}}`: "Spring Boot service. Email via JavaMailSender. SMS via Twilio REST client. Notification JPA entity with: id, userId, type, content, readAt, createdAt."
