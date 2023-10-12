// Test generated by RoostGPT for test springMongoDB using AI Type Open AI and AI Model gpt-4

package com.telusko.joblisting.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class Post_getDesc_66e632b9da_Test {

    @Test
    public void testGetDesc_Success() {
        Post post = new Post();
        post.setDesc("Java Developer");
        assertEquals("Java Developer", post.getDesc());
    }

    @Test
    public void testGetDesc_Null() {
        Post post = new Post();
        post.setDesc(null);
        assertEquals(null, post.getDesc());
    }
}
