// Test generated by RoostGPT for test springMongoDB using AI Type Open AI and AI Model gpt-4

package com.telusko.joblisting.controller;

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpServletResponse;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;

public class PostController_redirect_31b271143a_Test {

    @Mock
    HttpServletResponse response;

    @InjectMocks
    PostController postController;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testRedirectSuccess() throws IOException {
        MockHttpServletResponse mockResponse = new MockHttpServletResponse();
        postController.redirect(mockResponse);
        assertEquals("/swagger-ui.html", mockResponse.getRedirectedUrl());
    }

    @Test(expected = IOException.class)
    public void testRedirectFailure() throws IOException {
        MockHttpServletResponse mockResponse = new MockHttpServletResponse();
        mockResponse.setCommitted(true);
        postController.redirect(mockResponse);
    }
}
