package com.telusko.joblisting.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class Post_toString_ceffa8036e_Test {

    @Test
    public void testToString() {
        Post post = new Post();
        post.setProfile("Java Developer");
        post.setDesc("Java Developer with 5 years of experience");
        post.setExp(5);
        post.setTechs(new String[]{"Java", "Spring Boot", "Microservices"});

        String expected = "Post{profile='Java Developer', desc='Java Developer with 5 years of experience', exp=5, techs=[Java, Spring Boot, Microservices]}";
        Assertions.assertEquals(expected, post.toString());
    }

    @Test
    public void testToStringWithNoTechs() {
        Post post = new Post();
        post.setProfile("Java Developer");
        post.setDesc("Java Developer with 5 years of experience");
        post.setExp(5);
        post.setTechs(new String[]{});

        String expected = "Post{profile='Java Developer', desc='Java Developer with 5 years of experience', exp=5, techs=[]}";
        Assertions.assertEquals(expected, post.toString());
    }
}
