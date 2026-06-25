public class LightOffcmd implements Command {
    private Light light;

    public LightOffcmd(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOff();
    }
}