public class Main {
    public static void main(String[] args) {
        StockMarket stockMarket = new StockMarket("Grow", 230.0);

        MobileApp mobileApp = new MobileApp("mobile");
        WebApp webApp = new WebApp("web");

        stockMarket.register(mobileApp);
        stockMarket.register(webApp);

        System.out.println("Updating Stock Price");
        stockMarket.setStockPrice(145.0);

        stockMarket.deregister(mobileApp);

        System.out.println();

        System.out.println("Updating Stock Price");
        stockMarket.setStockPrice(210.0);
    }
}