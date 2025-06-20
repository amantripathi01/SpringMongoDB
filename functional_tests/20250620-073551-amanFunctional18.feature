Feature: Backend File Upload Restriction and Validation for XML Files

Scenario: Upload valid XML file successfully
  Given the API endpoint '/upload-file' and the file type is 'XML'
  And the file size is within the allowed limit
  When I send a POST request to upload a valid XML file
  Then the response status should be 200
  And the response body should contain "File uploaded successfully"

Scenario: Block non-XML files during upload
  Given the API endpoint '/upload-file' and the file type is not 'XML'
  When I send a POST request to upload a file with an unsupported type (e.g., PDF, DOCX, JSON, CSV, TXT, or EXE)
  Then the response status should be 400
  And the response body should contain "Only XML files are supported"

Scenario: Block empty XML file upload
  Given the API endpoint '/upload-file' and the uploaded file is an empty XML file (zero-byte)
  When I send a POST request to upload an empty XML file
  Then the response status should be 400
  And the response body should contain "Invalid file format or empty file"

Scenario: Block invalid XML file with incorrect schema
  Given the API endpoint '/upload-file' and the uploaded XML file does not conform to the Jira schema
  When I send a POST request to upload an XML file with an incorrect schema
  Then the response status should be 400
  And the response body should contain "Invalid XML file schema"

Scenario: Block simultaneous file upload
  Given the API endpoint '/upload-file'
  And multiple files are selected for upload
  When I send a POST request to upload multiple files simultaneously
  Then the response status should be 400
  And the response body should contain "Only one file upload is allowed at a time"

Scenario: Confirmation message for successful XML file upload
  Given the API endpoint '/upload-file'
  And the uploaded file is a valid XML Jira file
  When I send a POST request to upload the file
  Then the response status should be 200
  And the response body should contain "File uploaded successfully"

Scenario: Handle duplicate file upload rules
  Given the API endpoint '/upload-file' and the file type is 'XML'
  And the same file is uploaded twice
  When I send two POST requests to upload the same XML file
  Then the backend should either accept the file independently or return "Duplicate file detected" based on backend logic

Scenario: Validate file upload performance
  Given the API endpoint '/upload-file'
  And the file size is close to the maximum allowed limit
  When I send a POST request to upload the file
  Then the response status should be 200
  And the file upload should complete within 3 seconds

Scenario: Responsiveness of error messages
  Given the API endpoint '/upload-file' and the file type is not 'XML'
  And the internet speed varies (e.g., low and high bandwidth)
  When I send a POST request to upload the file
  Then the response body should contain "Only XML files are supported"
  And the message should appear promptly regardless of bandwidth

Scenario: Browser compatibility for file upload
  Given the API endpoint '/upload-file'
  And the upload functionality is tested on various browsers (Chrome, Firefox, Safari, Edge)
  When I send a POST request to upload an XML file
  Then the response status should be 200
  And the behavior should be consistent across all browsers

Scenario: UI responsiveness for different screen sizes
  Given the API endpoint '/upload-file'
  And the UI is resized to different screen sizes (mobile, tablet, desktop)
  When I select a valid XML file and upload the file
  Then the error/success messages and upload buttons should adapt to the screen size

Scenario: Block malicious XML file uploads
  Given the API endpoint '/upload-file'
  And the uploaded file is an XML file embedded with malicious scripts
  When I send a POST request to upload the file
  Then the response status should be 400
  And the response body should contain "File blocked due to potential security issues"

Scenario: Handle stress/load testing
  Given the API endpoint '/upload-file'
  And multiple users simultaneously attempt to upload XML files (100 users)
  When I send 100 POST requests from distinct users to upload their XML files
  Then the system should handle the load without crashing
  And the response time should stay within acceptable limits

Scenario: Backend exception handling during file upload
  Given the API endpoint '/upload-file' and the backend is experiencing issues (e.g., server crash)
  When I send a POST request to upload an XML file
  Then the response status should be 503
  And the response body should contain "File upload not available. Try again later"
