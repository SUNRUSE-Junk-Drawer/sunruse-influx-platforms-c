module.exports = ->
	[
		module.exports.helpers.makeUnorderedBinary "equal", "int", "bool", ((a, b) -> a is b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") == (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "greater", "int", "bool", ((a, b) -> a > b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") > (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "less", "int", "bool", ((a, b) -> a < b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") < (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "greaterEqual", "int", "bool", ((a, b) -> a >= b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") >= (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "lessEqual", "int", "bool", ((a, b) -> a <= b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") <= (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"		
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"