//%attributes = {}
C_TEXT:C284($xmlText; $tmpText; $Dom_text; $enhancedXmlText)

$xmlText:="<text/>"
$Dom_text:=DOM Parse XML variable:C720($xmlText)
XML SET OPTIONS:C1090($Dom_text; XML indentation:K45:34; XML no indentation:K45:36)
DOM EXPORT TO VAR:C863($Dom_text; $tmpText)

//ASSERT($xmlText=$tmpText) -> not working because add root xml node information like DTD etc..


// let's try on a child node

$enhancedXmlText:="<root>"+$xmlText+"</root>"
$Dom_text:=DOM Parse XML variable:C720($enhancedXmlText)
XML SET OPTIONS:C1090($Dom_text; XML indentation:K45:34; XML no indentation:K45:36)
DOM EXPORT TO VAR:C863(DOM Find XML element:C864($Dom_text; "/root/text"); $tmpText)
ASSERT:C1129($xmlText=$tmpText; "exported node text add not equals to first node")
