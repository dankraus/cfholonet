component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		addMatchers( {
			toBePresent : function( expectation, args={} ){ return len(expectation) gte 0; }
		} );

	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

/*********************************** BDD SUITES ***********************************/

	function run(){
		// describe("Init", function(){
		// 	it('inits with a numeric id', function(){
		// 		var vehicle = new lib.Vehicle(4);
		// 		expect(vehicle).toBeInstanceOf('Vehicle');
		// 	});

		// 	it('inits with a uri', function(){
		// 		var vehicle = new lib.Vehicle(uri='http://swapi.co/api/vehicles/4');
		// 		expect(vehicle).toBeInstanceOf('Vehicle');
		// 	});

		// 	it('throws error without an id or uri', function(){
		// 		expect(function(){ new lib.Vehicle() }).toThrow("exception", "Requires numeric id for resource or complete resource URI string");
		// 	});
		// });

		// describe("Populates model properties", function(){
		// 	var vehicle = new lib.Vehicle(4);
		// 	it("can get its name", function(){
		// 		expect(vehicle.name).toBePresent();
		// 	});
		// 	it("can get its model", function(){
		// 		expect(vehicle.model).toBePresent();
		// 	});
		// 	it("can get its manufacturer", function(){
		// 		expect(vehicle.manufacturer).toBePresent();
		// 	});
		// 	it("can get its costInCredits", function(){
		// 		expect(vehicle.costInCredits).toBePresent();
		// 	});
		// 	it("can get its length", function(){
		// 		expect(vehicle.length).toBePresent();
		// 	});
		// 	it("can get its maxAtmospheringSpeed", function(){
		// 		expect(vehicle.maxAtmospheringSpeed).toBePresent();
		// 	});
		// 	it("can get its crew", function(){
		// 		expect(vehicle.crew).toBePresent();
		// 	});
		// 	it("can get its passengers", function(){
		// 		expect(vehicle.passengers).toBePresent();
		// 	});
		// 	it("can get its cargoCapacity", function(){
		// 		expect(vehicle.cargoCapacity).toBePresent();
		// 	});
		// 	it("can get its consumables", function(){
		// 		expect(vehicle.consumables).toBePresent();
		// 	});
		// 	it("can get its vehicleClass", function(){
		// 		expect(vehicle.vehicleClass).toBePresent();
		// 	});
		// 	it("can get its url", function(){
		// 		expect(vehicle.url).toBePresent();
		// 	});
		// 	it("can get its created", function(){
		// 		expect(vehicle.created).toBePresent();
		// 	});
		// 	it("can get its edited", function(){
		// 		expect(vehicle.edited).toBePresent();
		// 	});
		// });

		// describe("Gets associated resources", function(){
		// 	it("gets films", function(){
		// 		var vehicle = new lib.Vehicle(4);
		// 		var films = vehicle.getFilms();
		// 		expect(films).toBeTypeOf('array');
		// 		expect(films[1]).toBeInstanceOf('Film');
		// 	});
		// 	it("gets pilots", function(){
		// 		//14 has pilots (Snowspeeder)
		// 		var vehicle = new lib.Vehicle(14);
		// 		var pilots = vehicle.getPilots();
		// 		expect(pilots).toBeTypeOf('array');
		// 		expect(pilots[1]).toBeInstanceOf('Person');
		// 	});
		// });

		// describe("Schema", function(){
		// 	it("gets its schema", function(){
		// 		var person = new lib.Vehicle(4);
		// 		var response = person.getSchema();
		// 		var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/vehiclesSchema.json");

		// 		expect(response).toBeTypeOf('struct');
		// 		expect(response).toBe(deserializeJSON(schemaJSON));
		// 	});
		// });
	}

}