package com.telusko.joblisting.model;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.junit.runner.RunWith;

@RunWith(SpringRunner.class)
@SpringBootTest
public class Post_setProfile_50f29a11fe_Test {

    private Post post;

    @Before
    public void setup() {
        post = new Post();
    }

    @Test
    public void testSetProfile_successCase() {
        String expectedProfile = "Software Engineer";
        post.setProfile(expectedProfile);
        Assert.assertEquals(expectedProfile, post.getProfile());
    }
    
    @Test
    public void testSetProfile_nullCase() {
        String expectedProfile = null;
        post.setProfile(expectedProfile);
        Assert.assertEquals(expectedProfile, post.getProfile());
    }

    @Test
    public void testSetProfile_emptyCase() {
        String expectedProfile = "";
        post.setProfile(expectedProfile);
        Assert.assertEquals(expectedProfile, post.getProfile());
    }
}
