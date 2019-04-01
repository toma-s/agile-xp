package sample_black_box;

public class HelloWord {
    int test(int a) {
        if (BlackBoxController.BUG_1) {
            if (a == 1) {
                return -1;
            }
        }
        return a;
    }
}
