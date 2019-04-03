package sample_black_box;

import org.junit.Test;

import static org.junit.Assert.*;

public class HelloWorldTest {

    private HelloWorld helloWorld = new HelloWorld();

    @Test
    public void test1() {
        HelloWorld hw = helloWorld;
        int result = hw.test(1);
        assertEquals(1, result);
    }

    @Test
    public void test11() {
        HelloWorld hw = helloWorld;
        int result = hw.test(1);
        assertEquals(1, result);
    }


    @Test
    public void test2() {
        HelloWorld hw = helloWorld;
        int result = hw.test(2);
        assertEquals(2, result);
    }

    @Test
    public void test3() {
        HelloWorld hw = helloWorld;
        int result = hw.test(3);
        assertEquals(3, result);
    }

}
