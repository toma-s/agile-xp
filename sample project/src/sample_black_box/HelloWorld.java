package sample_black_box;

class HelloWorld {

    private BlackBoxSwitcher switcher = new BlackBoxSwitcher();

    int returnTheSame(int input) {
        if (switcher.BUGS[0]) {
            if (input == 1) {
                return -1;
            }
        }
        if (switcher.BUGS[1]) {
            if (input == 2) {
                return -2;
            }
        }
        return input;
    }
}
