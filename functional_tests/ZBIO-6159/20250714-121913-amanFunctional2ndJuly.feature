Feature: Integration Testing and API Validation for PostController

Background:
  Given the API base URL 'http://localhost:8080'
  And the authorization header is set
  And the content type is 'application/json'

Scenario: Redirect to Swagger UI
  Given a valid API endpoint '/'
  When I send a GET request to '/'
  Then the response status should be 302
  And the response header should include 'Location: /swagger-ui.html'

Scenario: Retrieve the list of posts
  Given a valid API endpoint '/allPosts'
  When I send a GET request to '/allPosts'
  Then the response status should be 200
  And the response body should contain a list of posts

Scenario: Search posts by matching text
  Given a valid text parameter 'Java'
  Given a valid API endpoint '/posts/Java'
  When I send a GET request to '/posts/Java'
  Then the response status should be 200
  And the response body should contain posts where text includes 'Java'

Scenario: Add a new post with valid data
  Given a valid API endpoint '/post'
  And the request payload:
    """
    {
      "title": "Learn Spring",
      "text": "Spring Framework Tutorial",
      "author": "John Doe"
    }
    """
  When I send a POST request to '/post'
  Then the response status should be 201
  And the response body should contain the added post details
  And the 'Location' header should include the URI of the newly created post

Scenario: Fail to add a post with invalid data
  Given a valid API endpoint '/post'
  And an invalid request payload:
    """
    {
      "title": "",
      "text": "",
      "author": ""
    }
    """
  When I send a POST request to '/post'
  Then the response status should be 400
  And the response body should include validation error details

Scenario: Search posts with non-existent text
  Given a valid API endpoint '/posts/Nonexistent'
  Given the text parameter 'Nonexistent'
  When I send a GET request to '/posts/Nonexistent'
  Then the response status should be 200
  And the response body should contain an empty list

Scenario: Validate Cross-origin Access for GET requests
  Given a valid API endpoint '/allPosts'
  And an Origin header 'http://example.com'
  When I send a GET request to '/allPosts'
  Then the response status should be 200
  And the response should allow cross-origin requests

Scenario: Validate Cross-origin Access for POST requests
  Given a valid API endpoint '/post'
  And the request payload:
    """
    {
      "title": "Learn MongoDB",
      "text": "MongoDB Basics Tutorial",
      "author": "Jane Smith"
    }
    """
  And an Origin header 'http://example.com'
  When I send a POST request to '/post'
  Then the response status should be 201
  And the response should allow cross-origin requests

Scenario: Search posts with partial text match
  Given a valid text parameter 'Spr'
  Given a valid API endpoint '/posts/Spr'
  When I send a GET request to '/posts/Spr'
  Then the response status should be 200
  And the response body should contain posts where text includes 'Spr'

Scenario: Search posts containing special characters
  Given a text parameter 'Spring#123'
  And a valid API endpoint '/posts/Spring%23123'
  When I send a GET request to '/posts/Spring%23123'
  Then the response status should be 200
  And the response body should contain an empty list

Scenario: Handle unsupported HTTP method for posting
  Given a valid API endpoint '/post'
  When I send a DELETE request to '/post'
  Then the response status should be 405
  And the response body should include error details for unsupported method
  And the Allow header should specify supported methods

Scenario: Validate HTTP method for updating (PUT)
  Given a valid API endpoint '/post'
  And the request payload:
    """
    {
      "title": "Updated Title",
      "text": "Updated Text",
      "author": "Updated Author"
    }
    """
  When I send a PUT request to '/post'
  Then the response status should be 200
  And the response body should contain updated post details
  And the response body should indicate successful modification
