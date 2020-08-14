# Macross ✈ 🤖

My macro utility class to edit or create macro

## build your macross

ie. create an object instance which contains a list of macros

```4d
var $マクロス: Object // name it as you want, here MaKuRoSu!

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

> text attribute is not parsed for the moment

## export to xml file

### to origin file

```4d 
$マクロス.export()
```

> if no origin file (ex: if the input is an xml string or an objects collection, default component path will be used)

### to a specific `File`

```4d 
$マクロス.exportToFile($yourFile) // 4D.File
```

## user interface

This project contains also a form which could display and edit the `Macross` class, a very simple list box.


## TODO

- [ ] simple macro to create and add a new macro by just typing method to call
