//%attributes = {}
C_TEXT:C284($xmlText)
$xmlText:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>"+\
"<!DOCTYPE macros SYSTEM \"http://www.4d.com/dtd/2007/macros.dtd\">"+\
"<macros>"+"<!-- *******************************TOOLS*******************************-->"+\
"<macro name=\"-\" in_menu=\"true\" type_ahead=\"false\"><text/></macro>"+""+\
"<macro name=\"Git Diff\""+" in_menu=\"true\""+" type_ahead=\"false\""+" version=\"2\">"+\
"<text><method>Macro_4DPop_GIT(\"<method_path/>\")</method></text>"+"</macro></macros>"

C_OBJECT:C1216($choujikuuYousai)
$choujikuuYousai:=macross($xmlText)
ASSERT:C1129($choujikuuYousai.macros.length=2)

C_OBJECT:C1216($file)
$file:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).file(Generate UUID:C1066+".xml")
$choujikuuYousai.exportToFile($file; XML no indentation:K45:36)

ASSERT:C1129($file.exists)

C_OBJECT:C1216($マクロス)
$マクロス:=macross($file)
ASSERT:C1129($マクロス.macros.length=2)

ASSERT:C1129($マクロス.macros.equal($choujikuuYousai.macros))

$rankaLee:=New object:C1471("name"; "Evaluate and replace/€"; "in_menu"; "true"; "type_ahead"; "false"; "version"; "2")
$rankaLee.text:="<text><method>Macro_evaluateAndReplace()</method></text>"
$マクロス:=macross(New collection:C1472($rankaLee))
$マクロス.export(XML no indentation:K45:36)

ASSERT:C1129($マクロス.macros.equal(macross().macros))

// clean
$file.delete()