Feature: API Testing for File Upload and Parsing Functionalities

Background:
  Given the API base URL 'http://localhost:3000'
  And the authorization header is set with valid credentials
  And the content type is 'application/json'

Scenario: Upload Jira Ticket as PDF
  Given I am an authorized user
  And I have a valid PDF file containing a Jira ticket
  When I send a POST request to '/upload-jira-ticket' with the file
  Then the response status should be 200
  And the response body should confirm that the file path and prompt type are processed correctly

Scenario: PDF Parsing of Jira Ticket
  Given I have already uploaded a valid Jira ticket PDF file
  When I send a GET request to '/parse-jira-ticket' with the file ID
  Then the response status should be 200
  And the response body should contain extracted details including 'title', 'description', and 'comments'

Scenario: Error Handling for Unsupported File Formats
  Given I am an authorized user
  And I have an unsupported file format (.docx) for upload
  When I send a POST request to '/upload-jira-ticket' with the file
  Then the response status should be 400
  And the response body should include an error message: 'Unsupported file format. Please upload a PDF.'

Scenario: Verify Data Flow Across System Components
  Given I have uploaded a valid Jira ticket PDF file
  When I inspect logs across system components ('Approostio', 'Roost-reg', and 'AI-server')
  Then all components should process and transfer the file's path and metadata without errors
  And the AI server should contain parsed entries including 'title', 'description', and 'comments'

Scenario: Performance of PDF Parsing
  Given I have a set of sample PDFs of varying sizes (small, medium, large)
  When I upload each file to '/upload-jira-ticket' and measure the parsing time
  Then the parsing time should remain within acceptable benchmarks for each size category

Scenario: System Scalability with High File Volumes
  Given I have 50 valid sample PDFs prepared for upload
  When I simulate concurrent POST requests to '/upload-jira-ticket'
  Then the system should handle all requests successfully
  And the system resources such as CPU and memory usage should remain within stable limits

Scenario: Validation of File Path Storage in Roost-reg
  Given I have uploaded a valid Jira ticket PDF file
  When I query the storage of Roost-reg for the file path and metadata
  Then the stored file path, file name, and prompt type should match the uploaded file details

Scenario: Error Recovery from Interrupted Uploads
  Given I have started uploading a valid Jira ticket PDF file
  When the network connection is interrupted midway
  Then the system should either resume the upload or return an error message: 'Upload interrupted. Please retry.'

Feature: Integration and Cross-Origin Testing of PostController APIs

Background:
  Given the API base URL 'http://localhost:8080'
  And the authorization header is set with valid credentials
  And the content type is 'application/json'

Scenario: Redirect to Swagger UI
  Given I am an authorized user
  When I send a GET request to '/'
  Then the response status should be 302
  And the 'Location' header should be '/swagger-ui.html'

Scenario: Get all posts
  Given I am an authorized user
  When I send a GET request to '/allPosts'
  Then the response status should be 200
  And the response body should contain a list of posts

Scenario: Search posts by text
  Given I am an authorized user
  And a search term 'Java' is available
  When I send a GET request to '/posts/Java'
  Then the response status should be 200
  And the response body should contain posts related to 'Java'

Scenario: Add a new post successfully
  Given I am an authorized user
  And a new post payload is prepared
      """
      {
        "title": "Spring Boot Basics",
        "description": "Introduction to Spring Boot framework."
      }
      """
  When I send a POST request to '/post' with the payload
  Then the response status should be 201
  And the response body should contain the added post details

Scenario: Add a new post with invalid data
  Given I am an authorized user
  And an invalid post payload is prepared
      """
      {
        "title": "",
        "description": ""
      }
      """
  When I send a POST request to '/post' with the payload
  Then the response status should be 400
  And the response body should contain an error message explaining why the data is invalid

Scenario: Search posts with a term not found
  Given I am an authorized user
  And I have a search term 'Unknown' that does not exist
  When I send a GET request to '/posts/Unknown'
  Then the response status should be 200
  And the response body should be an empty list
  And the system should not throw any exceptions during the API call

Scenario: Verify Cross-Origin for POST request
  Given I am an authorized user from a different origin
  And a new post payload is prepared
      """
      {
        "title": "React with Spring Boot",
        "description": "Building applications using React and Spring Boot."
      }
      """
  When I send a POST request to '/post' with the payload
  Then the response status should be 201
  And the response body should contain the added post details

Scenario: Verify Cross-Origin for GET all posts request
  Given I am an authorized user from a different origin
  When I send a GET request to '/allPosts'
  Then the response status should be 200
  And the response body should contain a list of posts

Scenario: Test Caching of GET Request for Search API
  Given I am an authorized user
  And there has been a previous successful search with the term 'Java'
  When I send another GET request to '/posts/Java'
  Then the response status should be 200
  And the caching mechanism should prevent redundant database queries
