package com.telusko.joblisting.model;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.junit.jupiter.api.Assertions;
import org.mockito.Mockito;

@SpringBootTest
public class Post_getProfile_ce58a7beef_Test {

    @Test
    public void testGetProfileSuccess() {
        String expectedProfile = "Software Developer";
        Post mockPost = Mockito.mock(Post.class);
        Mockito.when(mockPost.getProfile()).thenReturn(expectedProfile);
        String actualProfile = mockPost.getProfile();
        Assertions.assertEquals(expectedProfile, actualProfile);
    }

    @Test
    public void testGetProfileFailure() {
        String unexpectedProfile = "Data Analyst";
        Post mockPost = Mockito.mock(Post.class);
        Mockito.when(mockPost.getProfile()).thenReturn("Software Developer");
        String actualProfile = mockPost.getProfile();
        Assertions.assertNotEquals(unexpectedProfile, actualProfile);
    }
}
