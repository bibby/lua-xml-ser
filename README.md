lua-xml-ser
===========

A simple xml serializer for lua. MIT License.

----

## tldr;

If you need a xml serializer, all you need is `xml-ser`.

If you need just a parser, try [SLAXML][slax] or one of the many others.

If you need both, you can use `xml-serde`, but it requires SLAX and the small List/Stack module.

# xml-ser

There are a lot of xml parsers for lua, but when it comes to writers, the herd thins greatly. For my use case, I need two-way xml communication, so I need a reader and writer. And it'd be nice if they were easy to use, and consistent.

[SLAXML][slax] is a nice parser, but doesn't write. Instead of writing yet another parser, this lib uses SLAX to deserialize with a custom callback series that formats the result to the xmlser spec, allowing me to have consistent data structures for incoming and outgoing xml.

If, like me, you just need a serialier, you can add `xml-ser` by itself. The `xml-serde` module is a convenience wrapper for `xml-ser` for serialization and SLAX for deserialization.

## table spec

The table spec to describe an xml element is an associative array of a these known keys.

```
	"name" : string, required.
	The tag name of the element

	"attr" : table (associative, map, kv pairs), optional
	Tag attributes, ie {"type"="xmlser:xml"}

    -- one or none of
    {
        "kids" : table (list, array), optional
        Child elements, following this same spec
        
        "text" : string, optional
        tag data, escaped for you unless opt.noEscapeText is true
        
        "cdata" : string, optional
        use in place of text for tag data to have serialized as CDATA
    }
```

## Using the serializer

```
    xmlser = require("xml-ser")
	xmlser.serialize( xmlSpec [,options])
	-- or
	serde = require("xml-serde")
	serde.serialize( xmlSpec, [,options])
```

### Serializer options:

	"shortClosure" : Allow self closing tags
	Default = true

	"escapeText" : Safe-xml escaping on tag data.
	Not sure why you'd disable this.
	Default = true

	"escapeAttr" : Safe-xml escaping on tag attributes.
	Not sure why you'd disable this.
	Default = true
```

xml-serde
=========

For consistent serialization and deserialization, you can use `xml-serde`. The serialization component is covered above. For deserialization, the heavy lifting is done [SLAXML][slax], a pretty good parser. Using its custom callbacks, `xml-serde` marshals the data into the table spec format expected by `xml-ser`, so you get a consistent format going in and out.

SLAX has an optional `slaxdom.lua` file for DOM Handling that is not required by `xml-serde`, we need just `slaxml.lua`.

## Using the deserializer
```
    serde = require("xml-serde")
    local tableSpec = serde.deserialize( xmlString )
    -- print( tableSpec.name, #tableSpec.kids )
```

[slax]: https://github.com/Phrogz/SLAXML