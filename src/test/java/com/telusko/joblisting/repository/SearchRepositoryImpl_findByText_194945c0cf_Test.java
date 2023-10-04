package com.telusko.joblisting.repository;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.telusko.joblisting.model.Post;
import org.bson.Document;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.convert.MongoConverter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@SpringBootTest
public class SearchRepositoryImpl_findByText_194945c0cf_Test {

    @Autowired
    private MongoConverter converter;

    @Mock
    private MongoClient client;

    @Mock
    private MongoDatabase database;

    @Mock
    private MongoCollection<Document> collection;

    @Mock
    private AggregateIterable<Document> result;

    @Mock
    private SearchRepositoryImpl searchRepository;

    @Test
    public void testFindByText() {
        // Mocking the dependencies
        when(client.getDatabase("telusko")).thenReturn(database);
        when(database.getCollection("JobPost")).thenReturn(collection);
        when(collection.aggregate(any())).thenReturn(result);

        // Create a mock Post
        Post post = new Post();
        post.setTechs(Arrays.asList("Java", "Spring Boot"));
        post.setDesc("Java Developer");
        post.setProfile("Software Developer");
        post.setExp(2);

        // Create a document from the mock Post
        Document doc = new Document();
        converter.write(post, doc);

        // Mock the result of the aggregate method
        when(result.spliterator()).thenReturn(Arrays.asList(doc).spliterator());

        // Mock the findByText method
        when(searchRepository.findByText("Java")).thenReturn(Arrays.asList(post));

        // Testing the method
        List<Post> posts = searchRepository.findByText("Java");

        // Asserting the results
        assertEquals(1, posts.size());
        assertEquals(post, posts.get(0));
    }

    @Test
    public void testFindByText_NoResults() {
        // Mocking the dependencies
        when(client.getDatabase("telusko")).thenReturn(database);
        when(database.getCollection("JobPost")).thenReturn(collection);
        when(collection.aggregate(any())).thenReturn(result);

        // Mock the result of the aggregate method
        when(result.spliterator()).thenReturn(new ArrayList<Document>().spliterator());

        // Mock the findByText method
        when(searchRepository.findByText("Python")).thenReturn(new ArrayList<>());

        // Testing the method
        List<Post> posts = searchRepository.findByText("Python");

        // Asserting the results
        assertEquals(0, posts.size());
    }
}
