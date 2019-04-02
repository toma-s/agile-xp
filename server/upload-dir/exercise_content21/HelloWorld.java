public class HelloWorld {
    int test(int a) {
        if (BlackBoxSwitcher.BUG_1) {
            if (a == 1) {
                return -1;
            }
        }
        return a;
    }
}
