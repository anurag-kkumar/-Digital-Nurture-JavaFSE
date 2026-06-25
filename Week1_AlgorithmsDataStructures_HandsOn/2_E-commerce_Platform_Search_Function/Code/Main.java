public class Main {
    public static void main(String[] args) {
        Stored shop = new Stored();
        long start, end;
        int productId;


        shop.storeProducts();



        System.out.println("Linear Search :");
        start = System.nanoTime();
        productId = shop.linearSearch(4);
        end = System.nanoTime();
        shop.displayProduct(productId);
        System.out.println("Time Taken : "+(end - start));




        System.out.println("Binary Search :");
        start = System.nanoTime();
        productId = shop.binarySearch(4);
        end = System.nanoTime();
        shop.displayProduct(productId);
        System.out.println("Time Taken : "+(end - start));
    }
}