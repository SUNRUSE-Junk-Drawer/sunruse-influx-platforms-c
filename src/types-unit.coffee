describe "platforms", ->
	describe "javascript", ->
		types = undefined
		beforeEach ->
			types = require "./types"
		describe "imports", ->
			it "parameterCache", ->
				expect(types.parameterCache).toBe require "./parameterCache"
			it "resultGenerator", ->
				expect(types.resultGenerator).toBe require "./resultGenerator"
		describe "instance", ->
			platform = undefined
			beforeEach ->
				platform = types()
			describe "compile", ->
				parameterCache = resultGenerator = options = undefined
				beforeEach ->
					parameterCache = types.parameterCache
					resultGenerator = types.resultGenerator 
				afterEach ->
					types.parameterCache = parameterCache
					types.resultGenerator = resultGenerator
				describe "when no options to given", ->
					it "throws an exception", ->
						cache = undefined
						
						types.parameterCache = (input) ->
							fail()
							
						types.resultGenerator = (platform, _cache, output, options) ->
							fail()
						
						expect () -> platform.compile "Test Platform", "Test Input", "Test Output", options
							.toThrow
								reason: "optionsRequired"
						
				describe "when options are given", ->
					beforeEach ->
						options = 
							functionName: "testFunctionName"
							inputTypeName: "testInputTypeName"
							outputTypeName: "testOutputTypeName"
							
					describe "when functionName is not given", ->
						beforeEach ->
							delete options.functionName
						
						it "throws an exception", ->
							cache = undefined
							
							types.parameterCache = (input) ->
								fail()
								
							types.resultGenerator = (platform, _cache, output, options) ->
								fail()
							
							expect () -> platform.compile "Test Platform", "Test Input", "Test Output", options
								.toThrow
									reason: "functionNameRequired"
									
					describe "when inputTypeName is not given", ->
						beforeEach ->
							delete options.inputTypeName
						
						it "throws an exception", ->
							cache = undefined
							
							types.parameterCache = (input) ->
								fail()
								
							types.resultGenerator = (platform, _cache, output, options) ->
								fail()
							
							expect () -> platform.compile "Test Platform", "Test Input", "Test Output", options
								.toThrow
									reason: "inputTypeNameRequired"
									
					describe "when outputTypeName is not given", ->
						beforeEach ->
							delete options.outputTypeName
						
						it "throws an exception", ->
							cache = undefined
							
							types.parameterCache = (input) ->
								fail()
								
							types.resultGenerator = (platform, _cache, output, options) ->
								fail()
							
							expect () -> platform.compile "Test Platform", "Test Input", "Test Output", options
								.toThrow
									reason: "outputTypeNameRequired"
						
					describe "when all required options are given", ->
						it "generates and returns native code without working", ->
							cache = undefined
							
							types.parameterCache = (input) ->
								cache = [
										{}
									,
										{}
									,
										{}
									,
										{}
									,
										{}
								]
							
							types.resultGenerator = (platform, _cache, output) ->
								expect(platform).toEqual "Test Platform"
								expect(_cache).toBe cache 
								expect(output).toEqual "Test Output"
								cache.push {}
								cache.push {}
								cache.push {}
								cache.push {}
								cache.push {}																								
								"""
									Test Return Line A
									Test Return Line B
								"""
							
							result = platform.compile "Test Platform", "Test Input", "Test Output", options
							
							expect(result).toEqual 	"""
								testOutputTypeName testFunctionName(const testInputTypeName input) {
								Test Return Line A
								Test Return Line B
								}
													"""
						it "generates and returns native code with working", ->
							cache = undefined
							
							types.parameterCache = (input) ->
								cache = [
										{}
									,
										{}
									,
										working: "Test Pre-Existing Working A"
									,
										working: "Test Pre-Existing Working B"
									,
										{}
								]
							
							types.resultGenerator = (platform, _cache, output, options) ->
								expect(platform).toEqual "Test Platform"
								expect(_cache).toBe cache 
								expect(output).toEqual "Test Output"
								cache.push
									working: "Test Working A"
								cache.push
									working: "Test Working B"
								cache.push {}
								cache.push
									working: "Test Working C"
								cache.push {}																								
								"""
									Test Return Line A
									Test Return Line B
								"""
							
							result = platform.compile "Test Platform", "Test Input", "Test Output", options
							
							expect(result).toEqual 	"""
								testOutputTypeName testFunctionName(const testInputTypeName input) {
								Test Pre-Existing Working A
								Test Pre-Existing Working B
								Test Working A
								Test Working B
								Test Working C
								Test Return Line A
								Test Return Line B
								}
													"""