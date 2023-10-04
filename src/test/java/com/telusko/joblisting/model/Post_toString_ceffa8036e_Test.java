package com.telusko.joblisting.model;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import java.util.Arrays;

public class Post_toString_ceffa8036e_Test {

    private Post post;

    @BeforeEach
    public void setup() {
        post = Mockito.mock(Post.class);
        Mockito.when(post.toString()).thenCallRealMethod();
        Mockito.when(post.getProfile()).thenReturn("Java Developer");
        Mockito.when(post.getDesc()).thenReturn("Java Developer with 5 years experience");
        Mockito.when(post.getExp()).thenReturn(5);
        Mockito.when(post.getTechs()).thenReturn(new String[]{"Java", "Spring Boot", "Microservices"});
    }

    @Test
    public void testToString() {
        String expected = "Post{" +
                "profile='Java Developer'" +
                ", desc='Java Developer with 5 years experience'" +
                ", exp=5" +
                ", techs=" + Arrays.toString(new String[]{"Java", "Spring Boot", "Microservices"}) +
                '}';
        Assertions.assertEquals(expected, post.toString());
    }

    @Test
    public void testToStringWithNullValues() {
        Mockito.when(post.getProfile()).thenReturn(null);
        Mockito.when(post.getDesc()).thenReturn(null);
        Mockito.when(post.getExp()).thenReturn(null);
        Mockito.when(post.getTechs()).thenReturn(null);

        String expected = "Post{" +
                "profile='null'" +
                ", desc='null'" +
                ", exp=null" +
                ", techs=null" +
                '}';
        Assertions.assertEquals(expected, post.toString());
    }
}
