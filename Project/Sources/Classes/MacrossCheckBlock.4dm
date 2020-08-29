Class extends MacrossBuffer

Function run
	
	This:C1470.lines:=This:C1470.getLines()
	This:C1470.current:=""
	This:C1470.block:=New collection:C1472()
	This:C1470.outputlines:=New collection:C1472()
	This:C1470.blockStartLines:=New collection:C1472()
	C_TEXT:C284($line)
	For each ($line; This:C1470.lines)
		// TODO exclude comment, trim maybe, find language word only (not in string etc..)
		Case of 
				
			: (Position:C15("End if"; $line)>0)
				This:C1470.blockEnd("if"; $line)
				
			: (Position:C15("End for each"; $line)>0)
				This:C1470.blockEnd("each"; $line)
				
			: (Position:C15("End for"; $line)>0)
				This:C1470.blockEnd("for"; $line)
				
			: (Position:C15("End while"; $line)>0)
				This:C1470.blockEnd("while"; $line)
				
			: (Position:C15("Until"; $line)>0)
				This:C1470.blockEnd("repeat"; $line)
				
			: (Position:C15("If ("; $line)>0)
				This:C1470.blockStart("if"; $line)
				
			: (Position:C15("For each ("; $line)>0)
				This:C1470.blockStart("each"; $line)
				
			: (Position:C15("For ("; $line)>0)
				This:C1470.blockStart("for"; $line)
				
			: (Position:C15("While ("; $line)>0)
				This:C1470.blockStart("while"; $line)
				
			: (Position:C15("Repeat"; $line)>0)
				This:C1470.blockStart("repeat"; $line)
				
			Else 
				
		End case 
		
		This:C1470.outputlines.push($line)
		
	End for each 
	
	While (This:C1470.block.length>0)
		
		This:C1470.current:=This:C1470.block.pop()
		This:C1470.currentLine:=This:C1470.blockStartLines.pop()
		This:C1470.popPopPop()
		
	End while 
	
	This:C1470.setLines(This:C1470.outputlines)
	
Function blockStart
	C_TEXT:C284($1; $2)
	This:C1470.current:=$1
	This:C1470.block.push($1)
	This:C1470.currentLine:=$2
	This:C1470.blockStartLines.push($2)
	
Function blockEnd
	C_TEXT:C284($1)
	This:C1470.current:=This:C1470.block.pop()
	This:C1470.currentLine:=This:C1470.blockStartLines.pop()
	While ((This:C1470.current#$1) & (This:C1470.current#""))
		This:C1470.popPopPop()
		This:C1470.current:=This:C1470.block.pop()
		This:C1470.currentLine:=This:C1470.blockStartLines.pop()
	End while 
	If (This:C1470.current="")
		// missing start
		Case of 
				
			: ($1="if")
				
				This:C1470.outputlines.push("If(/*todo*/) // MACRO")
				
			: ($1="each")
				
				This:C1470.outputlines.push("For each(;) // MACRO")
				
			: ($1="for")
				
				This:C1470.outputlines.push("For(/*todo*/) // MACRO")
				
			: ($1="while")
				
				This:C1470.outputlines.push("While(/*todo*/) // MACRO")
				
			: ($1="repeat")
				
				This:C1470.outputlines.push("Repeat // MACRO")
				
		End case 
	End if 
	
Function popPopPop()
	
	Case of 
			
		: (This:C1470.current="if")
			
			This:C1470.outputlines.push("End if // MACRO:"+This:C1470.currentLine)
			
		: (This:C1470.current="each")
			
			This:C1470.outputlines.push("End for each // MACRO:"+This:C1470.currentLine)
			
		: (This:C1470.current="for")
			
			This:C1470.outputlines.push("End for // MACRO:"+This:C1470.currentLine)
			
		: (This:C1470.current="while")
			
			This:C1470.outputlines.push("End while // MACRO:"+This:C1470.currentLine)
			
		: (This:C1470.current="repeat")
			
			This:C1470.outputlines.push("Until (</caret>) // MACRO:"+This:C1470.currentLine)
			
	End case 