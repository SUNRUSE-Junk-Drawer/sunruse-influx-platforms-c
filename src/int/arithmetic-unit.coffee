describe "platforms", ->
	describe "javascript", ->
		describe "int", ->
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
								.toEqual ["add", "int", "int", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(unorderedBinaries.add.args[3] 7, 8).toEqual 15 
							
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
								.toEqual ["subtract", "int", "int", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(orderedBinaries.subtract.args[3] 7, 8).toEqual -1 						
						
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
								.toEqual ["multiply", "int", "int", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(unorderedBinaries.multiply.args[3] 7, 8).toEqual 56 
							
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
								.toEqual ["divide", "int", "int", (jasmine.any Function), (jasmine.any Function)]

						it "supports constant inputs rounding down", ->
							expect(orderedBinaries.divide.args[3] 64, 3).toEqual 21	
						
						it "supports constant inputs rounding up", ->
							expect(orderedBinaries.divide.args[3] 65, 3).toEqual 22	
						
						it "supports native code generation", ->
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.divide.args[4] "Test Platform", "Test Cache", input
								.toEqual "Math.round((Test Code A) / (Test Code B))"											

					describe "divideDown", ->
						it "is returned", ->
							divideDown = (func for func in functions when func.name is "divideDown")
							expect(divideDown.length).toEqual 1
							expect(divideDown[0]).toBe orderedBinaries.divideDown.result
							expect orderedBinaries.divideDown.args
								.toEqual ["divideDown", "int", "int", (jasmine.any Function), (jasmine.any Function)]

						it "supports constant inputs rounding down", ->
							expect(orderedBinaries.divideDown.args[3] 64, 3).toEqual 21	
						
						it "supports constant inputs rounding up", ->
							expect(orderedBinaries.divideDown.args[3] 65, 3).toEqual 21
						
						it "supports native code generation", ->
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.divideDown.args[4] "Test Platform", "Test Cache", input
								.toEqual "Math.floor((Test Code A) / (Test Code B))"											
								
					describe "divideUp", ->
						it "is returned", ->
							divideUp = (func for func in functions when func.name is "divideUp")
							expect(divideUp.length).toEqual 1
							expect(divideUp[0]).toBe orderedBinaries.divideUp.result
							expect orderedBinaries.divideUp.args
								.toEqual ["divideUp", "int", "int", (jasmine.any Function), (jasmine.any Function)]

						it "supports constant inputs rounding down", ->
							expect(orderedBinaries.divideUp.args[3] 64, 3).toEqual 22
						
						it "supports constant inputs rounding up", ->
							expect(orderedBinaries.divideUp.args[3] 65, 3).toEqual 22
						
						it "supports native code generation", ->
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect orderedBinaries.divideUp.args[4] "Test Platform", "Test Cache", input
								.toEqual "Math.ceil((Test Code A) / (Test Code B))"											
									
					describe "negate", ->
						it "is returned", ->
							negate = (func for func in functions when func.name is "negate")
							expect(negate.length).toEqual 1
							expect(negate[0]).toBe unaries.negate.result
							expect unaries.negate.args
								.toEqual ["negate", "int", "int", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs", ->
							expect(unaries.negate.args[3] 65).toEqual -65
						
						it "supports native code generation", ->
							expect unaries.negate.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "-(Test Code)"																		