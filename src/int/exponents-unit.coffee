describe "platforms", ->
	describe "javascript", ->
		describe "float", ->
			describe "exponents", ->
				exponents = undefined
				beforeEach ->
					exponents = require "./exponents"
				describe "imports", ->
					it "helpers", ->
						expect(exponents.helpers).toBe require "sunruse-influx-platforms-helpers"
					it "codeCache", ->
						expect(exponents.codeCache).toBe require "./../codeCache"
				describe "defines", ->
					codeCache = functions = unaries = unorderedBinaries = orderedBinaries = undefined
					beforeEach ->
						codeCache = exponents.codeCache
						
						unaries = {}
						orderedBinaries = {}
						unorderedBinaries = {}	
						
						helpers = exponents.helpers
						exponents.helpers = 
							makeUnary: (name) ->
								toReturn = helpers.makeUnary.apply this, arguments
								unaries[name] =
									args: (argument for argument in arguments) 
									result: toReturn
								return toReturn
	
							makeOrderedBinary: (name) ->
								toReturn = helpers.makeOrderedBinary.apply this, arguments
								orderedBinaries[name] = 
									args: (argument for argument in arguments)
									result: toReturn
								return toReturn
							
							makeUnorderedBinary: (name) ->
								toReturn = helpers.makeUnorderedBinary.apply this, arguments
								unorderedBinaries[name] = 
									args: (argument for argument in arguments)
									result: toReturn
								return toReturn	
														
						functions = exponents()
						exponents.helpers = helpers					
						
						exponents.codeCache = (platform, cache, value) ->
							expect(platform).toEqual "Test Platform"
							expect(cache).toEqual "Test Cache"
							switch value
								when "Test Input" then return "Test Code"
								when "Test Input A" then return "Test Code A"
								when "Test Input B" then return "Test Code B"
								else expect(false).toBeTruthy()
					afterEach ->
						exponents.codeCache = codeCache	
																															
					describe "exponentiate", ->
						it "is returned", ->
							exponentiate = (func for func in functions when func.name is "exponentiate")
							expect(exponentiate.length).toEqual 1
							expect(exponentiate[0]).toBe orderedBinaries.exponentiate.result
							expect orderedBinaries.exponentiate.args
								.toEqual ["exponentiate", "int", "int", (jasmine.any Function), (jasmine.any Function), "base", "exponent"]
						
						it "supports constant inputs", ->
							expect(orderedBinaries.exponentiate.args[3] 3, 7).toEqual 2187 													
							
						it "supports native code generation", ->				
							input = 
								properties:
									base: "Test Input A"
									exponent: "Test Input B"	
							expect orderedBinaries.exponentiate.args[4] "Test Platform", "Test Cache", input
								.toEqual "Math.pow(Test Code A, Test Code B)"		