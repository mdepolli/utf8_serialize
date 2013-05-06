# UTF8 Serialize

## Backstory

Read this: http://blog.rayapps.com/2013/03/11/7-things-that-can-go-wrong-with-ruby-19-string-encodings/

In short, On MRI 1.8:

```
YAML.dump({:name => "ace āčē"})
# => "--- \n:name: !binary |\n  YWNlIMSBxI3Ekw==\n\n"
```

When using MRI 1.9:

```
y = YAML.load("--- \n:name: !binary |\n  YWNlIMSBxI3Ekw==\n\n")
# => {:name=>"ace \xC4\x81\xC4\x8D\xC4\x93"}
y[:name].encoding
# => #<Encoding:ASCII-8BIT>
```

Causing no end of problems.  What we want:

```
y[:name].force_encoding('UTF-8')
# => "ace āčē"
```

## How to use

In lieu of `serialize :column_name, Hash` use `utf8_serialize :column_name, Hash`

Detects based on the presence of 'binary' definitions in the raw YAML, but it should not interfere with binary data that is not text based.

## Dependencies

* Ruby 1.9 (UTF-8 encoding is what started this all)
* ActiveRecord 3.2 (Could work with less, but I'm not sure)

## License

Copyright (C) 2013 Drew Blas <drew.blas@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## References

* http://blog.rayapps.com/2013/03/11/7-things-that-can-go-wrong-with-ruby-19-string-encodings/
* http://stackoverflow.com/questions/8558101/rails-encoding-woes-with-serialized-hashes-despite-utf8
* https://github.com/rails/rails/issues/4657
* http://stackoverflow.com/questions/1989348/ruby-1-9-yaml-and-string-encodings-how-to-lead-a-life-of-sanity
* http://stackoverflow.com/questions/10166340/how-do-i-get-yaml-in-ruby-as-of-1-9-3-to-dump-ascii-8bit-strings-as-strings
