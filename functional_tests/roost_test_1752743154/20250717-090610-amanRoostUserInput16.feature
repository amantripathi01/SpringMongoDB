Feature: PDF File Upload API Testing

  Background:
    Given the API base URL is set to '<API_BASE_URL>'
    And the authorization header is set to 'Bearer <AUTH_TOKEN>'
    And the content type is 'application/json'

  Scenario: Successfully upload a 1 MB PDF file
    Given I have a PDF file named 'sample.pdf' with size 1 MB
    When I send a POST request to '/upload' with the file 'sample.pdf'
    Then the response status should be 200
    And the response should contain a message 'File uploaded successfully'
    And the response should contain the file size '1 MB'

  Scenario: Attempt to upload a file larger than 1 MB
    Given I have a PDF file named 'large_sample.pdf' with size 2 MB
    When I send a POST request to '/upload' with the file 'large_sample.pdf'
    Then the response status should be 413
    And the response should contain a message 'Payload Too Large'

  Scenario: Attempt to upload a file with an unsupported file type
    Given I have a file named 'image.png'
    When I send a POST request to '/upload' with the file 'image.png'
    Then the response status should be 415
    And the response should contain a message 'Unsupported Media Type'

  Scenario: Attempt to upload a file without authentication
    Given I have a PDF file named 'sample.pdf' with size 1 MB
    And the authorization header is not set
    When I send a POST request to '/upload' with the file 'sample.pdf'
    Then the response status should be 401
    And the response should contain a message 'Unauthorized'

  Scenario: Attempt to upload a file without specifying the file
    When I send a POST request to '/upload' without a file
    Then the response status should be 400
    And the response should contain a message 'Bad Request: No file uploaded'
