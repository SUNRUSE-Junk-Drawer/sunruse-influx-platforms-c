module.exports = ->
	[
		module.exports.helpers.makeUnorderedBinary "equal", "float", "bool", ((a, b) -> a is b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") == (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "greater", "float", "bool", ((a, b) -> a > b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") > (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "less", "float", "bool", ((a, b) -> a < b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") < (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "greaterEqual", "float", "bool", ((a, b) -> a >= b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") >= (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "lessEqual", "float", "bool", ((a, b) -> a <= b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") <= (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"		
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"