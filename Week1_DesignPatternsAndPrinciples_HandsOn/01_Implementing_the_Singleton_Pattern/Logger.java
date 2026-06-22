class Logger {
    private static Logger inst;
    private Logger() {}

    public static Logger getInst() {
        if (inst == null) {
            inst = new Logger();
        }
        return inst;
    }

}