describe "platforms", ->
	describe "javascript", ->
		libraries = require "sunruse-influx-libraries"
		libraries.selfTest (require "./types")()