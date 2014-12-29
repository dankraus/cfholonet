component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		variables.base = new lib.Base();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

/*********************************** BDD SUITES ***********************************/

	function run(){
		// describe("Basic HTTP functions", function(){
		// 	it("can get SWAPI Resource", function(){
		// 		var response = variables.base.getResource('people', 1);
		// 		expect(response).toBeTypeOf('struct');
		// 		expect(response["name"]).toBe("Luke Skywalker");
		// 	});

		// 	it("can get the JSON schema for a resource", function(){
		// 		var response = variables.base.getSchema('people', 1);
		// 		var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/peopleSchema.json");
		// 		expect(response).toBeTypeOf('struct');
		// 		expect(response).toBe(deserializeJSON(schemaJSON));
		// 	});

		// 	it("throws a not found error when getting a resource that can't be found", function(){
		// 		expect(function(){
		// 			variables.base.getResource(resource = 'people', uri = "http://swapi.co/api/people/somethingmadeup");
		// 		}).toThrow("exception", "Resource not found");
		// 	});

		// 	it("throws an invalid response error when getting a resource that isn't JSON", function(){
		// 		expect(function(){
		// 			variables.base.getResource(resource = 'people', uri = "http://swapi.co/");
		// 		}).toThrow("exception", "Response is not valid JSON");
		// 	});
		// });
	}

}
