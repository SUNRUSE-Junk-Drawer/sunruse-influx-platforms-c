module.exports = ->
	[
		module.exports.helpers.makeUnary "sine", "float", "float", ((value) -> Math.sin(value)), (platform, cache, value) -> "Math.sin(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "cosine", "float", "float", ((value) -> Math.cos(value)), (platform, cache, value) -> "Math.cos(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "tangent", "float", "float", ((value) -> Math.tan(value)), (platform, cache, value) -> "Math.tan(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "arcSine", "float", "float", ((value) -> Math.asin(value)), (platform, cache, value) -> "Math.asin(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "arcCosine", "float", "float", ((value) -> Math.acos(value)), (platform, cache, value) -> "Math.acos(" + (module.exports.codeCache platform, cache, value) + ")"
		module.exports.helpers.makeUnary "arcTangent", "float", "float", ((value) -> Math.atan(value)), (platform, cache, value) -> "Math.atan(" + (module.exports.codeCache platform, cache, value) + ")"
	]

module.exports.codeCache = require "./../codeCache"
module.exports.helpers = require "sunruse-influx-platforms-helpers"