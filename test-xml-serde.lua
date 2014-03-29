local serde = require("xml-serde")

local defaultOpts = {
	[[
	<a/>
	]],
	[[
	<data foo="bar" type="things">
		<datum id="1" x="3">some value</datum>
		<datum id="2" x="1 &gt; 2">escape &amp; pass</datum>
	</data>
	]] -- will sometimes pass, but sometimes fail. Attributes appear in nondeterministic order
}

function runTests( tests, options)
	local transforms = {"\t","\n","^%s+", "%s+$"}

	for i,xml in ipairs(tests) do
		print("test #", i)

		-- trim xml
		for _,t in ipairs(transforms) do
			xml = xml:gsub(t,"")
		end

		print("> IN : ", xml)
		local deser = serde.deserialize(xml)
		local reser = serde.serialize(deser, options)
		print("< OUT: ", reser)

		print(" PASS: ", assert(reser == xml), "\n")
	end
end

runTests(defaultOpts)
