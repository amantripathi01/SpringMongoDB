Feature: API Testing for User Story [ZBIO-6159]

Background:
  Given the API base URL "http://localhost:3000"
  And the authorization header is set as "Bearer {ACCESS_TOKEN}"
  And the content type is "application/json"

Scenario: Uploading Jira ticket PDF from Approostio
  Given a valid Jira ticket PDF named "jira.pdf" with "fileName", "content", and "promptType"
  When I send a POST request to "/upload-jira-ticket" with the payload:
    """
    {
      "fileName": "jira.pdf",
      "content": "encoded-content",
      "promptType": "functionalTest"
    }
    """
  Then the response status should be 201
  And the response body should contain:
    """
    {
      "filePath": "/storage/jira/jira.pdf",
      "fileName": "jira.pdf",
      "promptType": "functionalTest"
    }
    """
  And the file path should be stored in roost-reg.

Scenario: Uploading PDF larger than the limit
  Given a Jira ticket PDF sized 6 MB
  When I send a POST request to "/upload-jira-ticket" with the large file payload
  Then the response status should be 400
  And the response body should contain:
    """
    {
      "error": "File size exceeds the limit of 5 MB."
    }
    """

Scenario: Uploading unsupported file format
  Given a Jira ticket file named "jira.docx"
  When I send a POST request to "/upload-jira-ticket" with the file payload
  Then the response status should be 415
  And the response body should contain:
    """
    {
      "error": "Unsupported file format. Please upload only PDF files."
    }
    """

Scenario: Sending File Data from Roost-reg to AI Server
  Given a list of file paths from roost-reg containing "fileName" and "promptType"
  When I send a POST request to "/send-file-data" with payload:
    """
    {
      "files": [
        { "fileName": "jira.pdf", "promptType": "functionalTest" }
      ]
    }
    """
  Then the response status should be 200
  And the AI server should receive the accurate file paths.

Scenario: Incorrect file paths sent to AI server
  Given a list of incorrect file paths containing "fileName" and "promptType"
  When I send a POST request to "/send-file-data" with payload:
    """
    {
      "files": [
        { "fileName": "unknown.pdf", "promptType": "functionalTest" }
      ]
    }
    """
  Then the response status should be 404
  And the response body should contain:
    """
    {
      "error": "File not found."
    }
    """

Scenario: Parsing Jira Ticket PDF in AI Server
  Given a valid Jira ticket PDF named "jira.pdf"
  When I send a POST request to "/parse-jira-pdf" with payload:
    """
    {
      "filePath": "/storage/jira/jira.pdf"
    }
    """
  Then the response status should be 200
  And the response body should contain:
    """
    {
      "Title": "[ZBIO-6159] Roostgpt change for upload of Jira ticket as pdf for functional Test",
      "Description": "@Divyesh can we prioritise the upload of Jira ticket as pdf for functional test? ...",
      "Comments": "Flow of the code ... server to node js implementation"
    }
    """

Scenario: Handling Malformatted PDF in Parsing
  Given a corrupted Jira ticket PDF file
  When I send a POST request to "/parse-jira-pdf" with payload:
    """
    {
      "filePath": "/storage/corrupted/jira.pdf"
    }
    """
  Then the response status should be 422
  And the response body should contain:
    """
    {
      "error": "Unable to parse PDF content."
    }
    """

Scenario: Retrieving Content for AI Processing
  Given file paths received from roost-reg
  When I send a GET request to "/retrieve-content" with query parameters:
    "filePath=/storage/jira/jira.pdf&promptType=functionalTest"
  Then the response status should be 200
  And the content should be processed based on "functionalTest" logic.

Scenario: Retrieving inaccessible file paths
  Given an inaccessible file path "/storage/missing/jira.pdf"
  When I send a GET request to "/retrieve-content" with query parameters:
    "filePath=/storage/missing/jira.pdf&promptType=functionalTest"
  Then the response status should be 404
  And the response body should contain:
    """
    {
      "error": "File not found or unreachable."
    }
    """

Scenario: Error Handling for Unsupported Formats
  Given a user uploads a file without an extension
  When I send a POST request to "/upload-jira-ticket" with a hidden file payload
  Then the response status should be 400
  And the response body should contain:
    """
    {
      "error": "Unsupported file format. Please upload only PDF files."
    }
    """

Scenario: Performance Testing for Upload
  Given a Jira ticket PDF named "jira.pdf" with maximum allowed file size (5 MB)
  When I send a POST request to "/upload-jira-ticket" with payload:
    """
    {
      "fileName": "jira.pdf",
      "content": "large_encoded_content",
      "promptType": "performanceTest"
    }
    """
  Then the response status should be 201
  And the upload should be completed within 3 seconds.

Scenario: Scalability Testing for Concurrent Uploads
  Given a batch of 50 Jira ticket PDFs of varying sizes
  When I send POST requests concurrently to "/upload-jira-ticket"
  Then all valid files should be uploaded successfully
  And any invalid file uploads should return file-specific error responses.

Scenario: Security Testing for Malicious Files
  Given a malicious file disguised as a PDF
  When I send a POST request to "/upload-jira-ticket" with suspicious payload
  Then the response status should be 403
  And the attempt should be logged for monitoring.

Scenario: Compatibility Testing for Various PDF Tools
  Given a Jira ticket PDF generated from an online converter
  When I send a POST request to "/upload-jira-ticket" with valid payload
  Then the PDF should be parsed and stored successfully.
