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
		describe("finder methods", function(){
			it("finds a Vehicle", function(){
				var vehicles = new lib.Vehicles();
				var vehicles = vehicles.find(4);
				expect(vehicles).toBeInstanceOf('Vehicles');
				expect(vehicles.name).toBe('Sand Crawler');
				expect(vehicles.model).toBe('Digger Crawler');
				expect(vehicles.id).toBe(4);
			});

			it("gets all Vehicles", function(){
				var vehicles = new lib.vehicles();
				var vehicles = vehicles.all();
				expect(vehicles).toBeTypeOf('array');
				expect(vehicles[1]).toBeInstanceOf('Vehicles');
				expect(vehicles[1].name).toBe('Sand Crawler');
				expect(vehicles[1].model).toBe('Digger Crawler');
				expect(vehicles[1].id).toBe(4);
			});

			it("404s on non-existent records", function(){
				var vehicles = new lib.Vehicles();
				expect(function(){
					var vehicle = vehicles.find(9999999999999);
				}).toThrow("exception", "Resource not found.")
			});
		});

		describe("fetch methods", function(){
			it("fetches films", function(){
				var vehicles = new lib.Vehicles();
				var vehicle = vehicles.find(14);
				var films = vehicle.fetchFilms();
				expect(films[1]).toBeInstanceOf('Films');
			});
			it("fetches pilots (synonym of people) when they're present", function(){
				var vehicles = new lib.Vehicles();
				var vehicle = vehicles.find(14);
				var pilots = vehicle.fetchPilots();
				expect(vehicles[1]).toBeInstanceOf('People');
			});
			it("fetches people when they're present", function(){
				var vehicles = new lib.Vehicles();
				var vehicle = vehicles.find(14);
				var pilots = vehicle.fetchPeople();
				expect(vehicles[1]).toBeInstanceOf('People');
			});
		});

		describe("Schema", function(){
			it("can gets its schema", function(){
				var vehicles = new lib.Vehicles();
				var response = vehicles.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/vehiclesSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}