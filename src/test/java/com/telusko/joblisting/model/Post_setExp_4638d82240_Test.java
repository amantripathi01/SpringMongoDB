package com.telusko.joblisting.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class Post_setExp_4638d82240_Test {

    @Autowired
    private Post post;

    @BeforeEach
    public void setup() {
        // TODO: Add setup code if needed
    }

    @Test
    public void testSetExpPositive() {
        post.setExp(5);
        Assertions.assertEquals(5, post.getExp(), "Experience should be set correctly for positive values");
    }

    @Test
    public void testSetExpZero() {
        post.setExp(0);
        Assertions.assertEquals(0, post.getExp(), "Experience should be set correctly for zero value");
    }

    @Test
    public void testSetExpNegative() {
        Assertions.assertThrows(IllegalArgumentException.class, () -> post.setExp(-1), "Negative experience should throw exception");
    }

    @Test
    public void testSetExpMaxInteger() {
        post.setExp(Integer.MAX_VALUE);
        Assertions.assertEquals(Integer.MAX_VALUE, post.getExp(), "Experience should be set correctly for max integer value");
    }
}
