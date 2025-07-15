Feature: Testing Roostgpt API for uploading Jira ticket PDFs

Background:
  Given the API base URL 'http://roostgpt-api.example.com'
  And the authorization header is set
  And the content type is 'application/json'

Scenario: Upload a valid PDF file of a Jira ticket
  Given I have a valid PDF file named "jira.pdf"
  When I send a POST request to '/upload-ticket' with the file attached
  Then the response status should be 200
  And the response body should contain 'File uploaded successfully'

Scenario: Upload an empty PDF file
  Given I have an empty PDF file named "empty.pdf"
  When I send a POST request to '/upload-ticket' with the file attached
  Then the response status should be 400
  And the response body should contain 'Error: Empty file uploaded'

Scenario: Upload a corrupted PDF file
  Given I have a corrupted PDF file named "corrupted.pdf"
  When I send a POST request to '/upload-ticket' with the file attached
  Then the response status should be 400
  And the response body should contain 'Error: Corrupted file uploaded'

Scenario: Document type validation - Upload unsupported file type
  Given I have a file named "unsupported.docx"
  When I send a POST request to '/upload-ticket' with the file attached
  Then the response status should be 415
  And the response body should contain 'Unsupported file type'

Scenario: Document type validation - Upload PDF with wrong MIME type
  Given I have a file named "wrong-mime.pdf" with incorrect MIME type
  When I send a POST request to '/upload-ticket' with the file attached
  Then the response status should be 415
  And the response body should contain 'Error: Unsupported file type'

Scenario: Process the upload in Roost-Reg
  Given I have a valid PDF file named "jira.pdf"
  And the file contains 'fileName', 'content', and 'prompt type' in the metadata
  When I send a POST request to '/process-upload' with this data
  Then the response status should be 200
  And the system should store the file path, 'fileName', and 'prompt type'

Scenario: Process upload with malformed metadata
  Given I have a PDF file with malformed 'fileName' or 'content'
  When I send a POST request to '/process-upload' with this data
  Then the response status should be 400
  And the response body should contain 'Error: Invalid metadata provided'

Scenario: Integrate with AI server for processing
  Given I have a valid file path, 'fileName', and 'prompt type'
  When I send a POST request to '/ai-server-process' with the data
  Then the response status should be 200
  And the AI server processes the file content and 'prompt type'

Scenario: AI server fails due to invalid file path
  Given I have an invalid file path "invalid/path/to/file"
  When I send a POST request to '/ai-server-process' with this data
  Then the response status should be 404
  And the response body should contain 'Error: File not found'

Scenario: Parse valid Jira ticket PDF
  Given I have a valid PDF file "jira.pdf" with title, description, and comments
  When I send it to the AI server for parsing
  Then the response status should be 200
  And the response body should contain 'title', 'description', and 'comments'

Scenario: Parse PDF with missing expected fields
  Given I have a valid PDF file "incomplete-jira.pdf" without expected fields
  When I send it to the AI server for parsing
  Then the response status should be 400
  And the response body should contain 'Error: Invalid PDF structure'

Scenario: Validate prompt type during upload
  Given I have a valid PDF file "jira.pdf" with supported prompt type "Functional Test"
  When I send a POST request to '/upload-ticket' with this data
  Then the response status should be 200
  And the response body should contain 'Prompt type validated successfully'

Scenario: Upload with unsupported prompt type
  Given I have a valid PDF file "jira.pdf" with unsupported prompt type "Unsupported Type"
  When I send a POST request to '/upload-ticket' with this data
  Then the response status should be 400
  And the response body should contain 'Error: Invalid prompt type'

Scenario: Upload a large PDF file
  Given I have a valid PDF file 'large-jira.pdf' of size 100 MB
  When I send a POST request to '/upload-ticket' with the file attached
  Then the response status should be 200
  And the upload should complete within 10 seconds

Scenario: Upload a file exceeding threshold size
  Given I have a PDF file "oversized-jira.pdf" of size 1 GB
  When I send a POST request to '/upload-ticket' with the file attached
  Then the response status should be 413
  And the response body should contain 'Error: File size exceeds limit'

Scenario: Handle concurrent uploads
  Given multiple users attempt to upload PDF files concurrently
  When I send POST requests to '/upload-ticket' simultaneously
  Then the system should handle all uploads without degradation in performance

Scenario: Handle network interruption during upload
  Given I have a PDF file "jira.pdf" being uploaded
  When I simulate a network interruption during upload
  Then the system should retry the upload
  And the response status should be logged as 'Retrying upload'

Scenario: User experience under server load
  Given multiple users are uploading PDFs simultaneously causing high server load
  When I send a POST request to '/upload-ticket'
  Then the response status should be 429
  And the response body should contain 'System busy, please retry'
