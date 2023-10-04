package com.telusko.joblisting.model;

import org.springframework.data.mongodb.core.mapping.Document;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertArrayEquals;

@Document
public class Post_setTechs_1b061b0fa7_Test {

    @Test
    public void testSetTechs_ValidInput() {
        String[] techs = {"Java", "Spring", "Hibernate"};
        Post post = new Post();
        post.setTechs(techs);
        assertArrayEquals(techs, post.getTechs());
    }

    @Test
    public void testSetTechs_EmptyArray() {
        String[] techs = {};
        Post post = new Post();
        post.setTechs(techs);
        assertArrayEquals(techs, post.getTechs());
    }

    @Test
    public void testSetTechs_NullInput() {
        Post post = new Post();
        post.setTechs(null);
        assertArrayEquals(null, post.getTechs());
    }
}
