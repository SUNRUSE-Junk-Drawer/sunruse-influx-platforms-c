module.exports = ->
	[
		module.exports.helpers.makeUnary "not", "bool", "bool", ((value) -> !value), (platform, cache, value) -> "!(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnorderedBinary "and", "bool", "bool", ((a, b) -> a and b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") && (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeUnorderedBinary "or", "bool", "bool", ((a, b) -> a or b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") || (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
		module.exports.helpers.makeUnorderedBinary "equal", "bool", "bool", ((a, b) -> a is b), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value.properties.a) + ") == (" + (module.exports.codeCache platform, cache, value.properties.b) + ")"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"