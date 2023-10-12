// Test generated by RoostGPT for test springMongoDB using AI Type Open AI and AI Model gpt-4

package com.telusko.joblisting.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

@SpringBootTest
public class Post_getExp_e90c52dc7e_Test {

    @MockBean
    private Post post;
    
    @BeforeEach
    public void setUp() {
        post = new Post();
    }

    @Test
    public void testGetExpWhenExpIsPositive() {
        int expectedExp = 5;
        post.setExp(expectedExp);
        int actualExp = post.getExp();
        Assertions.assertEquals(expectedExp, actualExp, "The expected and actual experience do not match when experience is positive");
    }

    @Test
    public void testGetExpWhenExpIsZero() {
        int expectedExp = 0;
        post.setExp(expectedExp);
        int actualExp = post.getExp();
        Assertions.assertEquals(expectedExp, actualExp, "The expected and actual experience do not match when experience is zero");
    }
}
