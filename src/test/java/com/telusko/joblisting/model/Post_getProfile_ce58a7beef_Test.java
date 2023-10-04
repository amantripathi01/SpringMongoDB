package com.telusko.joblisting.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class Post_getProfile_ce58a7beef_Test {

    @Test
    public void testGetProfileSuccess() {
        Post post = new Post();
        post.setProfile("Software Developer");
        String expectedProfile = "Software Developer";
        assertEquals(expectedProfile, post.getProfile());
    }

    @Test
    public void testGetProfileFailure() {
        Post post = new Post();
        post.setProfile("Data Analyst");
        String notExpectedProfile = "Software Developer";
        assertNotEquals(notExpectedProfile, post.getProfile());
    }
}
