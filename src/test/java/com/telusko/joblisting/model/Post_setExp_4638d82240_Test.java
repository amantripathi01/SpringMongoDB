// Test generated by RoostGPT for test JavaUnitTest using AI Type Open AI and AI Model gpt-4

package com.telusko.joblisting.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class Post_setExp_4638d82240_Test {
    @Test
    public void testSetExpPositive() {
        Post post = new Post();
        post.setExp(5);
        assertEquals(5, post.getExp());
    }

    @Test
    public void testSetExpZero() {
        Post post = new Post();
        post.setExp(0);
        assertEquals(0, post.getExp());
    }

    @Test
    public void testSetExpNegative() {
        Post post = new Post();
        post.setExp(-3);
        assertEquals(-3, post.getExp());
    }
}
