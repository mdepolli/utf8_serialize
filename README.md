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

