public class Main {
    public static void main(String[] args) {
        Inventory inventory = new Inventory();

        inventory.addProduct(new Product(1, "Laptop", 50, 10000));
        inventory.addProduct(new Product(2, "Mouse", 340, 650));
        inventory.addProduct(new Product(3, "Keyboard", 700, 800));

        inventory.displayProduct();
        System.out.println();

        inventory.updateProduct(new Product(2, "RAM", 500, 3000));

        inventory.displayProduct();
        System.out.println();

        inventory.removeProduct(5);

        inventory.displayProduct();
    }
}