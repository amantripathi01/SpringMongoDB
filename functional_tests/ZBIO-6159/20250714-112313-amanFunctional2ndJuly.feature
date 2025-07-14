Feature: Roostgpt enhancement for uploading Jira tickets as PDF

Background:
  Given the API base URL '<API_BASE_URL>'
  And the authorization header is set using '<AUTH_TOKEN>'
  And the content type is 'application/json'

Scenario: Uploading a PDF file for Functional Testing
  Given I have a valid PDF file named "jira.pdf"
  When I send a POST request to '/upload-document' with the file attached
  Then the response status should be 200
  And the response body should contain "File uploaded successfully"
  And the file should be stored for processing

Scenario: Uploading a non-PDF file
  Given I have a non-PDF file named "jira.txt"
  When I send a POST request to '/upload-document' with the file attached
  Then the response status should be 400
  And the response body should contain "Invalid file type"

Scenario: Uploading a large PDF file
  Given I have a PDF file larger than 10 MB named "large-jira.pdf"
  When I send a POST request to '/upload-document' with the file attached
  Then the response status should be 413
  And the response body should contain "File size exceeds allowed limit"

Scenario: Uploading an empty PDF file
  Given I have a valid file named "empty-jira.pdf" with no content
  When I send a POST request to '/upload-document' with the file attached
  Then the response status should be 422
  And the response body should contain "Empty files cannot be processed"

Scenario: Sending file details from "approostio"
  Given I have file details as "{ fileName: 'jira.pdf', content: binaryFileData, promptType: 'jira-upload' }"
  When I send a POST request to '/send-file-details' with the JSON payload
  Then the response status should be 200
  And the file details should be correctly passed to "roost-reg"

Scenario: Missing required fields in file details
  Given I have file details without "fileName" field
  When I send a POST request to '/send-file-details' with the JSON payload
  Then the response status should be 400
  And the response body should contain "Missing required fields"

Scenario: Storing file path in "roost-reg"
  Given I have file details "{ fileName: 'jira.pdf', promptType: 'jira-upload' }"
  When I send a POST request to '/store-file-path' with the JSON payload
  Then the response status should be 200
  And the file path should be stored in "files/uploads/jira.pdf"

Scenario: File path duplication resolution
  Given I have a file with the same name "jira.pdf" already stored
  When I send a POST request to '/store-file-path' with the JSON payload
  Then the response status should be 200
  And the file name should be stored as "jira_1.pdf"

Scenario: Sending file path to AI Server
  Given I have file paths as "{ filePaths: ['/files/uploads/jira.pdf'], promptType: 'jira-upload' }"
  When I send a POST request to '/transmit-to-ai' with the JSON payload
  Then the response status should be 200
  And the AI Server should retrieve file contents successfully

Scenario: Incorrect file path format
  Given I have an incorrect file path "/unknown/files/jira.pdf"
  When I send a POST request to '/transmit-to-ai' with the JSON payload
  Then the response status should be 404
  And the response body should contain "File Not Found"

Scenario: Parsing PDF content using regex
  Given I have a PDF file named "jira.pdf" containing structured data
  When I send a POST request to '/parse-pdf' with the JSON payload
  Then the response status should be 200
  And the extracted data should include "Title", "Description", and "Comments"

Scenario: Parsing invalid PDF content
  Given I have a PDF file named "invalid-jira.pdf" with no structured content
  When I send a POST request to '/parse-pdf' with the JSON payload
  Then the response status should be 422
  And the response body should contain a log for debugging regex errors

Scenario: Receiving response from AI Server after processing
  Given the AI Server returns a response "{ status: 'success', extractedData: { title: 'ZBIO-6159', description: '...', comments: '...' } }"
  When the system receives the response
  Then the extracted data should be displayed correctly in the Functional Testing UI

Scenario: Parsing failure by AI Server
  Given the AI Server fails to parse the provided PDF structure
  When the system receives the response
  Then the response body should contain "Parsing failed" with the reason

Scenario: Uploading a high-resolution PDF
  Given I have a PDF file larger than 15 MB named "high-res-jira.pdf"
  When I send a POST request to '/upload-document' with the file attached
  Then the system should process the file within 3 seconds

Scenario: Uploading malicious PDF file
  Given I upload a specially crafted PDF with embedded scripts
  When I send a POST request to '/upload-document' with the file attached
  Then the system should validate and block the unsafe file

Scenario: Concurrent file uploads
  Given 1000+ users are uploading Jira PDF files simultaneously
  When the system processes the uploads
  Then it should handle the uploads seamlessly without crashing

Scenario: Reliability during server failure
  Given the AI Server goes offline during file retrieval of '/files/uploads/jira.pdf'
  When the system retries transmission
  Then the response should be logged properly without data corruption or loss

Scenario: Usability testing for Functional Testing UI
  Given a user accesses the file upload feature
  When the user interacts with the interface
  Then the interface should be intuitive with visual aids and tooltips
  And the users should find uploading a Jira PDF straightforward to understand
