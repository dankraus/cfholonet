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
			it("finds a planet", function(){
				var planets = new lib.Planets();
				var planet = planets.find(1);
				expect(planet).toBeInstanceOf('Planets');
				expect(planet.name).toBe('Tatooine');
				expect(planet.id).toBe(1);
			});

			it("gets all planets", function(){
				var planets = new lib.Planets();
				var planets = planets.all();
				expect(planets).toBeTypeOf('array');
				expect(planets[1]).toBeInstanceOf('Planets');
				expect(planets[1].name).toBe('Tatooine');
				expect(planets[1].id).toBe(1);
			});

			it("404s on non-existent records", function(){
				var planets = new lib.Planets();
				expect(function(){
					var planet = planets.find(9999999999999);
				}).toThrow("exception", "Resource not found.")
			});
		});

		describe("fetch methods", function(){
			it("fetches films", function(){
				var planets = new lib.Planets();
				var planet = planets.find(1);
				var films = planet.fetchFilms();

				expect(films[1]).toBeInstanceOf('Films');
			});
			it("fetches residents (synonym of people) when they're present", function(){
				var planets = new lib.Planets();
				var planet = planets.find(1);
				var residents = planet.fetchResidents();
				expect(residents[1]).toBeInstanceOf('People');
			});
			it("fetches people  when they're present", function(){
				var planets = new lib.Planets();
				var planet = planets.find(1);
				var residents = planet.fetchResidents();
				expect(residents[1]).toBeInstanceOf('People');
			});
		});

		describe("Schema", function(){
			it("can gets its schema", function(){
				var vehicles = new lib.Vehicles();
				var response = vehicles.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/planetsSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}