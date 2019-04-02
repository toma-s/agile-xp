package sample_black_box;

import org.junit.Test;

import static org.junit.Assert.*;

public class HelloWorldTest {

    private HelloWorld helloWord = new HelloWorld();

    @Test
    public void test2() {
        HelloWorld hw = helloWord;
        int result = hw.test(2);
        assertEquals(2, result);
    }

    @Test
    public void test1() {
        HelloWorld hw = helloWord;
        int result = hw.test(1);
        assertEquals(1, result);
    }
}
