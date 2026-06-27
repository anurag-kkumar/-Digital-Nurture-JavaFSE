public class Cart {
    private Order[] orders = new Order[5];

    public void shuffleOrders() {

        orders[0] = new Order(1, "anurag", 1333);
        orders[1] = new Order(2, "aryan", 7954);

        orders[2] = new Order(3, "vishal", 4545);

        orders[3] = new Order(4, "deep", 2312);
        orders[4] = new Order(5, "pandey", 9535);

    }

    public Order[] getOrders(){
        return orders;
    }

    public void displayOrders(Order[] orders){
        for(Order order : orders){
            System.out.printf("Id : %d | Customer Name : %s | Total Price : %d\n", order.getOrderId(), order.getCustomerName(), order.getTotalPrice());
        }
    }

    public void bubbleSort(Order[] orders) {
        int n = orders.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (orders[j].getTotalPrice() > orders[j + 1].getTotalPrice()) {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }

    public void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pi = partition(orders, low, high);
            quickSort(orders, low, pi - 1);
            quickSort(orders, pi + 1, high);
        }
    }

    private int partition(Order[] orders, int low, int high) {
        int pivot = orders[high].getTotalPrice();
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (orders[j].getTotalPrice() < pivot) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }
        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;
        return i + 1;
    }
}