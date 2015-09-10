module.exports = ->
	[
		module.exports.helpers.makeSwitch "int", (platform, cache, value) -> 
			"(" + (module.exports.codeCache platform, cache, value.properties.on) + ") ? (" + (module.exports.codeCache platform, cache, value.properties.b) + ") : (" + (module.exports.codeCache platform, cache, value.properties.a) + ")" 
		module.exports.helpers.makeSwitch "float", (platform, cache, value) -> 
			"(" + (module.exports.codeCache platform, cache, value.properties.on) + ") ? (" + (module.exports.codeCache platform, cache, value.properties.b) + ") : (" + (module.exports.codeCache platform, cache, value.properties.a) + ")"
		module.exports.helpers.makeSwitch "bool", (platform, cache, value) -> 
			"(" + (module.exports.codeCache platform, cache, value.properties.on) + ") ? (" + (module.exports.codeCache platform, cache, value.properties.b) + ") : (" + (module.exports.codeCache platform, cache, value.properties.a) + ")"						
	]
	
module.exports.helpers = require "sunruse-influx-platforms-helpers"
module.exports.codeCache = require "./codeCache"