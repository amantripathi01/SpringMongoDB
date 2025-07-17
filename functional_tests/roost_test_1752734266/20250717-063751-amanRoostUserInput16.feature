Feature: Verify Text Formatting in DOCX Document

Background:
  Given the sample DOCX document is opened in a compatible word processor

Scenario: Verify Bold Text Formatting
  Given the section with bold text is located
  When I check the text formatting
  Then the text should appear bold as per the formatting applied

Scenario: Verify Italic Text Formatting
  Given the section with italic text is located
  When I check the text formatting
  Then the text should appear italic as per the formatting applied

Scenario: Verify Combined Bold and Italic Text Formatting
  Given the section with combined bold and italic text is located
  When I check the text formatting
  Then the text should appear with both bold and italic formatting as applied

Scenario: Verify Bulleted List Formatting
  Given the bulleted list section is located
  When I check the list formatting
  Then each list item should be correctly preceded by a bullet

Scenario: Verify Numbered List Formatting
  Given the numbered list section is located
  When I check the list formatting
  Then each list item should be correctly preceded by a number

Scenario: Verify Text Alignment and Size
  Given the paragraph demonstrating text alignment and size is located
  When I check the text alignment and size
  Then the text should have the correct alignment and size as specified

Scenario: Verify Monospace Text Formatting
  Given the section with monospace text is located
  When I check the text formatting
  Then the text should appear in a monospace font as applied

Scenario: Verify Strikethrough Text Formatting
  Given the section with strikethrough text is located
  When I check the text formatting
  Then the text should appear with a strikethrough line as applied

Scenario: Verify Blockquote Formatting
  Given the blockquote section is located
  When I check the blockquote formatting
  Then the blockquote should be correctly indented and styled as specified

Scenario: Document Load Performance
  Given the word processor is ready for use
  When I open the sample DOCX document
  Then the document should load within 2 seconds

Scenario: Document Rendering Consistency
  Given multiple word processors are installed
  When I open the sample DOCX document in each word processor
  Then the document should render consistently across all tested word processors
