describe "platforms", ->
	describe "javascript", ->
		describe "switches", ->
			switches = undefined
			beforeEach ->
				switches = require "./switches"
			describe "imports", ->
				it "helpers", ->
					expect(switches.helpers).toBe require "sunruse-influx-platforms-helpers"
				it "codeCache", ->
					expect(switches.codeCache).toBe require "./codeCache"
			describe "defines", ->
				codeCache = functions = helpers = created = undefined
				beforeEach ->
					helpers = switches.helpers
					codeCache = switches.codeCache
					created = {}
					switches.helpers = 
						makeSwitch: (name) ->
							toReturn = helpers.makeSwitch.apply this, arguments
							created[name] =
								args: (argument for argument in arguments) 
								result: toReturn
							return toReturn
					functions = switches()
					switches.helpers = helpers						
					
					switches.codeCache = (platform, cache, value) ->
						expect(platform).toEqual "Test Platform"
						expect(cache).toEqual "Test Cache"
						switch value
							when "Test Input On" then return "Test Code On"
							when "Test Input A" then return "Test Code A"
							when "Test Input B" then return "Test Code B"
							else expect(false).toBeTruthy()
				afterEach ->
					switches.codeCache = codeCache
				describe "int", ->
					it "is returned", ->
						int = (func for func in functions when func.output is "int")
						expect(int.length).toEqual 1
						expect(int[0]).toBe created.int.result
						expect created.int.args
							.toEqual ["int", (jasmine.any Function)]																					
						
					it "supports native code generation", ->				
						input = 
							properties:
								a: "Test Input A"
								b: "Test Input B"
								on: "Test Input On"		
						expect created.int.args[1] "Test Platform", "Test Cache", input
							.toEqual "(Test Code On) ? (Test Code B) : (Test Code A)"
				describe "float", ->
					it "is returned", ->
						float = (func for func in functions when func.output is "float")
						expect(float.length).toEqual 1
						expect(float[0]).toBe created.float.result
						expect created.float.args
							.toEqual ["float", (jasmine.any Function)]																					
						
					it "supports native code generation", ->				
						input = 
							properties:
								a: "Test Input A"
								b: "Test Input B"
								on: "Test Input On"		
						expect created.float.args[1] "Test Platform", "Test Cache", input
							.toEqual "(Test Code On) ? (Test Code B) : (Test Code A)"
							
				describe "bool", ->
					it "is returned", ->
						bool = (func for func in functions when func.output is "bool")
						expect(bool.length).toEqual 1
						expect(bool[0]).toBe created.bool.result
						expect created.bool.args
							.toEqual ["bool", (jasmine.any Function)]																					
						
					it "supports native code generation", ->				
						input = 
							properties:
								a: "Test Input A"
								b: "Test Input B"
								on: "Test Input On"		
						expect created.bool.args[1] "Test Platform", "Test Cache", input
							.toEqual "(Test Code On) ? (Test Code B) : (Test Code A)"							