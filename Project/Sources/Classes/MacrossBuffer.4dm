
Class constructor
	This:C1470.lineSeparator:="\r"  // get from OS?
	
Function getLines
	C_COLLECTION:C1488($0)
	$0:=Split string:C1554(This:C1470.getFullText(); This:C1470.lineSeparator)
	
Function getSelections
	C_COLLECTION:C1488($0)
	$0:=Split string:C1554(This:C1470.getSelectionText(); This:C1470.lineSeparator)
	
Function setLines
	C_COLLECTION:C1488($1)
	This:C1470.setFullText($1.join(This:C1470.lineSeparator))
	
Function setSelections
	C_COLLECTION:C1488($1)
	This:C1470.setSelectionText($1.join(This:C1470.lineSeparator))
	
Function getFullText
	C_TEXT:C284($0; $text)
	GET MACRO PARAMETER:C997(Full method text:K5:17; $text)
	$0:=$text
	
Function getSelectionText
	C_TEXT:C284($0; $text)
	GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $text)
	$0:=$text
	
Function setFullText
	C_TEXT:C284($1)
	SET MACRO PARAMETER:C998(Full method text:K5:17; $1)
	
Function setSelectionText
	C_TEXT:C284($1)
	GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $1)