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
			var planets = new lib.Planets();
			var planet = planets.find(1);

			it("fetches films", function(){
				var films = planet.fetchFilms();
				expect(films[1]).toBeInstanceOf('Films');
			});
			it("fetches residents (synonym of people) when they're present from an array of people uris", function(){
				var residents = planet.fetchResidents();
				expect(residents[1]).toBeInstanceOf('People');
			});

			it("it errors when fetching something that doesn't exist", function(){
				expect(function(){
					var planets = planets.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "Method not found.")
			});

			it("fetches url, a uri to load", function(){
				var theSameplanet = planets.fetchURL();

				expect(theSameplanet).toBeInstanceOf('planets');
			});

			it("it errors when trying to fetch something that doesn't exist", function(){
				expect(function(){
					planet.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "There is no resource 'FoobarGoblledyGuck' to fetch.")
			});

			it("it errors when trying to fetch something that isn't a uri", function(){
				expect(function(){
					planet.fetchName();
				}).toThrow("exception", "Title is not a valid uri to fetch for.")
			});

			it("it errors when a method doesn't exist", function(){
				expect(function(){
					planet.SomeJunkIMadeUpThatDoesntExist();
				}).toThrow("exception", "There is no method with the name SomeJunkIMadeUpThatDoesntExist")
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