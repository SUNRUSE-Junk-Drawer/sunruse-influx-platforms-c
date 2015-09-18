A platform implementation for SUNRUSE.influx which generates C(99) source code.  The generated code assumes that the input to the compiled function is accessible via "input", and any properties are nested structs.  Here is a typical example:

    helloWorld
	    output 
			test1 input a b
			test2 true
			nesting
				test3 false
				test4 5.7
				test5 3
				
This compiles to:

    {
		.test1 = input.a.b,
		.test2 = true,
		.nested = {
			.test3 = false,
			.test4 = 5.7,
			.test5 = 3
		}
	};
	
You can therefore use the generated source code by creating the input/output types as structs, creating the function header/footer and including the generated code using the preprocessor:

	struct bWrapper {
		int b;
	};

	struct functionInput {
		bWrapper a;
	};

	struct nestedFunctionOutput {
		bool test3;
		float test4;
		int test5;
	};

	struct functionOutput {
		int test1;
		bool test2;
		nestedFunctionOutput nested;
	};

	functionOutput helloWorld(functionInput input) {
		return (functionOutput) #include "path/to/generated/code.c"
	}