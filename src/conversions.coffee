module.exports = ->
	[
		module.exports.helpers.makeUnary "toFloat", "int", "float", ((value) -> value), (platform, cache, value) -> "(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "toInt", "float", "int", ((value) -> Math.round(value)), (platform, cache, value) -> "Math.round(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "toIntUp", "float", "int", ((value) -> Math.ceil(value)), (platform, cache, value) -> "Math.ceil(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "toIntDown", "float", "int", ((value) -> Math.floor(value)), (platform, cache, value) -> "Math.floor(" + (module.exports.codeCache platform, cache, value) + ")"
	]

module.exports.codeCache = require "./codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"