//%attributes = {}
C_OBJECT:C1216($buffer)
$buffer:=cs:C1710.MacrossBuffer.new()
C_TEXT:C284($input_text; $output_text)
$input_text:=$buffer.getSelectionText()

C_VARIANT:C1683($var)
$var:=Formula from string:C1601($input_text).call()
Case of 
	: (Value type:C1509($var)=Is object:K8:27)
		$output_text:="\""+JSON Stringify:C1217($var)+"\""
	: (Value type:C1509($var)=Is collection:K8:32)
		$output_text:="\""+JSON Stringify:C1217($var)+"\""
	: (Value type:C1509($var)=Is text:K8:3)
		$output_text:="\""+($var)+"\""
	Else 
		$output_text:=String:C10($var)
End case 

$buffer.setSelectionText($output_text)
