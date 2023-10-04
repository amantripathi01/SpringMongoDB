package com.telusko.joblisting.model;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals; // Add this line

@RunWith(SpringRunner.class)
@SpringBootTest
public class Post_getExp_e90c52dc7e_Test {

    @Test
    public void testGetExpSuccess() {
        Post post = new Post();
        post.setExp(5);
        int expected = 5;
        int actual = post.getExp();
        assertEquals(expected, actual);
    }

    @Test
    public void testGetExpFailure() {
        Post post = new Post();
        post.setExp(5);
        int unexpected = 6;
        int actual = post.getExp();
        assertNotEquals(unexpected, actual);
    }
}
