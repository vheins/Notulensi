# Example Output: interface-contract-implementation

**Expected Output Shape:**
```typescript
class PrismaUserRepository implements UserRepository {
  constructor(private readonly prisma: PrismaClient) {}

  /** Find a user by their UUID. Returns null if not found. */
  async findById(id: string): Promise<User | null> {
    if (!id) throw new Error('id is required');
    return this.prisma.user.findUnique({ where: { id } });
  }

  /** Find a user by email address (case-insensitive). Returns null if not found. */
  async findByEmail(email: string): Promise<User | null> {
    if (!email) throw new Error('email is required');
    return this.prisma.user.findUnique({
      where: { email: email.toLowerCase() }
    });
  }

  /** Create a new user. Throws if email already exists (Prisma unique constraint). */
  async create(data: CreateUserInput): Promise<User> {
    return this.prisma.user.create({
      data: { ...data, email: data.email.toLowerCase() }
    });
  }

  /** Update user fields. Throws if user not found. */
  async update(id: string, data: UpdateUserInput): Promise<User> {
    return this.prisma.user.update({ where: { id }, data });
    // Prisma throws PrismaClientKnownRequestError P2025 if record not found
  }

  /** Delete a user by ID. No-op if user does not exist. */
  async delete(id: string): Promise<void> {
    await this.prisma.user.delete({ where: { id } }).catch(e => {
      if (e.code === 'P2025') return; // Record not found — treat as success
      throw e;
    });
  }

  /** List users with pagination. Defaults to page 1, limit 20. */
  async findAll(options: PaginationOptions = { page: 1, limit: 20 }): Promise<PaginatedResult<User>> {
    const { page, limit } = options;
    const offset = (page - 1) * limit;
    const [data, total] = await this.prisma.$transaction([
      this.prisma.user.findMany({ skip: offset, take: limit }),
      this.prisma.user.count(),
    ]);
    return { data, total, page };
  }
}
```


**Expected Output Shape:**
```java
@Service
@Slf4j
public class NotificationServiceImpl implements NotificationService {

    private final JavaMailSender mailSender;
    private final TwilioClient twilioClient;
    private final NotificationRepository notificationRepository;

    public NotificationServiceImpl(JavaMailSender mailSender,
                                   TwilioClient twilioClient,
                                   NotificationRepository notificationRepository) {
        this.mailSender = mailSender;
        this.twilioClient = twilioClient;
        this.notificationRepository = notificationRepository;
    }

    /** Send an email notification. Logs failure but does not throw — fire-and-forget semantics. */
    @Override
    public void sendEmail(String to, String subject, String body) {
        Assert.hasText(to, "Recipient email must not be blank");
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            mailSender.send(message);
            notificationRepository.save(new Notification(to, "EMAIL", body));
        } catch (MailException e) {
            log.error("Failed to send email to {}: {}", to, e.getMessage());
        }
    }

    /** Send an SMS. Throws IllegalArgumentException for invalid phone format. */
    @Override
    public void sendSms(String phoneNumber, String message) {
        if (!phoneNumber.matches("\\+[1-9]\\d{7,14}")) {
            throw new IllegalArgumentException("Phone number must be in E.164 format: " + phoneNumber);
        }
        twilioClient.messages().create(phoneNumber, message);
        notificationRepository.save(new Notification(phoneNumber, "SMS", message));
    }

    @Override
    public List<Notification> getHistory(String userId, int limit) {
        return notificationRepository.findByUserIdOrderByCreatedAtDesc(userId, PageRequest.of(0, limit));
    }

    @Override
    public void markAsRead(String notificationId) {
        notificationRepository.findById(notificationId).ifPresent(n -> {
            n.setReadAt(Instant.now());
            notificationRepository.save(n);
        });
    }
}
```
