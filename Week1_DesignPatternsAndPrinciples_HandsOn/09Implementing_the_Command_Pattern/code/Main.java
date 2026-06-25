public class Main {
    public static void main(String[] args) {

        System.out.println();

        Light l = new Light();

        Command lightOn = new LightOnCmd(l);
        Command lightOff = new LightOffcmd(l);

        RemoteControl remote = new RemoteControl();

        remote.setCommand(lightOn);
        remote.pressButton();

        remote.setCommand(lightOff);
        remote.pressButton();
    }
}