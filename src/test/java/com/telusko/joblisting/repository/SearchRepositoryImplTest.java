package com.telusko.joblisting.repository;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.telusko.joblisting.model.Post;
import org.bson.Document;
import org.junit.jupiter.api;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.convert.MongoConverter;
import java.util.Arrays;
import org.junit.jupiter.api.Assertions;
import org.mockito.Mockito.when;
import org.springframework.stereotype.Component;
import java.util.ArrayList;
import java.util.List;

public class SearchRepositoryImplTest {

	@BeforeEach
	public void setup() {
		MockitoAnnotations.initMocks(this);
	}

	@Test
	@Tag("valid")
	public void findByTextReturnsCorrectPosts() {
		String text = "Java";
		when(client.getDatabase("telusko")).thenReturn(mongoDatabase);
		when(mongoDatabase.getCollection("JobPost")).thenReturn(mongoCollection);
		when(mongoCollection
			.aggregate(Arrays.asList(
					new Document("$search",
							new Document("text",
									new Document("query", text).append("path",
											Arrays.asList("techs", "desc", "profile")))),
					new Document("$sort", new Document("exp", 1L)), new Document("$limit", 5L))))
			.thenReturn(aggregateIterable);
		assertNotNull(searchRepository.findByText(text));
	}

	@Test
	@Tag("valid")
	public void findByTextReturnsAllPostsWithEmptyText() {
		String text = "";
		when(client.getDatabase("telusko")).thenReturn(mongoDatabase);
		when(mongoDatabase.getCollection("JobPost")).thenReturn(mongoCollection);
		when(mongoCollection
			.aggregate(Arrays.asList(
					new Document("$search",
							new Document("text",
									new Document("query", text).append("path",
											Arrays.asList("techs", "desc", "profile")))),
					new Document("$sort", new Document("exp", 1L)), new Document("$limit", 5L))))
			.thenReturn(aggregateIterable);
		assertNotNull(searchRepository.findByText(text));
	}

	@Test
	@Tag("valid")
	public void findByTextReturnsNoPostsWithNonExistentText() {
		String text = "non-existent text";
		when(client.getDatabase("telusko")).thenReturn(mongoDatabase);
		when(mongoDatabase.getCollection("JobPost")).thenReturn(mongoCollection);
		when(mongoCollection
			.aggregate(Arrays.asList(
					new Document("$search",
							new Document("text",
									new Document("query", text).append("path",
											Arrays.asList("techs", "desc", "profile")))),
					new Document("$sort", new Document("exp", 1L)), new Document("$limit", 5L))))
			.thenReturn(aggregateIterable);
		assertTrue(searchRepository.findByText(text).isEmpty());
	}

	@Test
	@Tag("invalid")
	public void findByTextThrowsExceptionWithNullText() {
		String text = null;
		assertThrows(NullPointerException.class, () -> searchRepository.findByText(text));
	}

}