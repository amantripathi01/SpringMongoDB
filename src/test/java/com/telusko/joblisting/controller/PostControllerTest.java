package com.telusko.joblisting.controller;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Tag;
import org.springframework.boot.test.mock.mockito.MockBean;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.mockito.Mockito;
import org.junit.jupiter.api;
import com.telusko.joblisting.repository.PostRepository;
import com.telusko.joblisting.model.Post;
import com.telusko.joblisting.repository.SearchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation;
import springfox.documentation.annotations.ApiIgnore;
import java.util.List;
import org.junit.jupiter.api.Assertions;
import org.mockito.Mockito.times;
import org.mockito.Mockito.verify;
import org.mockito.Mockito.when;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import java.util.Arrays;
import org.junit.jupiter.api.BeforeEach;
import java.util.ArrayList;
import org.mockito.ArgumentMatchers.anyString;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;

public class PostControllerTest {

	@Test
	@Tag("valid")
	public void testRedirectionFunctionality() throws IOException {
		PostController controller = new PostController();
		controller.redirect(response);
		verify(response, times(1)).sendRedirect("/swagger-ui.html");
	}

	@Test
	@Tag("invalid")
	public void testIOExceptionRedirectionHandling() throws IOException {
		PostController controller = new PostController();
		doThrow(new IOException()).when(response).sendRedirect("/swagger-ui.html");
		try {
			controller.redirect(response);
		}
		catch (IOException e) {
			verify(response, times(1)).sendRedirect("/swagger-ui.html");
		}
	}

	@Test
	@Tag("valid")
	public void checkGetAllPostsWhenPostsExist() {

		Post post1 = new Post();
		Post post2 = new Post();
		List<Post> expectedPostsList = Arrays.asList(post1, post2);
		when(repo.findAll()).thenReturn(expectedPostsList);

		List<Post> actualPostsList = controller.getAllPosts();

		assertEquals(expectedPostsList, actualPostsList, "The returned posts list is not as expected");
		verify(repo, times(1)).findAll();
	}

@Test
@Tag("boundary")
public void checkGetAllPostsWhenRepoEmpty() {

    when(repo.findAll()).thenReturn(List.of());

    List<Post> actualPostsList = controller.getAllPosts();

    assertTrue(actualPostsList.isEmpty(), "The returned posts list is not empty as expected");
    verify(repo, times(1)).findAll();
}

@Test
@Tag("invalid")
public void checkGetAllPostsWhenRepoReturnsNull() {

    when(repo.findAll()).thenReturn(null);

    List<Post> actualPostsList = controller.getAllPosts();

    assertNull(actualPostsList, "The returned posts list is not null as expected");
    verify(repo, times(1)).findAll();
}

	@BeforeEach
	public void setUp() {
		post = new Post();
		expectedPostList = new ArrayList<>();
		expectedPostList.add(post);
		postController = new PostController();
		postController.srepo = srepo;
	}

@Test
@Tag("valid")
public void searchReturnsCorrectPostListOnValidInput() {

    when(srepo.findByText(anyString())).thenReturn(expectedPostList);

    List<Post> actualResult = postController.search("test");

    assertEquals(expectedPostList, actualResult);
}

@Test
@Tag("boundary")
public void searchReturnsEmptyPostListOnEmptyInput() {

    when(srepo.findByText("")).thenReturn(new ArrayList<>());

    List<Post> actualResult = postController.search("");

    assertTrue(actualResult.isEmpty());
}

	@Test
	@Tag("invalid")
	public void searchThrowsExceptionOnNullInput() {

		assertThrows(IllegalArgumentException.class, () -> {
			postController.search(null);
		});
	}

	@BeforeEach
	public void setup() {
		post = new Post();
		post.setProfile("This is a sample post");
	}

@Test
@Tag("valid")
public void testSuccessfulPostCreation() {
    when(postRepository.save(any(Post.class))).thenReturn(post);
    Post result = postController.addPost(post);
    verify(postRepository, times(1)).save(any(Post.class));
    assertEquals(post.getProfile(), result.getProfile(), "Expected text did not match");
}

	@Test
	@Tag("invalid")
	public void testAddPostWithNull() {
		assertThrows(NullPointerException.class, () -> postController.addPost(null),
				"Expected NullPointerException to be thrown");
	}

@Test
@Tag("boundary")
public void testAddPostWithExistingPost() {
    when(postRepository.save(any(Post.class))).thenThrow(new DataIntegrityViolationException(""));
    assertThrows(DataIntegrityViolationException.class, () -> postController.addPost(post));
}

}