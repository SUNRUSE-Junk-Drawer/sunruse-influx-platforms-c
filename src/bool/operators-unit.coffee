describe "platforms", ->
	describe "javascript", ->
		describe "bool", ->
			describe "operators", ->
				operators = undefined
				beforeEach ->
					operators = require "./operators"
				describe "imports", ->
					it "helpers", ->
						expect(operators.helpers).toBe require "sunruse-influx-platforms-helpers"
					it "codeCache", ->
						expect(operators.codeCache).toBe require "./../codeCache"
				describe "defines", ->
					codeCache = functions = unaries = unorderedBinaries = orderedBinaries = undefined
					beforeEach ->
						codeCache = operators.codeCache
						
						unaries = {}
						orderedBinaries = {}
						unorderedBinaries = {}	
						
						helpers = operators.helpers
						operators.helpers = 
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
					
						functions = operators()
						operators.helpers = helpers					
						
						operators.codeCache = (platform, cache, value) ->
							expect(platform).toEqual "Test Platform"
							expect(cache).toEqual "Test Cache"
							switch value
								when "Test Input" then return "Test Code"
								when "Test Input A" then return "Test Code A"
								when "Test Input B" then return "Test Code B"
								else expect(false).toBeTruthy()
					afterEach ->
						operators.codeCache = codeCache
					describe "and", ->
						it "is returned", ->
							_and = (func for func in functions when func.name is "and")
							expect(_and.length).toEqual 1
							expect(_and[0]).toBe unorderedBinaries.and.result
							expect unorderedBinaries.and.args
								.toEqual ["and", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs for false, false", ->
							expect(unorderedBinaries.and.args[3] false, false).toBe false  
							
						it "supports constant inputs for false, true", ->
							expect(unorderedBinaries.and.args[3] false, true).toBe false  
							
						it "supports constant inputs for true, false", ->
							expect(unorderedBinaries.and.args[3] true, false).toBe false  
							
						it "supports constant inputs for true, true", ->
							expect(unorderedBinaries.and.args[3] true, true).toBe true  																					
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.and.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) && (Test Code B)"
					describe "or", ->
						it "is returned", ->
							_or = (func for func in functions when func.name is "or")
							expect(_or.length).toEqual 1
							expect(_or[0]).toBe unorderedBinaries.or.result
							expect unorderedBinaries.or.args
								.toEqual ["or", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs for false, false", ->
							expect(unorderedBinaries.or.args[3] false, false).toBe false  
							
						it "supports constant inputs for true, false", ->
							expect(unorderedBinaries.or.args[3] true, false).toBe true
							
						it "supports constant inputs for false, true", ->
							expect(unorderedBinaries.or.args[3] false, true).toBe true  
							
						it "supports constant inputs for true, true", ->
							expect(unorderedBinaries.or.args[3] true, true).toBe true  														  
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.or.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) || (Test Code B)"
					describe "xor", ->
						it "is returned", ->
							xor = (func for func in functions when func.name is "xor")
							expect(xor.length).toEqual 1
							expect(xor[0]).toBe unorderedBinaries.xor.result
							expect unorderedBinaries.xor.args
								.toEqual ["xor", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs for false, false", ->
							expect(unorderedBinaries.xor.args[3] false, false).toBe false  
							
						it "supports constant inputs for true, false", ->
							expect(unorderedBinaries.xor.args[3] true, false).toBe true
							
						it "supports constant inputs for false, true", ->
							expect(unorderedBinaries.xor.args[3] false, true).toBe true  
							
						it "supports constant inputs for true, true", ->
							expect(unorderedBinaries.xor.args[3] true, true).toBe false  														  
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.xor.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) != (Test Code B)"
					describe "equal", ->
						it "is returned", ->
							equal = (func for func in functions when func.name is "equal")
							expect(equal.length).toEqual 1
							expect(equal[0]).toBe unorderedBinaries.equal.result
							expect unorderedBinaries.equal.args
								.toEqual ["equal", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs for false, false", ->
							expect(unorderedBinaries.equal.args[3] false, false).toBe true  
							
						it "supports constant inputs for true, false", ->
							expect(unorderedBinaries.equal.args[3] true, false).toBe false
							
						it "supports constant inputs for false, true", ->
							expect(unorderedBinaries.equal.args[3] false, true).toBe false  
							
						it "supports constant inputs for true, true", ->
							expect(unorderedBinaries.equal.args[3] true, true).toBe true  														  
							
						it "supports native code generation", ->				
							input = 
								properties:
									a: "Test Input A"
									b: "Test Input B"	
							expect unorderedBinaries.equal.args[4] "Test Platform", "Test Cache", input
								.toEqual "(Test Code A) == (Test Code B)"
					describe "not", ->
						it "is returned", ->
							_not = (func for func in functions when func.name is "not")
							expect(_not.length).toEqual 1
							expect(_not[0]).toBe unaries.not.result
							expect unaries.not.args
								.toEqual ["not", "bool", "bool", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs of false", ->
							expect(unaries.not.args[3] false).toBe true
						
						it "supports constant inputs of true", ->
							expect(unaries.not.args[3] true).toBe false
						
						it "supports native code generation", ->
							expect unaries.not.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "!(Test Code)"																		