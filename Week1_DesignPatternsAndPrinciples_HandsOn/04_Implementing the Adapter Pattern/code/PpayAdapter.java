public class PpayAdapter implements PaymentProcessor {
    PpayGateway ppayGateway;

    public PpayAdapter() {
        ppayGateway = new PpayGateway();
    }

    @Override
    public void processPayment(double amount){
        System.out.println("Payment Processing");
        ppayGateway.pay(amount);
    }
}