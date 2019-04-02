package sample_black_box;

public class BlackBoxSwitcher {

    public static boolean BUG_1 = true;

    public static void main(String[] args) {
        boolean newBug1 = Boolean.getBoolean(args[0]);
        BUG_1 = newBug1;
    }
}
