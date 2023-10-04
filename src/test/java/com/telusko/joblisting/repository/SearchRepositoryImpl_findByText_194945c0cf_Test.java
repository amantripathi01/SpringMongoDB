package com.telusko.joblisting.repository;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.telusko.joblisting.model.Post;
import org.bson.Document;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.convert.MongoConverter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class SearchRepositoryImpl_findByText_194945c0cf_Test {

    @Mock
    private MongoClient client;

    @Mock
    private MongoDatabase database;

    @Mock
    private MongoCollection<Document> collection;

    @Mock
    private AggregateIterable<Document> result;

    @Mock
    private MongoConverter converter;

    private SearchRepositoryImpl repository;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.initMocks(this);
        when(client.getDatabase("telusko")).thenReturn(database);
        when(database.getCollection("JobPost")).thenReturn(collection);
        when(collection.aggregate(any())).thenReturn(result);
        repository = new SearchRepositoryImpl();
    }

    @Test
    public void testFindByText() {
        Post post = new Post();
        when(converter.read(Post.class, any())).thenReturn(post);
        List<Post> expectedPosts = new ArrayList<>();
        expectedPosts.add(post);

        List<Post> actualPosts = repository.findByText("Java");
        assertEquals(expectedPosts, actualPosts);
    }

    @Test
    public void testFindByText_NoResults() {
        List<Post> expectedPosts = new ArrayList<>();
        List<Post> actualPosts = repository.findByText("NonexistentTech");
        assertEquals(expectedPosts, actualPosts);
    }
}
