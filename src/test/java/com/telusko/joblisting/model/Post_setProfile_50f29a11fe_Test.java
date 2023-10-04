package com.telusko.joblisting.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
public class Post_setProfile_50f29a11fe_Test {

    private Post post;

    @BeforeEach
    public void setUp() {
        post = new Post();
    }

    @Test
    public void testSetProfile_Success() {
        String expectedProfile = "Software Developer";
        post.setProfile(expectedProfile);
        assertEquals(expectedProfile, post.getProfile());
    }

    @Test
    public void testSetProfile_EmptyString() {
        String expectedProfile = "";
        post.setProfile(expectedProfile);
        assertEquals(expectedProfile, post.getProfile());
    }

    @Test
    public void testSetProfile_Null() {
        String expectedProfile = null;
        post.setProfile(expectedProfile);
        assertEquals(expectedProfile, post.getProfile());
    }
}
