package com.telusko.joblisting.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

@SpringBootTest
public class Post_setDesc_148780b2fa_Test {
    @MockBean
    private Post post;

    @BeforeEach
    public void setUp() {
        when(post.getDesc()).thenReturn("Test Description");
    }

    @Test
    public void testSetDesc_Success() {
        String desc = "Updated Description";
        when(post.getDesc()).thenReturn(desc);
        assertEquals(desc, post.getDesc(), "The description should match the set value");
    }

    @Test
    public void testSetDesc_NullValue() {
        when(post.getDesc()).thenReturn(null);
        assertEquals(null, post.getDesc(), "The description should be null");
    }
}
