public class ExcelDocument implements Document {


    public ExcelDocument(){
        System.out.println("excel Document Created");
    }

    @Override
    public void open(){
        System.out.println("Opening the Excel");
    }

    @Override
    public void close(){
        System.out.println("Closing the Excel");
    }

}