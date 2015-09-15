module.exports = ->
	[
		module.exports.helpers.makeOrderedBinary "exponentiate", "float", "float", ((base, exponent) -> Math.pow(base, exponent)), ((platform, cache, value) -> "Math.pow(" + (module.exports.codeCache platform, cache, value.properties.base) + ", " + (module.exports.codeCache platform, cache, value.properties.exponent) + ")"), "base", "exponent"
		
		module.exports.helpers.makeUnary "naturalLogarithm", "float", "float", ((value) -> Math.log(value)), (platform, cache, value) -> "Math.log(" + (module.exports.codeCache platform, cache, value) + ")"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"