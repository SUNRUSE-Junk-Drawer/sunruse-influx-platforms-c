module.exports = ->
	[
		module.exports.helpers.makeUnary "negate", "int", "int", ((value) -> -value), (platform, cache, value) -> "-(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnorderedBinary "add", "int", "int", ((a, b) -> a + b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") + (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "subtract", "int", "int", ((a, b) -> a - b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") - (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeUnorderedBinary "multiply", "int", "int", ((a, b) -> a * b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") * (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		
		# Based on http://stackoverflow.com/a/29533500.
		module.exports.helpers.makeOrderedBinary "divide", "int", "int", ((a, b) -> Math.round(a / b)), (platform, cache, value) -> "((" + (module.exports.codeCache platform, cache, value.properties.a) + ") + ((" + (module.exports.codeCache platform, cache, value.properties.b) + ") / 2 * (((((" + (module.exports.codeCache platform, cache, value.properties.a) + ") ^ (" + (module.exports.codeCache platform, cache, value.properties.b) + ")) & 0x80000000) >> 31) * -2 + 1))) / (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		
		# Based on http://stackoverflow.com/a/4971565
		module.exports.helpers.makeOrderedBinary "divideDown", "int", "int", ((a, b) -> Math.floor(a / b)), (platform, cache, value) -> "((" + (module.exports.codeCache platform, cache, value.properties.a) + ") - 1) / (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "divideUp", "int", "int", ((a, b) -> Math.ceil(a / b)), (platform, cache, value) -> "((" + (module.exports.codeCache platform, cache, value.properties.a) + ") - 1) / (" + (module.exports.codeCache platform, cache, value.properties.b) + ") + 1"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"