# Macross ✈ 🤖

My macro utility class to edit or create macro

## build your macross

ie. create an object instance which contains a list of macros

```4d
$マクロス:=macross($input) // or macross()
```

with `$input` macro xml text, or a `File` or a collection of macro as objects.

> If no arg current database macro xml file will be parsed (file named Macros.xml, subject to change to be more flexible)

## read

```4d
$マクロス.macros // a collection of object
```

## edit

### add a new 

```4d
$rankaLee:=New object("name"; "Evaluate and replace/€"; "in_menu"; "true"; "type_ahead"; "false"; "version"; "2")
$rankaLee.text:="<text><method>Macro_evaluateAndReplace()</method></text>"

$マクロス.macros.push(rankaLee)
```

> text if not parsed for the moment

## export to xml file

### to origin file

```4d 
$マクロス.export()
```

> if not origin (if input is xml string or object collection, default component path will be used)

### to a specific `File`

```4d 
$マクロス.exportToFile($yourFile) // 4D.File
```

## user interface

This project contains also a form which could display and edit the `Macross` class in a simple list box.
