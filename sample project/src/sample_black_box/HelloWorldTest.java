package sample_black_box;

import org.junit.Test;
import static org.junit.Assert.*;

public class HelloWorldTest {

    private HelloWorld helloWord = new HelloWorld();

    @Test
    public void test1FindsBug() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(1);
        assertEquals(1, result);
    }

    @Test
    public void test1FindsBugDuplicate() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(1);
        assertEquals(1, result);
    }

    @Test
    public void test2FindsBug() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(2);
        assertEquals(2, result);
    }

    @Test
    public void test3Ok() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(3);
        assertEquals(3, result);
    }

    @Test
    public void test3FakeBug() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(3);
        assertEquals(-3, result);
    }

    @Test
    public void test3FakeBugDuplicate() {
        HelloWorld hw = helloWord;
        int result = hw.returnTheSame(3);
        assertEquals(-3, result);
    }

}