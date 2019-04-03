package sample_black_box;

class HelloWorld {

    private BlackBoxSwitcher switcher = new BlackBoxSwitcher();

    int test(int a) {
        if (switcher.BUGS[0]) {
            if (a == 1) {
                return -1;
            }
        }
        if (switcher.BUGS[1]) {
            if (a == 2) {
                return -2;
            }
        }
        return a;
    }

}
