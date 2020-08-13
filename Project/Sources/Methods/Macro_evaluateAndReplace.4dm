//%attributes = {}
C_TEXT:C284($input_text)
GET MACRO PARAMETER:C997(Highlighted method text:K5:18; $input_text)

C_TEXT:C284($output_text)
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

SET MACRO PARAMETER:C998(Highlighted method text:K5:18; $output_text)
