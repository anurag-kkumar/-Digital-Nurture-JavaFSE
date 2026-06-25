public class GpayPayment implements PaymentStrategy {
    private String email;

    public GpayPayment(String email) {
        this.email = email;
    }

    @Override
    public void pay(int amount) {
        System.out.println("Paid " + amount + " using Gpay.");
    }
}