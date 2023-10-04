package com.telusko.joblisting.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.mock.web.MockHttpServletResponse;

import java.io.IOException;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.doThrow;

@RunWith(MockitoJUnitRunner.class)
public class PostController_redirect_31b271143a_Test {

    @InjectMocks
    private PostController postController;

    @Mock
    private MockHttpServletResponse response;

    @Test
    public void testRedirectSuccess() throws IOException {
        String expectedUrl = "/swagger-ui.html";
        postController.redirect(response);
        assertEquals(expectedUrl, response.getRedirectedUrl());
    }

    @Test(expected = IOException.class)
    public void testRedirectFailure() throws IOException {
        doThrow(new IOException("Mock IOException")).when(response).sendRedirect(anyString());
        postController.redirect(response);
    }
}
