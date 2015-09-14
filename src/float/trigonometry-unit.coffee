describe "platforms", ->
	describe "javascript", ->
		describe "float", ->
			describe "trigonometry", ->
				trigonometry = undefined
				beforeEach ->
					trigonometry = require "./trigonometry"
				describe "imports", ->
					it "helpers", ->
						expect(trigonometry.helpers).toBe require "sunruse-influx-platforms-helpers"
					it "codeCache", ->
						expect(trigonometry.codeCache).toBe require "./../codeCache"
				describe "defines", ->
					codeCache = functions = unaries = unorderedBinaries = orderedBinaries = undefined
					beforeEach ->
						codeCache = trigonometry.codeCache
						
						unaries = {}
						orderedBinaries = {}
						unorderedBinaries = {}	
						
						helpers = trigonometry.helpers
						trigonometry.helpers = 
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
														
						functions = trigonometry()
						trigonometry.helpers = helpers					
						
						trigonometry.codeCache = (platform, cache, value) ->
							expect(platform).toEqual "Test Platform"
							expect(cache).toEqual "Test Cache"
							switch value
								when "Test Input" then return "Test Code"
								when "Test Input A" then return "Test Code A"
								when "Test Input B" then return "Test Code B"
								else expect(false).toBeTruthy()
					afterEach ->
						trigonometry.codeCache = codeCache																										
					describe "sine", ->
						it "is returned", ->
							sine = (func for func in functions when func.name is "sine")
							expect(sine.length).toEqual 1
							expect(sine[0]).toBe unaries.sine.result
							expect unaries.sine.args
								.toEqual ["sine", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs of -405 degrees", ->
							expect(unaries.sine.args[3] -7.068583471).toBeCloseTo -0.707106781
						
						it "supports constant inputs of -360 degrees", ->
							expect(unaries.sine.args[3] -6.283185307).toBeCloseTo 0.0
						
						it "supports constant inputs of -315 degrees", ->
							expect(unaries.sine.args[3] -5.497787144).toBeCloseTo 0.707106781
						
						it "supports constant inputs of -270 degrees", ->
							expect(unaries.sine.args[3] -4.71238898).toBeCloseTo 1.0
						
						it "supports constant inputs of -225 degrees", ->
							expect(unaries.sine.args[3] -3.926990817).toBeCloseTo 0.707106781
						
						it "supports constant inputs of -180 degrees", ->
							expect(unaries.sine.args[3] -3.141592654).toBeCloseTo 0.0
						
						it "supports constant inputs of -135 degrees", ->
							expect(unaries.sine.args[3] -2.35619449).toBeCloseTo -0.707106781
						
						it "supports constant inputs of -90 degrees", ->
							expect(unaries.sine.args[3] -1.570796327).toBeCloseTo -1.0
						
						it "supports constant inputs of -45 degrees", ->
							expect(unaries.sine.args[3] -0.785398163).toBeCloseTo -0.707106781
						
						it "supports constant inputs of zero degrees", ->
							expect(unaries.sine.args[3] 0.0).toBeCloseTo 0.0
							
						it "supports constant inputs of 45 degrees", ->
							expect(unaries.sine.args[3] 0.785398163).toBeCloseTo 0.707106781
						
						it "supports constant inputs of 90 degrees", ->
							expect(unaries.sine.args[3] 1.570796327).toBeCloseTo 1.0
							
						it "supports constant inputs of 135 degrees", ->
							expect(unaries.sine.args[3] 2.35619449).toBeCloseTo 0.707106781
							
						it "supports constant inputs of 180 degrees", ->
							expect(unaries.sine.args[3] 3.141592654).toBeCloseTo 0.0
							
						it "supports constant inputs of 225 degrees", ->
							expect(unaries.sine.args[3] 3.926990817).toBeCloseTo -0.707106781
							
						it "supports constant inputs of 270 degrees", ->
							expect(unaries.sine.args[3] 4.71238898).toBeCloseTo -1.0
							
						it "supports constant inputs of 315 degrees", ->
							expect(unaries.sine.args[3] 5.497787144).toBeCloseTo -0.707106781
							
						it "supports constant inputs of 360 degrees", ->
							expect(unaries.sine.args[3] 6.283185307).toBeCloseTo 0.0
							
						it "supports constant inputs of 405 degrees", ->
							expect(unaries.sine.args[3] 7.068583471).toBeCloseTo 0.707106781
						
						it "supports native code generation", ->
							expect unaries.sine.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "Math.sin(Test Code)"			
					describe "cosine", ->
						it "is returned", ->
							cosine = (func for func in functions when func.name is "cosine")
							expect(cosine.length).toEqual 1
							expect(cosine[0]).toBe unaries.cosine.result
							expect unaries.cosine.args
								.toEqual ["cosine", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs of -405 degrees", ->
							expect(unaries.cosine.args[3] -7.068583471).toBeCloseTo 0.707106781
						
						it "supports constant inputs of -360 degrees", ->
							expect(unaries.cosine.args[3] -6.283185307).toBeCloseTo 1.0
						
						it "supports constant inputs of -315 degrees", ->
							expect(unaries.cosine.args[3] -5.497787144).toBeCloseTo 0.707106781
						
						it "supports constant inputs of -270 degrees", ->
							expect(unaries.cosine.args[3] -4.71238898).toBeCloseTo 0.0
						
						it "supports constant inputs of -225 degrees", ->
							expect(unaries.cosine.args[3] -3.926990817).toBeCloseTo -0.707106781
						
						it "supports constant inputs of -180 degrees", ->
							expect(unaries.cosine.args[3] -3.141592654).toBeCloseTo -1.0
						
						it "supports constant inputs of -135 degrees", ->
							expect(unaries.cosine.args[3] -2.35619449).toBeCloseTo -0.707106781
						
						it "supports constant inputs of -90 degrees", ->
							expect(unaries.cosine.args[3] -1.570796327).toBeCloseTo 0.0
						
						it "supports constant inputs of -45 degrees", ->
							expect(unaries.cosine.args[3] -0.785398163).toBeCloseTo 0.707106781
						
						it "supports constant inputs of zero degrees", ->
							expect(unaries.cosine.args[3] 0.0).toBeCloseTo 1.0
							
						it "supports constant inputs of 45 degrees", ->
							expect(unaries.cosine.args[3] 0.785398163).toBeCloseTo 0.707106781
						
						it "supports constant inputs of 90 degrees", ->
							expect(unaries.cosine.args[3] 1.570796327).toBeCloseTo 0.0
							
						it "supports constant inputs of 135 degrees", ->
							expect(unaries.cosine.args[3] 2.35619449).toBeCloseTo -0.707106781
							
						it "supports constant inputs of 180 degrees", ->
							expect(unaries.cosine.args[3] 3.141592654).toBeCloseTo -1.0
							
						it "supports constant inputs of 225 degrees", ->
							expect(unaries.cosine.args[3] 3.926990817).toBeCloseTo -0.707106781
							
						it "supports constant inputs of 270 degrees", ->
							expect(unaries.cosine.args[3] 4.71238898).toBeCloseTo 0.0
							
						it "supports constant inputs of 315 degrees", ->
							expect(unaries.cosine.args[3] 5.497787144).toBeCloseTo 0.707106781
							
						it "supports constant inputs of 360 degrees", ->
							expect(unaries.cosine.args[3] 6.283185307).toBeCloseTo 1.0
							
						it "supports constant inputs of 405 degrees", ->
							expect(unaries.cosine.args[3] 7.068583471).toBeCloseTo 0.707106781
						
						it "supports native code generation", ->
							expect unaries.cosine.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "Math.cos(Test Code)"			
								
					describe "tangent", ->
						it "is returned", ->
							tangent = (func for func in functions when func.name is "tangent")
							expect(tangent.length).toEqual 1
							expect(tangent[0]).toBe unaries.tangent.result
							expect unaries.tangent.args
								.toEqual ["tangent", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs of -405 degrees", ->
							expect(unaries.tangent.args[3] -7.068583471).toBeCloseTo -1.0
						
						it "supports constant inputs of -360 degrees", ->
							expect(unaries.tangent.args[3] -6.283185307).toBeCloseTo 0.0
						
						it "supports constant inputs of -225 degrees", ->
							expect(unaries.tangent.args[3] -3.926990817).toBeCloseTo -1.0
						
						it "supports constant inputs of -180 degrees", ->
							expect(unaries.tangent.args[3] -3.141592654).toBeCloseTo 0.0
						
						it "supports constant inputs of -45 degrees and -180 degrees", ->
							expect(unaries.tangent.args[3] -1.0).toBeCloseTo -1.557407725
						
						it "supports constant inputs of -45 degrees", ->
							expect(unaries.tangent.args[3] -0.785398163).toBeCloseTo -1.0
						
						it "supports constant inputs of zero degrees", ->
							expect(unaries.tangent.args[3] 0.0).toBeCloseTo 0.0
							
						it "supports constant inputs of 45 degrees", ->
							expect(unaries.tangent.args[3] 0.785398163).toBeCloseTo 1.0
						
						it "supports constant inputs of between 45 degrees and 180 degrees", ->
							expect(unaries.tangent.args[3] 1.0).toBeCloseTo 1.557407725
							
						it "supports constant inputs of 180 degrees", ->
							expect(unaries.tangent.args[3] 3.141592654).toBeCloseTo 0.0
							
						it "supports constant inputs of 225 degrees", ->
							expect(unaries.tangent.args[3] 3.926990817).toBeCloseTo 1.0
							
						it "supports constant inputs of between 225 and 360 degrees", ->
							expect(unaries.tangent.args[3] 4.5).toBeCloseTo 4.637332055
							
						xit "supports constant inputs of 360 degrees", ->
							expect(unaries.tangent.args[3] 6.283185307).toBeCloseTo 1.0
							
						xit "supports constant inputs of 405 degrees", ->
							expect(unaries.tangent.args[3] 7.068583471).toBeCloseTo 0.707106781
						
						it "supports native code generation", ->
							expect unaries.tangent.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "Math.tan(Test Code)"			
								
					describe "arcSine", ->
						it "is returned", ->
							arcSine = (func for func in functions when func.name is "arcSine")
							expect(arcSine.length).toEqual 1
							expect(arcSine[0]).toBe unaries.arcSine.result
							expect unaries.arcSine.args
								.toEqual ["arcSine", "float", "float", (jasmine.any Function), (jasmine.any Function)]
								
						it "supports constant inputs resolving to -90 degrees", ->
							expect(unaries.arcSine.args[3] -1.0).toBeCloseTo -1.570796327
							
						it "supports constant inputs resolving to -45 degrees", ->
							expect(unaries.arcSine.args[3] -0.707106781).toBeCloseTo -0.785398163
								
						it "supports constant inputs of zero", ->
							expect(unaries.arcSine.args[3] 0.0).toBeCloseTo 0.0
							
						it "supports constant inputs resolving to 45 degrees", ->
							expect(unaries.arcSine.args[3] 0.707106781).toBeCloseTo 0.785398163
							
						it "supports constant inputs resolving to 90 degrees", ->
							expect(unaries.arcSine.args[3] 1.0).toBeCloseTo 1.570796327
						
						it "supports native code generation", ->
							expect unaries.arcSine.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "Math.asin(Test Code)"
								
					describe "arcCosine", ->
						it "is returned", ->
							arcCosine = (func for func in functions when func.name is "arcCosine")
							expect(arcCosine.length).toEqual 1
							expect(arcCosine[0]).toBe unaries.arcCosine.result
							expect unaries.arcCosine.args
								.toEqual ["arcCosine", "float", "float", (jasmine.any Function), (jasmine.any Function)]
								
						it "supports constant inputs resolving to zero", ->
							expect(unaries.arcCosine.args[3] 1.0).toBeCloseTo 0.0
							
						it "supports constant inputs resolving to 45 degrees", ->
							expect(unaries.arcCosine.args[3] 0.707106781).toBeCloseTo 0.785398163
							
						it "supports constant inputs resolving to 90 degrees", ->
							expect(unaries.arcCosine.args[3] 0.0).toBeCloseTo 1.570796327
							
						it "supports constant inputs resolving to 135 degrees", ->
							expect(unaries.arcCosine.args[3] -0.707106781).toBeCloseTo 2.356194491
							
						it "supports constant inputs resolving to 180 degrees", ->
							expect(unaries.arcCosine.args[3] -1.0).toBeCloseTo 3.141592654
						
						it "supports native code generation", ->
							expect unaries.arcCosine.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "Math.acos(Test Code)"
								
					describe "arcTangent", ->
						it "is returned", ->
							arcTangent = (func for func in functions when func.name is "arcTangent")
							expect(arcTangent.length).toEqual 1
							expect(arcTangent[0]).toBe unaries.arcTangent.result
							expect unaries.arcTangent.args
								.toEqual ["arcTangent", "float", "float", (jasmine.any Function), (jasmine.any Function)]
						
						it "supports constant inputs resolving to -45 degrees and -180 degrees", ->
							expect(unaries.arcTangent.args[3] -1.557407725).toBeCloseTo -1.0
						
						it "supports constant inputs resolving to -45 degrees", ->
							expect(unaries.arcTangent.args[3] -1.0).toBeCloseTo -0.785398163
						
						it "supports constant inputs resolving to zero degrees", ->
							expect(unaries.arcTangent.args[3] 0.0).toBeCloseTo 0.0
							
						it "supports constant inputs resolving to 45 degrees", ->
							expect(unaries.arcTangent.args[3] 1.0).toBeCloseTo 0.785398163
						
						it "supports constant inputs resolving to between 45 degrees and 180 degrees", ->
							expect(unaries.arcTangent.args[3] 1.557407725).toBeCloseTo 1.0
						
						it "supports native code generation", ->
							expect unaries.arcTangent.args[4] "Test Platform", "Test Cache", "Test Input"
								.toEqual "Math.atan(Test Code)"		