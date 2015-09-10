module.exports = ->
	[
		module.exports.helpers.makeUnary "negate", "int", "int", ((value) -> -value), (platform, cache, value) -> "-(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnorderedBinary "add", "int", "int", ((a, b) -> a + b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") + (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "subtract", "int", "int", ((a, b) -> a - b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") - (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeUnorderedBinary "multiply", "int", "int", ((a, b) -> a * b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") * (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeOrderedBinary "divide", "int", "int", ((a, b) -> Math.round(a / b)), (platform, cache, value) -> "Math.round((" + (module.exports.codeCache platform, cache, value.properties.a) + ") / (" + (module.exports.codeCache platform, cache, value.properties.b) + "))"
		module.exports.helpers.makeOrderedBinary "divideDown", "int", "int", ((a, b) -> Math.floor(a / b)), (platform, cache, value) -> "Math.floor((" + (module.exports.codeCache platform, cache, value.properties.a) + ") / (" + (module.exports.codeCache platform, cache, value.properties.b) + "))"
		module.exports.helpers.makeOrderedBinary "divideUp", "int", "int", ((a, b) -> Math.ceil(a / b)), (platform, cache, value) -> "Math.ceil((" + (module.exports.codeCache platform, cache, value.properties.a) + ") / (" + (module.exports.codeCache platform, cache, value.properties.b) + "))"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"