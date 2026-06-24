public class Main {
    public static void main(String[] args) {



        Computer.Builder builder = new Computer.Builder();
        builder.setCPU("Intel i5");
        builder.setRAM("16GB ");
        builder.setSTORAGE("512GB SSD");

        System.out.println(builder.build());

        System.out.println();

        builder = new Computer.Builder();
        builder.setCPU("AMD Ryzen 7");
        builder.setRAM("8GB ");
        builder.setSTORAGE("512GB SSD");

        System.out.println(builder.build());
    }
}