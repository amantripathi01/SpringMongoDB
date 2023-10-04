package com.telusko.joblisting.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

@SpringBootTest
public class Post_getDesc_66e632b9da_Test {

    @MockBean
    private Post post;

    // Assuming that PostService class is present in the same package
    @Autowired
    private PostService postService;

    @BeforeEach
    public void setup() {
        when(post.getDesc()).thenReturn("Test Desc");
    }

    @Test
    public void testGetDescSuccess() {
        // Assuming that getDesc method is present in PostService class
        String desc = postService.getDesc();
        assertEquals("Test Desc", desc);
    }

    @Test
    public void testGetDescFailure() {
        when(post.getDesc()).thenReturn(null);
        // Assuming that getDesc method is present in PostService class
        String desc = postService.getDesc();
        assertEquals(null, desc);
    }
}
