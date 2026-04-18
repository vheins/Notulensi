# Example Output: sdk-library-integration

**Expected Output Shape:**
```typescript
// Domain interface — application code depends only on this
interface PaymentService {
  createPaymentIntent(amount: number, currency: string, customerId: string): Promise<PaymentIntent>;
  confirmPayment(paymentIntentId: string): Promise<PaymentResult>;
}

type PaymentIntent = { id: string; clientSecret: string; status: string };
type PaymentResult = { success: boolean; transactionId: string };

// Real implementation using Stripe SDK
class StripePaymentService implements PaymentService {
  private stripe: Stripe;

  constructor(apiKey: string) {
    // Initialize once — Stripe client is thread-safe and reusable
    this.stripe = new Stripe(apiKey, { apiVersion: '2024-04-10', maxNetworkRetries: 3 });
  }

  async createPaymentIntent(amount: number, currency: string, customerId: string): Promise<PaymentIntent> {
    try {
      const intent = await this.stripe.paymentIntents.create({
        amount: Math.round(amount * 100), // Stripe uses cents
        currency,
        customer: customerId,
      });
      return { id: intent.id, clientSecret: intent.client_secret!, status: intent.status };
    } catch (err) {
      if (err instanceof Stripe.errors.StripeCardError) {
        throw new PaymentDeclinedError(err.message, err.code);
      }
      throw new PaymentServiceError('Failed to create payment intent', err as Error);
    }
  }

  async confirmPayment(paymentIntentId: string): Promise<PaymentResult> {
    const intent = await this.stripe.paymentIntents.confirm(paymentIntentId);
    return { success: intent.status === 'succeeded', transactionId: intent.id };
  }
}

// Mock for testing
class MockPaymentService implements PaymentService {
  private shouldFail = false;
  setFailure(fail: boolean) { this.shouldFail = fail; }

  async createPaymentIntent(amount: number, currency: string): Promise<PaymentIntent> {
    if (this.shouldFail) throw new PaymentDeclinedError('Card declined', 'card_declined');
    return { id: `pi_test_${Date.now()}`, clientSecret: 'test_secret', status: 'requires_confirmation' };
  }

  async confirmPayment(paymentIntentId: string): Promise<PaymentResult> {
    return { success: true, transactionId: paymentIntentId };
  }
}

// DI wiring
const paymentService: PaymentService = process.env.NODE_ENV === 'test'
  ? new MockPaymentService()
  : new StripePaymentService(process.env.STRIPE_API_KEY!);
```


**Expected Output Shape:**
```python
from abc import ABC, abstractmethod
from dataclasses import dataclass

@dataclass
class UploadResult:
    key: str
    url: str

class FileStorageService(ABC):
    @abstractmethod
    def upload(self, key: str, data: bytes, content_type: str) -> UploadResult: ...
    @abstractmethod
    def get_presigned_url(self, key: str, expires_in: int = 3600) -> str: ...
    @abstractmethod
    def delete(self, key: str) -> None: ...

class S3FileStorageService(FileStorageService):
    def __init__(self, bucket: str, region: str):
        self.bucket = bucket
        self.client = boto3.client('s3', region_name=region)

    def upload(self, key: str, data: bytes, content_type: str) -> UploadResult:
        try:
            self.client.put_object(Bucket=self.bucket, Key=key, Body=data, ContentType=content_type)
            url = f"https://{self.bucket}.s3.amazonaws.com/{key}"
            return UploadResult(key=key, url=url)
        except ClientError as e:
            raise StorageError(f"Upload failed: {e.response['Error']['Message']}") from e

    def get_presigned_url(self, key: str, expires_in: int = 3600) -> str:
        return self.client.generate_presigned_url(
            'get_object', Params={'Bucket': self.bucket, 'Key': key}, ExpiresIn=expires_in
        )

    def delete(self, key: str) -> None:
        self.client.delete_object(Bucket=self.bucket, Key=key)

class InMemoryFileStorageService(FileStorageService):
    """Mock implementation for tests — no AWS credentials needed."""
    def __init__(self):
        self._store: dict[str, bytes] = {}

    def upload(self, key: str, data: bytes, content_type: str) -> UploadResult:
        self._store[key] = data
        return UploadResult(key=key, url=f"mock://bucket/{key}")

    def get_presigned_url(self, key: str, expires_in: int = 3600) -> str:
        return f"mock://presigned/{key}?expires={expires_in}"

    def delete(self, key: str) -> None:
        self._store.pop(key, None)
```
