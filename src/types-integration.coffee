describe "platforms", ->
	describe "javascript", ->
		libraries = require "./../../sunruse-influx-libraries/index"
		libraries.selfTest (require "./types")()