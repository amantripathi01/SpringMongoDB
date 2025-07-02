Feature: XML File Upload Functionality

Background:
  Given the API base URL is 'http://localhost:3000/api/upload'
  And the authorization header is set with valid token
  And the content type is 'multipart/form-data'

Scenario: Verify XML File Upload Functionality
  Given an XML file 'validFile.xml' with valid content
  When I send a POST request to '/files' with the XML file as payload
  Then the response status should be 200
  And the response body should contain 'File uploaded successfully'

Scenario: Verify Upload Restriction for Large XML Files
  Given an XML file 'largeFile.xml' of size 10MB
  When I send a POST request to '/files' with the large XML file as payload
  Then the response status should be 400
  And the response body should contain 'Uploaded file exceeds size limit'

Scenario: Verify Upload Restriction for Non-XML Files
  Given a non-XML file 'document.pdf'
  When I send a POST request to '/files' with the non-XML file as payload
  Then the response status should be 400
  And the response body should contain 'Invalid file type. Only XML files are supported'

Scenario: Verify Upload Restriction for Incorrect File Extension
  Given an XML file with incorrect extension 'file.xml.txt'
  When I send a POST request to '/files' with the incorrect file extension as payload
  Then the response status should be 400
  And the response body should contain 'Invalid file type. Only XML files are supported'

Scenario: Validate UI Behavior for Unsupported File Extensions
  Given an unsupported file format 'archive.zip'
  When I send a POST request to '/files' with the unsupported file format as payload
  Then the response status should be 400
  And the response body should contain 'Invalid file type. Only XML files are supported'

Scenario: Verify Validation for Empty File Upload
  Given an empty XML file 'emptyFile.xml'
  When I send a POST request to '/files' with the empty XML file as payload
  Then the response status should be 400
  And the response body should contain 'File is empty. Please upload a valid XML file'

Scenario: Verify Error Handling for Drag-and-Drop Upload Method
  Given a non-XML file 'presentation.pptx'
  When I simulate a drag-and-drop upload of the non-XML file to '/files'
  Then the response status should be 400
  And the response body should contain 'Invalid file type. Only XML files are supported'

Scenario: Validate Error Messaging Localization for Unsupported Files (Spanish)
  Given an unsupported file 'video.mkv'
  And the UI language is configured to Spanish
  When I send a POST request to '/files' with the unsupported file as payload
  Then the response status should be 400
  And the error message should be 'Tipo de archivo inválido. Solo se aceptan archivos XML'

Scenario: Validate Error Messaging Localization for Unsupported Files (French)
  Given an unsupported file 'image.png'
  And the UI language is configured to French
  When I send a POST request to '/files' with the unsupported file as payload
  Then the response status should be 400
  And the error message should be 'Type de fichier invalide. Seuls les fichiers XML sont autorisés'

Scenario: Verify Performance Under Load
  Given 50 concurrent users uploading valid XML files
  When I send a POST request to '/files' with valid XML files simultaneously
  Then the application should return responses with status 200
  And the response time for all requests should be under 2 seconds

Scenario: Validate Upload Speed
  Given an XML file 'moderateFile.xml' of size 5MB
  When I send a POST request to '/files' with the XML file as payload
  Then the response status should be 200
  And the file upload should complete within 5 seconds

Scenario: Edge Case Test for Borderline-Sized File Upload
  Given an XML file 'borderlineFile.xml' of size 9.9MB
  When I send a POST request to '/files' with the borderline file as payload
  Then the response status should be 200
  And the response should indicate successful upload within acceptable performance time

Scenario: Ensure UI Responsiveness During File Upload
  Given a valid XML file 'normalFile.xml'
  And the user interacts with other elements during file upload
  When I send a POST request to '/files' with the XML file as payload
  Then the response status should be 200
  And the UI should remain responsive during the upload

Scenario: Check Compatibility Across Browsers
  Given the browser is 'Chrome' and an XML file 'validFile.xml'
  When I send a POST request to '/files' with the XML file as payload
  Then the response status should be 200
  And the file upload should be successful
  Examples:
    | Browser    | Status |
    | Chrome     | 200    |
    | Firefox    | 200    |
    | Safari     | 200    |
    | Edge       | 200    |

Scenario: Verify Security Measures for Malicious Files
  Given a malicious XML file 'maliciousFile.xml' containing harmful scripts
  When I send a POST request to '/files' with the malicious XML file as payload
  Then the response status should be 400
  And the response body should contain 'File is rejected due to security reasons'
  And the system should log appropriate warnings or errors

Scenario: Confirm Accessibility Standards
  Given an assistive technology like a screen reader
  When the user navigates to the file upload UI
  Then the screen reader should announce all upload instructions and error messages clearly
