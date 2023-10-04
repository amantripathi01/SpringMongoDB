package com.telusko.joblisting.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class Post_getDesc_66e632b9da_Test {

    private Post post;

    @BeforeEach
    public void setUp() {
        post = new Post();
    }

    @Test
    public void testGetDesc_WhenDescIsNotNull() {
        // TODO: Replace "testDesc" with the actual description you want to test
        String expectedDesc = "testDesc";
        post.setDesc(expectedDesc);
        String actualDesc = post.getDesc();
        assertEquals(expectedDesc, actualDesc, "The expected description did not match the actual description");
    }

    @Test
    public void testGetDesc_WhenDescIsNull() {
        String expectedDesc = null;
        post.setDesc(expectedDesc);
        String actualDesc = post.getDesc();
        assertEquals(expectedDesc, actualDesc, "The expected description did not match the actual description");
    }
}
