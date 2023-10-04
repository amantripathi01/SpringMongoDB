package com.telusko.joblisting.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class Post_getExp_e90c52dc7e_Test {
    
    private Post post;

    @BeforeEach
    public void setup() {
        post = new Post();
    }

    @Test
    public void testGetExp_Scenario_PositiveNumber() {
        // TODO: Change the value as needed
        int expectedExp = 5;
        post.setExp(expectedExp);
        Assertions.assertEquals(expectedExp, post.getExp());
    }

    @Test
    public void testGetExp_Scenario_Zero() {
        // TODO: Change the value as needed
        int expectedExp = 0;
        post.setExp(expectedExp);
        Assertions.assertEquals(expectedExp, post.getExp());
    }

    @Test
    public void testGetExp_Scenario_NegativeNumber() {
        // TODO: Change the value as needed
        int expectedExp = -3;
        post.setExp(expectedExp);
        Assertions.assertEquals(expectedExp, post.getExp());
    }
}
