local xmlser = require ("xml-ser")

-- test case

local inner = {
  name = "foo",
  attr = {
    a = "1 > 3",
    b = 2
  },
  text = "you know, this & that"
--  cdata = true
}

local outer = {
  name = "outer",
  attr = {kupo="wark"},
  kids = {inner}
}

local xml =xmlser.serialize(outer)
local expected = [[<outer kupo="wark"><foo b="2" a="1 &gt; 3">you know, this &amp; that</foo></outer>]]
print( "PASS: ", assert(expected == xml) )