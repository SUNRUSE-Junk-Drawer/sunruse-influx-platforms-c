A platform implementation for SUNRUSE.influx which generates JavaScript source code.  The generated code assumes that the input to the compiled function is accessible via "input", and any properties are nested objects.  Here is a typical example:

    helloWorld
	    output 
			test1 input a b
			test2 true
			nesting
				test3 false
				test4 5.7
				test5 3
				
This compiles to:

    return {
		test1: input.a.b,
		test2: true,
		nesting: {
			test3: false,
			test4: 5.7,
			test5: 3
		}
	};
	
You can therefore use the generated source code directly from the result string by creating a new JavaScript Function object:

    var func = new Function("input", code);
	
	var result = func({
			a: {
				b: 78749
			}
		});
		
	console.log(result.test1); // 78749
	console.log(result.test2); // true
	console.log(result.nesting.test3); // false
	console.log(result.nesting.test4); // 5.7
	console.log(result.nesting.test5); // 3