module.exports = ->
	[
		module.exports.helpers.makeOrderedBinary "exponentiate", "int", "int", ((base, exponent) -> Math.pow(base, exponent)), ((platform, cache, value) -> "(int)pow(" + (module.exports.codeCache platform, cache, value.properties.base) + ", " + (module.exports.codeCache platform, cache, value.properties.exponent) + ")"), "base", "exponent"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"