

package com.telusko.joblisting.repository;
import com.mongodb.MongoException;
import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.telusko.joblisting.model.Post;
import org.bson.Document;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.mongodb.core.convert.MongoConverter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@ExtendWith(MockitoExtension.class)
class SearchRepositoryImplFindByTextTest {
    @Mock
    private MongoClient client;
    @Mock
    private MongoConverter converter;
    @Mock
    private MongoDatabase database;
    @Mock
    private MongoCollection<Document> collection;
    @Mock
    private AggregateIterable<Document> aggregateIterable;
    @InjectMocks
    private SearchRepositoryImpl searchRepository;
    @BeforeEach
    void setUp() {
        when(client.getDatabase("telusko")).thenReturn(database);
        when(database.getCollection("JobPost")).thenReturn(collection);
    }
    @Test
    @Tag("valid")
    void findPostsByValidSearchText() {
        // Arrange
        Document testDoc = new Document();
        Post testPost = new Post();
        when(collection.aggregate(any())).thenReturn(aggregateIterable);
        when(aggregateIterable.iterator()).thenReturn(Arrays.asList(testDoc).iterator());
        when(converter.read(eq(Post.class), any(Document.class))).thenReturn(testPost);
        // Act
        List<Post> result = searchRepository.findByText("java developer");
        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        verify(collection).aggregate(any());
    }
    @Test
    @Tag("valid")
    void findPostsWithNonMatchingText() {
        // Arrange
        when(collection.aggregate(any())).thenReturn(aggregateIterable);
        when(aggregateIterable.iterator()).thenReturn(new ArrayList<Document>().iterator());
        // Act
        List<Post> result = searchRepository.findByText("nonexistentskill123");
        // Assert
        assertTrue(result.isEmpty());
    }
    @Test
    @Tag("boundary")
    void findPostsWithEmptySearchText() {
        // Arrange
        when(collection.aggregate(any())).thenReturn(aggregateIterable);
        when(aggregateIterable.iterator()).thenReturn(new ArrayList<Document>().iterator());
        // Act
        List<Post> result = searchRepository.findByText("");
        // Assert
        assertNotNull(result);
        assertTrue(result.isEmpty());
    }
    @Test
    @Tag("invalid")
    void handleDatabaseConnectionFailure() {
        // Arrange
        when(collection.aggregate(any())).thenThrow(new MongoException("Connection failed"));
        // Act & Assert
        assertThrows(MongoException.class, () -> searchRepository.findByText("java"));
    }
    @Test
    @Tag("boundary")
    void enforceMaximumResultLimit() {
        // Arrange
        List<Document> docs = Arrays.asList(
            new Document(), new Document(), new Document(),
            new Document(), new Document(), new Document()
        );
        when(collection.aggregate(any())).thenReturn(aggregateIterable);
        when(aggregateIterable.iterator()).thenReturn(docs.iterator());
        when(converter.read(eq(Post.class), any(Document.class))).thenReturn(new Post());
        // Act
        List<Post> result = searchRepository.findByText("common skill");
        // Assert
        assertNotNull(result);
        assertTrue(result.size() <= 5);
    }
    @Test
    @Tag("invalid")
    void handleDocumentConversionFailure() {
        // Arrange
        Document testDoc = new Document();
        when(collection.aggregate(any())).thenReturn(aggregateIterable);
        when(aggregateIterable.iterator()).thenReturn(Arrays.asList(testDoc).iterator());
        when(converter.read(eq(Post.class), any(Document.class)))
            .thenThrow(new IllegalArgumentException("Conversion failed"));
        // Act & Assert
        assertThrows(IllegalArgumentException.class, () -> searchRepository.findByText("test"));
    }
}