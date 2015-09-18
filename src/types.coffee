module.exports = ->
	nativeFunctions:
		(require "./int/arithmetic")()
			.concat (require "./int/comparisons")()
			.concat (require "./int/exponents")()
			.concat (require "./float/arithmetic")()
			.concat (require "./float/comparisons")()
			.concat (require "./float/trigonometry")()
			.concat (require "./float/exponents")()
			.concat (require "./bool/operators")()
			.concat (require "./switches")()
			.concat (require "./conversions")()    
	primitives: 
		int:
			parse: (literal) ->
				if literal.match /^-?\d+$/ then return parseInt literal
			equal: (a, b) -> a == b
		float:
			parse: (literal) ->
				if literal.match /^-?\d+\.\d+$/ then return parseFloat literal
			equal: (a, b) -> a == b
		bool:
			parse: (literal) ->
				switch literal
					when "true" then return true
					when "false" then return false
			equal: (a, b) -> a == b
			assertionPass: true
	functions: []
	compile: (platform, input, output, options) ->
		if not options then throw
			reason: "optionsRequired"
			
		if not options.functionName then throw
			reason: "functionNameRequired"
		
		if not options.inputTypeName then throw
			reason: "inputTypeNameRequired"
		
		if not options.outputTypeName then throw
			reason: "outputTypeNameRequired"
		
		cache = module.exports.parameterCache input
		result = module.exports.resultGenerator platform, cache, output, options
		working = (cached.working for cached in cache when cached.working).join "\n"
		if working then working += "\n"
		result = options.outputTypeName + " " + options.functionName + "(const " + options.inputTypeName + " input) {\n" + working + "" + (result) + "\n}"
		result
		
module.exports.parameterCache = require "./parameterCache"
module.exports.resultGenerator = require "./resultGenerator"