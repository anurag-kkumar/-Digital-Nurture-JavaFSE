
public class Main {
    public static void main(String[] args) {

        System.out.println();

        Student model = new Student("Anurag", 1, "A");

        StudentView view = new StudentView();

        StudentController controller = new StudentController(model, view);

        controller.updateView();

        controller.setStudentName("aditya");
        controller.setStudentGrade("B");

        controller.updateView();
    }
}