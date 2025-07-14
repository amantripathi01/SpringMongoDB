Feature: XML File Upload Check From UI for ZBIO-6758

Background:
  Given the API base URL 'http://localhost:3000'
  And the authorization header is set
  And the content type is 'application/xml'

Scenario: Valid XML file upload
  Given a valid XML file named "valid_file.xml"
  When I send a POST request to '/upload-xml' with the file in the payload
  Then the response status should be 200
  And the response message should be "File upload successful"
  And the backend processes the file correctly

Scenario: Upload unsupported file formats
  Given an unsupported file named "unsupported_file.docx"
  When I send a POST request to '/upload-xml' with the file in the payload
  Then the response status should be 400
  And the response message should be "Unsupported file type. Please upload an XML file"

Scenario: Empty or null file upload attempt
  Given an empty file named "empty_file.xml"
  When I send a POST request to '/upload-xml' with the file in the payload
  Then the response status should be 400
  And the response message should be "Please select a file to upload"

Scenario: File size limit validation
  Given a valid XML file named "large_file.xml" of size 6MB
  When I send a POST request to '/upload-xml' with the file in the payload
  Then the response status should be 413
  And the response message should be "File size exceeds the maximum allowed limit of 5MB"

Scenario: File naming edge cases
  Given a valid XML file named "my file @work.xml"
  When I send a POST request to '/upload-xml' with the file in the payload
  Then the response status should be 200
  And the response message should be "File upload successful"

Scenario: Multiple file upload attempt
  Given 3 files named "valid_file.xml", "unsupported_file.pdf", and "valid_other_file.xml"
  When I send a POST request to '/upload-xml' with all files in the payload
  Then the response status should be 207
  And the response message for each file should indicate success for XML files and failure for unsupported formats

Scenario: UI performance during file upload
  Given a batch of 50 small valid XML files named sequentially
  When I send a POST request to '/upload-xml' with the files in the payload
  Then the response status should be 200 for all valid files
  And the upload process should remain smooth without UI lag

Scenario: Error message readability and localization
  Given a file named "invalid_file.format" uploaded while language is set to Spanish
  When I send a POST request to '/upload-xml' with the file in the payload
  Then the response status should be 400
  And the response message should be "Formato de archivo no permitido. Por favor, carga un archivo XML."

Scenario: Browser compatibility
  Given a valid XML file named "browser_test.xml"
  When I send a POST request to '/upload-xml' on Chrome, Firefox, Safari, and Edge
  Then the response status should be consistent across browsers with code 200
  And the response message should be "File upload successful"

Scenario: Security validation for uploaded files
  Given a malicious XML file named "malicious_code.xml"
  When I send a POST request to '/upload-xml' with the file in the payload
  Then the response status should be 400
  And the response message should be "File upload failed due to security concerns"

Scenario: System scalability under peak load
  Given 100 users upload valid XML files named sequentially from "user_1.xml" to "user_100.xml"
  When I send concurrent POST requests to '/upload-xml'
  Then the response status should be 200 for all valid files
  And the system responds without crashing or timing out

Scenario: UI design responsiveness across devices
  Given the file upload UI accessed on desktop, tablet, and mobile devices
  When I select and upload a valid XML file named "upload_test.xml"
  Then the UI elements should be properly aligned for each device type
  And the response status should be 200
  And the response message should be "File upload successful"
