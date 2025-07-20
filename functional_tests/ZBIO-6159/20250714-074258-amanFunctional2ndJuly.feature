
// ********RoostGPT********
/*

roost_feedback [14/07/2025, 7:51:47 AM]:-\sAdd\smore\scomments\sto\sthe\stest
*/

// ********RoostGPT********

Feature: API Testing for User Story [ZBIO-6159]

Background:
  # Setting up common prerequisites for all test scenarios
  Given the API base URL "http://localhost:3000"
  # Provide authorization to access API endpoints
  And the authorization header is set as "Bearer {ACCESS_TOKEN}"
  # Use JSON format for requests and responses
  And the content type is "application/json"

Scenario: Uploading Jira ticket PDF from Approostio
  # Verifying successful upload of a valid Jira ticket in PDF format
  Given a valid Jira ticket PDF named "jira.pdf" with "fileName", "content", and "promptType"
  # Trigger an API call to upload the Jira ticket
  When I send a POST request to "/upload-jira-ticket" with the payload:
    """
    {
      "fileName": "jira.pdf",
      "content": "encoded-content",
      "promptType": "functionalTest"
    }
    """
  # Check if the response status indicates successful upload
  Then the response status should be 201
  # Validate the returned response body
  And the response body should contain:
    """
    {
      "filePath": "/storage/jira/jira.pdf",
      "fileName": "jira.pdf",
      "promptType": "functionalTest"
    }
    """
  # Ensure file path is registered in roost-reg for future use
  And the file path should be stored in roost-reg.

Scenario: Uploading PDF larger than the limit
  # Ensure the service rejects files exceeding the 5 MB size limit
  Given a Jira ticket PDF sized 6 MB
  # Attempting to upload a file exceeding the size limit
  When I send a POST request to "/upload-jira-ticket" with the large file payload
  # Confirm unsuccessful request status
  Then the response status should be 400
  # Verify error response details for exceeding file size
  And the response body should contain:
    """
    {
      "error": "File size exceeds the limit of 5 MB."
    }
    """

Scenario: Uploading unsupported file format
  # Testing rejection of unsupported file formats (non-PDF)
  Given a Jira ticket file named "jira.docx"
  # API call to upload unsupported file format
  When I send a POST request to "/upload-jira-ticket" with the file payload
  # Confirm service rejection status for unsupported formats
  Then the response status should be 415
  # Verify the error message for unsupported formats
  And the response body should contain:
    """
    {
      "error": "Unsupported file format. Please upload only PDF files."
    }
    """

Scenario: Sending File Data from Roost-reg to AI Server
  # Testing file path transfer from roost-reg to AI server
  Given a list of file paths from roost-reg containing "fileName" and "promptType"
  # API request to forward file paths to AI server
  When I send a POST request to "/send-file-data" with payload:
    """
    {
      "files": [
        { "fileName": "jira.pdf", "promptType": "functionalTest" }
      ]
    }
    """
  # Verify successful submission status
  Then the response status should be 200
  # Ensure AI server receives accurate file paths
  And the AI server should receive the accurate file paths.

Scenario: Incorrect file paths sent to AI server
  # Ensure the service handles invalid file paths properly
  Given a list of incorrect file paths containing "fileName" and "promptType"
  # Attempting to forward incorrect file paths
  When I send a POST request to "/send-file-data" with payload:
    """
    {
      "files": [
        { "fileName": "unknown.pdf", "promptType": "functionalTest" }
      ]
    }
    """
  # Confirm service rejects invalid data
  Then the response status should be 404
  # Check for the returned error response details
  And the response body should contain:
    """
    {
      "error": "File not found."
    }
    """

Scenario: Parsing Jira Ticket PDF in AI Server
  # Verifying successful parsing of a valid Jira ticket PDF file
  Given a valid Jira ticket PDF named "jira.pdf"
  # API call to initiate parsing
  When I send a POST request to "/parse-jira-pdf" with payload:
    """
    {
      "filePath": "/storage/jira/jira.pdf"
    }
    """
  # Confirm successful parsing status
  Then the response status should be 200
  # Validate parsed content details in the response
  And the response body should contain:
    """
    {
      "Title": "[ZBIO-6159] Roostgpt change for upload of Jira ticket as pdf for functional Test",
      "Description": "@Divyesh can we prioritise the upload of Jira ticket as pdf for functional test? ...",
      "Comments": "Flow of the code ... server to node js implementation"
    }
    """

Scenario: Handling Malformatted PDF in Parsing
  # Ensure the service handles malformatted PDF files gracefully
  Given a corrupted Jira ticket PDF file
  # API call to parse the corrupted file
  When I send a POST request to "/parse-jira-pdf" with payload:
    """
    {
      "filePath": "/storage/corrupted/jira.pdf"
    }
    """
  # Confirm parsing failure status
  Then the response status should be 422
  # Check for returned error response details
  And the response body should contain:
    """
    {
      "error": "Unable to parse PDF content."
    }
    """

Scenario: Retrieving Content for AI Processing
  # Testing retrieval of content for AI processing based on paths and prompt types
  Given file paths received from roost-reg
  # API request to retrieve content using valid file paths
  When I send a GET request to "/retrieve-content" with query parameters:
    "filePath=/storage/jira/jira.pdf&promptType=functionalTest"
  # Confirm successful content retrieval status
  Then the response status should be 200
  # Ensure content is processed per functional test requirements
  And the content should be processed based on "functionalTest" logic.

Scenario: Retrieving inaccessible file paths
  # Confirm handling of inaccessible or missing file paths
  Given an inaccessible file path "/storage/missing/jira.pdf"
  # Attempting to retrieve content for an inaccessible file
  When I send a GET request to "/retrieve-content" with query parameters:
    "filePath=/storage/missing/jira.pdf&promptType=functionalTest"
  # Verify rejection for unavailable file paths
  Then the response status should be 404
  # Check the error details for inaccessible paths
  And the response body should contain:
    """
    {
      "error": "File not found or unreachable."
    }
    """

Scenario: Error Handling for Unsupported Formats
  # Ensure robust handling of uploads without acceptable file formats or extensions
  Given a user uploads a file without an extension
  # API call with unsupported file format or missing extension
  When I send a POST request to "/upload-jira-ticket" with a hidden file payload
  # Confirm rejection of unsupported payload
  Then the response status should be 400
  # Verify error message correctness
  And the response body should contain:
    """
    {
      "error": "Unsupported file format. Please upload only PDF files."
    }
    """

Scenario: Performance Testing for Upload
  # Ensure uploads perform optimally for the largest allowed file size
  Given a Jira ticket PDF named "jira.pdf" with maximum allowed file size (5 MB)
  # Simulate upload of a large file within permissible limit
  When I send a POST request to "/upload-jira-ticket" with payload:
    """
    {
      "fileName": "jira.pdf",
      "content": "large_encoded_content",
      "promptType": "performanceTest"
    }
    """
  # Confirm successful upload status
  Then the response status should be 201
  # Ensure upload completes within acceptable duration
  And the upload should be completed within 3 seconds.

Scenario: Scalability Testing for Concurrent Uploads
  # Testing the service's ability to handle concurrent uploads efficiently
  Given a batch of 50 Jira ticket PDFs of varying sizes
  # API requests sent simultaneously for concurrent uploads
  When I send POST requests concurrently to "/upload-jira-ticket"
  # Validate success for valid files and errors for invalid ones
  Then all valid files should be uploaded successfully
  And any invalid file uploads should return file-specific error responses.

Scenario: Security Testing for Malicious Files
  # Test handling and monitoring of malicious file uploads
  Given a malicious file disguised as a PDF
  # Attempting to upload malicious content
  When I send a POST request to "/upload-jira-ticket" with suspicious payload
  # Ensure rejection of the malicious file
  Then the response status should be 403
  # Confirm logging for security monitoring
  And the attempt should be logged for monitoring.

Scenario: Compatibility Testing for Various PDF Tools
  # Ensure compatibility of the service with different PDF-producing tools
  Given a Jira ticket PDF generated from an online converter
  # Testing upload and processing of the file
  When I send a POST request to "/upload-jira-ticket" with valid payload
  # Validate upload and parsing success
  Then the PDF should be parsed and stored successfully.