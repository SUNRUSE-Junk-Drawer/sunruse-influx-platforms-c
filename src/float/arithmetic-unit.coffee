describe "platforms", ->
	describe "javascript", ->
		describe "float", ->
			describe "arithmetic", ->
				arithmetic = undefined
				beforeEach ->
					arithmetic = require "./arithmetic"
				describe "imports", ->
					it "helpers", ->
						expect(arithmetic.helpers).toBe require "sunruse-influx-platforms-helpers"
					it "codeCache", ->
						expect(arithmetic.codeCache).toBe require "./../codeCache"
				describe "defines", ->
					codeCache = functions = unaries = unorderedBinaries = orderedBinaries = undefined
					beforeEach ->
						codeCache = arithmetic.codeCache
						
						unaries = {}
						orderedBinaries = {}
						unorderedBinaries = {}	
						
						helpers = arithmetic.helpers
						arithmetic.helpers = 
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
														
						functions = arithmetic()
						arithmetic.helpers = helpers					
						
						arithmetic.codeCache = (platform, cache, value) ->
							expect(platform).toEqual "Test Platform"
							expect(cache).toEqual "Test Cache"
							switch value
								when "Test Input" then return "Test Code"
								when "Test Input A" then return "Test Code A"
								when "Test Input B" then return "Test Code B"
								else expect(false).toBeTruthy()
					afterEach ->
						arithmetic.codeCache = codeCache
					describe "add", ->
						it "is returned", ->
							add = (func for func in functions when func.name is "add")
							expect(add.length).toEqual 1
							expect(add[0]).toBe unorderedBinaries.add.result
							expect unorderedBinaries.add.args
								.toEqual ["add", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(unorderedBinaries.add.args[3] 7.6, 5.2).toBeCloseTo 12.8  
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.add.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) + (Test Code B)"
					describe "subtract", ->
						it "is returned", ->
							subtract = (func for func in functions when func.name is "subtract")
							expect(subtract.length).toEqual 1
							expect(subtract[0]).toBe orderedBinaries.subtract.result
							expect orderedBinaries.subtract.args
								.toEqual ["subtract", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(orderedBinaries.subtract.args[3] 7.6, 5.2).toBeCloseTo 2.4 						
						
						it "supports native code generation", ->
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.subtract.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) - (Test Code B)"						
					describe "multiply", ->
						it "is returned", ->
							multiply = (func for func in functions when func.name is "add")
							expect(multiply.length).toEqual 1
							expect(multiply[0]).toBe unorderedBinaries.add.result
							expect unorderedBinaries.multiply.args
								.toEqual ["multiply", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(unorderedBinaries.multiply.args[3] 7.6, 5.2).toBeCloseTo 39.52
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.multiply.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) * (Test Code B)"
					describe "divide", ->
						it "is returned", ->
							divide = (func for func in functions when func.name is "divide")
							expect(divide.length).toEqual 1
							expect(divide[0]).toBe orderedBinaries.divide.result
							expect orderedBinaries.divide.args
								.toEqual ["divide", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(orderedBinaries.divide.args[3] 126.4704, 3.2).toBeCloseTo 39.522	
						
						it "supports native code generation", ->
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.divide.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) / (Test Code B)"												
					describe "negate", ->
						it "is returned", ->
							negate = (func for func in functions when func.name is "negate")
							expect(negate.length).toEqual 1
							expect(negate[0]).toBe unaries.negate.result
							expect unaries.negate.args
								.toEqual ["negate", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(unaries.negate.args[3] 65.3).toBeCloseTo -65.3
						
						it "supports native code generation", ->
							expect unaries.negate.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "-(Test Code)"																		
					describe "squareRoot", ->
						it "is returned", ->
							squareRoot = (func for func in functions when func.name is "squareRoot")
							expect(squareRoot.length).toEqual 1
							expect(squareRoot[0]).toBe unaries.squareRoot.result
							expect unaries.squareRoot.args
								.toEqual ["squareRoot", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(unaries.squareRoot.args[3] 12.25).toBeCloseTo 3.5
						
						it "supports native code generation", ->
							expect unaries.squareRoot.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "sqrtf(Test Code)"		
					describe "floor", ->
						it "is returned", ->
							floor = (func for func in functions when func.name is "floor")
							expect(floor.length).toEqual 1
							expect(floor[0]).toBe unaries.floor.result
							expect unaries.floor.args
								.toEqual ["floor", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports positive constant inputs", ->
							expect(unaries.floor.args[3] 12.25).toBeCloseTo 12
							
						it "supports zero constant inputs", ->
							expect(unaries.floor.args[3] 0.0).toBeCloseTo 0.0
							
						it "supports negative constant inputs", ->
							expect(unaries.floor.args[3] -12.25).toBeCloseTo -13
						
						it "supports native code generation", ->
							expect unaries.floor.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "floorf(Test Code)"																											
					describe "ceiling", ->
						it "is returned", ->
							ceiling = (func for func in functions when func.name is "ceiling")
							expect(ceiling.length).toEqual 1
							expect(ceiling[0]).toBe unaries.ceiling.result
							expect unaries.ceiling.args
								.toEqual ["ceiling", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports positive constant inputs", ->
							expect(unaries.ceiling.args[3] 12.25).toBeCloseTo 13
							
						it "supports zero constant inputs", ->
							expect(unaries.ceiling.args[3] 0.0).toBeCloseTo 0.0
							
						it "supports negative constant inputs", ->
							expect(unaries.ceiling.args[3] -12.25).toBeCloseTo -12
						
						it "supports native code generation", ->
							expect unaries.ceiling.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "ceilf(Test Code)"																											