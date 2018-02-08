## ONIX 3.0 & 2.1 parser for Ruby

### Low level API
Whole structure is accessible through OnixBook::Parser object :

```ruby
parser = OnixBook::Parser.new()
parser.analyze("path_to_file.onix")
```
Now you can use variables `parser` to get all onix elements

Ruby elements variables are underscored, lowercase of ONIX tags (Product -> product, DescriptiveDetail -> descriptive_detail) and pluralized in case of array (ProductSupply -> product_supplies).

### High level API
High level methods give abstracted and simplified access to the most important data.
Usage :

```shell
onix_split.rb onix.xml
```
### Development

#### Running the tests

Launch this command:

```
rspec
```

### Contributors
TEA "The Ebook Alternative" : http://www.tea-ebook.com/
Bookmate : https://bookmate.com/
Immaterial : https://immateriel.fr/

### License
Copyright (C) 2018

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
