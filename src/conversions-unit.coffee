describe "platforms", ->
	describe "javascript", ->
		describe "conversions", ->
			conversions = undefined
			beforeEach ->
				conversions = require "./conversions"
			describe "imports", ->
				it "helpers", ->
					expect(conversions.helpers).toBe require "sunruse-influx-platforms-helpers"
				it "codeCache", ->
					expect(conversions.codeCache).toBe require "./codeCache"
			describe "defines", ->
				codeCache = functions = unaries = unorderedBinaries = orderedBinaries = undefined
				beforeEach ->
					codeCache = conversions.codeCache
					
					unaries = {}
					orderedBinaries = {}
					unorderedBinaries = {}	
					
					helpers = conversions.helpers
					conversions.helpers = 
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
													
					functions = conversions()
					conversions.helpers = helpers						
					
					conversions.codeCache = (platform, cache, value) ->
						expect(platform).toEqual "Test Platform"
						expect(cache).toEqual "Test Cache"
						switch value
							when "Test Input" then return "Test Code"
							when "Test Input A" then return "Test Code A"
							when "Test Input B" then return "Test Code B"
							else expect(false).toBeTruthy()
				afterEach ->
					conversions.codeCache = codeCache
				describe "toFloat", ->
					it "is returned", ->
						toFloat = (func for func in functions when func.name is "toFloat")
						expect(toFloat.length).toEqual 1
						expect(toFloat[0]).toBe unaries.toFloat.result
						expect unaries.toFloat.args
							.toEqual ["toFloat", "int", "float", (jasmine.any Function), (jasmine.any Function)]
					
					it "supports constant inputs", ->
						expect(unaries.toFloat.args[3] 65).toEqual 65.0
					
					it "supports native code generation", ->
						expect unaries.toFloat.args[4] "Test Platform", "Test Cache", "Test Input"
							.toEqual "(Test Code)"																		
							
				describe "toInt", ->
					it "is returned", ->
						toInt = (func for func in functions when func.name is "toInt")
						expect(toInt.length).toEqual 1
						expect(toInt[0]).toBe unaries.toInt.result
						expect unaries.toInt.args
							.toEqual ["toInt", "float", "int", (jasmine.any Function), (jasmine.any Function)]
					
					it "supports constant inputs of zero", ->
						expect(unaries.toInt.args[3] 0.0).toEqual 0
					
					it "supports positive constant inputs which round down", ->
						expect(unaries.toInt.args[3] 35.2).toEqual 35
					
					it "supports positive constant inputs which round up", ->
						expect(unaries.toInt.args[3] 35.7).toEqual 36
					
					it "supports negative constant inputs which round down", ->
						expect(unaries.toInt.args[3] -35.8).toEqual -36
					
					it "supports negative constant inputs which round up", ->
						expect(unaries.toInt.args[3] -35.2).toEqual -35
					
					it "supports native code generation", ->
						expect unaries.toInt.args[4] "Test Platform", "Test Cache", "Test Input"
							.toEqual "Math.round(Test Code)"																		
							
				describe "toIntUp", ->
					it "is returned", ->
						toIntUp = (func for func in functions when func.name is "toIntUp")
						expect(toIntUp.length).toEqual 1
						expect(toIntUp[0]).toBe unaries.toIntUp.result
						expect unaries.toIntUp.args
							.toEqual ["toIntUp", "float", "int", (jasmine.any Function), (jasmine.any Function)]
					
					it "supports constant inputs of zero", ->
						expect(unaries.toIntUp.args[3] 0.0).toEqual 0
					
					it "supports positive constant inputs which round up", ->
						expect(unaries.toIntUp.args[3] 35.2).toEqual 36
					
					it "supports positive constant inputs which round up", ->
						expect(unaries.toIntUp.args[3] 35.7).toEqual 36
					
					it "supports negative constant inputs which round up", ->
						expect(unaries.toIntUp.args[3] -35.8).toEqual -35
					
					it "supports negative constant inputs which round up", ->
						expect(unaries.toIntUp.args[3] -35.2).toEqual -35
					
					it "supports native code generation", ->
						expect unaries.toIntUp.args[4] "Test Platform", "Test Cache", "Test Input"
							.toEqual "Math.ceil(Test Code)"				
							
				describe "toIntDown", ->
					it "is returned", ->
						toIntDown = (func for func in functions when func.name is "toIntDown")
						expect(toIntDown.length).toEqual 1
						expect(toIntDown[0]).toBe unaries.toIntDown.result
						expect unaries.toIntDown.args
							.toEqual ["toIntDown", "float", "int", (jasmine.any Function), (jasmine.any Function)]
					
					it "supports constant inputs of zero", ->
						expect(unaries.toIntDown.args[3] 0.0).toEqual 0
					
					it "supports positive constant inputs which round down", ->
						expect(unaries.toIntDown.args[3] 35.2).toEqual 35
					
					it "supports positive constant inputs which round down", ->
						expect(unaries.toIntDown.args[3] 35.7).toEqual 35
					
					it "supports negative constant inputs which round down", ->
						expect(unaries.toIntDown.args[3] -35.8).toEqual -36
					
					it "supports negative constant inputs which round down", ->
						expect(unaries.toIntDown.args[3] -35.2).toEqual -36
					
					it "supports native code generation", ->
						expect unaries.toIntDown.args[4] "Test Platform", "Test Cache", "Test Input"
							.toEqual "Math.floor(Test Code)"																	