
Class constructor
	C_VARIANT:C1683($1)
	
	Case of 
		: (Count parameters:C259=0)
			ASSERT:C1129(False:C215; "Missing args")
		: (Value type:C1509($1)=Is text:K8:3)
			This:C1470._parse($1)
		: (Value type:C1509($1)=Is object:K8:27)
			
			Case of 
				: (OB Instance of:C1731($1; 4D:C1709.File))
					ASSERT:C1129($1.exists; "File do not exists")
					This:C1470._parse($1.getText())
					This:C1470.source:=$1
				: (Value type:C1509($1.macros)=Is collection:K8:32)
					This:C1470.macros:=$1.macros
				Else 
					ASSERT:C1129($1.name#Null:C1517; "macro has no name")
					This:C1470.macros:=New collection:C1472($1)  // suppose macro
					
			End case 
		: (Value type:C1509($1)=Is collection:K8:32)
			This:C1470.macros:=$1
			// XXX check valid here?
		Else 
			// current base macro 
			This:C1470.source:=Folder:C1567(fk database folder:K87:14; *).folder("Macros v2").file("Macros.xml")
			If (Asserted:C1132(This:C1470.source.exists; "No macro file exists for this db. pass file or text as arg"))
				This:C1470._parse(This:C1470.source.getText())
			End if 
	End case 
	
Function _parse
	C_TEXT:C284($xmlText; $1)
	$xmlText:=$1
	This:C1470.macros:=New collection:C1472()
	
	If (Length:C16($xmlText)>0)
		C_TEXT:C284($Dom_root; $Dom_tmp)
		$Dom_root:=DOM Parse XML variable:C720($xmlText)
		XML SET OPTIONS:C1090($Dom_root; XML indentation:K45:34; XML no indentation:K45:36)
		
		ARRAY TEXT:C222($Dom_macros; 0)
		$Dom_tmp:=DOM Find XML element:C864($Dom_root; "/macros/macro"; $Dom_macros)
		
		C_LONGINT:C283($i)
		C_TEXT:C284($Dom_text)
		For ($i; 1; Size of array:C274($Dom_macros); 1)
			
			C_OBJECT:C1216($macro)
			$macro:=This:C1470._domAttributeToObject($Dom_macros{$i})
			$Dom_text:=DOM Find XML element:C864($Dom_macros{$i}; "text")
			ASSERT:C1129(Num:C11($Dom_text)#0; "No text. is it valid?")
			C_TEXT:C284($tmpText)
			DOM EXPORT TO VAR:C863($Dom_text; $tmpText)
			$macro.text:=$tmpText
			//$macro.text:=Replace string($macro.text; "\r"; "")
			//$macro.text:=Replace string($macro.text; "\n"; "")
			
			// XXX other child in macro ?
			
			This:C1470.macros.push($macro)
			
		End for 
		
		DOM CLOSE XML:C722($Dom_root)
		
	End if 
	
Function _domAttributeToObject
	C_TEXT:C284($Dom_ref; $1)
	C_OBJECT:C1216($macro; $0)
	$Dom_ref:=$1
	$macro:=New object:C1471()
	C_LONGINT:C283($numAttributes)
	$numAttributes:=DOM Count XML attributes:C727($Dom_ref)
	
	C_TEXT:C284($name; $value)
	C_LONGINT:C283($i)
	For ($i; 1; $numAttributes; 1)
		DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_ref; $i; $name; $value)
		$macro[$name]:=$value
	End for 
	$0:=$macro
	
Function export
	C_OBJECT:C1216($dir; $file)
	C_LONGINT:C283($1)  // indentation?
	
	If (This:C1470.source#Null:C1517)
		$file:=This:C1470.source
	Else 
		$dir.create()
		$file:=$dir.file("Macros.xml")
	End if 
	
	If (Count parameters:C259>0)
		This:C1470.exportToFile($file; $1)
	Else 
		This:C1470.exportToFile($file)
	End if 
	
Function exportToFile
	C_OBJECT:C1216($1; $file)
	$file:=$1
	C_LONGINT:C283($2)  // indentation?
	
	C_TEXT:C284($xmlText)
	$xmlText:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>"+"<!DOCTYPE macros SYSTEM \"http://www.4d.com/dtd/2007/macros.dtd\">"+"<macros>"+"</macros>"
	
	
	C_TEXT:C284($Dom_ref; $Dom_macro)
	$Dom_ref:=DOM Parse XML variable:C720($xmlText)
	If (Count parameters:C259>1)
		XML SET OPTIONS:C1090($Dom_ref; XML indentation:K45:34; $2)
	End if 
	
	C_OBJECT:C1216($macro)
	For each ($macro; This:C1470.macros)
		
		$macro:=OB Copy:C1225($macro)
		$Dom_macro:=DOM Create XML element:C865($Dom_ref; "macro")
		
		C_TEXT:C284($tmpText; $Dom_tmp)
		$tmpText:=$macro.text
		$Dom_tmp:=DOM Append XML element:C1082($Dom_macro; DOM Parse XML variable:C720($tmpText))
		
		OB REMOVE:C1226($macro; "text")
		
		C_TEXT:C284($key)
		For each ($key; $macro)
			DOM SET XML ATTRIBUTE:C866($Dom_macro; $key; $macro[$key])
		End for each 
		
	End for each 
	
	DOM EXPORT TO FILE:C862($Dom_ref; $file.platformPath)
	
	