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
			it("finds a Species", function(){
				var species = new lib.species();
				var species = species.find(1);
				expect(species).toBeInstanceOf('Species');
				expect(species.name).toBe('Human');
				expect(species.designation).toBe('Sentient');
				expect(species.id).toBe(1);
			});

			it("gets all species", function(){
				var species = new lib.Species();
				var species = species.all();
				expect(species).toBeTypeOf('array');
				expect(species[1]).toBeInstanceOf('Species');
				expect(species[1].name).toBe('Human');
				expect(species[1].designation).toBe('Sentient');
				expect(species[1].id).toBe(1);
			});

			it("404s on non-existent records", function(){
				var species = new lib.Species();
				expect(function(){
					var species = species.find(9999999999999);
				}).toThrow("exception", "Resource not found.")
			});
		});

		describe("fetch methods", function(){
			var species = new lib.Species();
			var species = species.find(1);

			it("fetches films from an array of film uris", function(){
				var films = species.fetchFilms();
				expect(films[1]).toBeInstanceOf('Films');
			});

			it("fetches people from an array of people uris", function(){
				var people = species.fetchPeople();
				expect(people[1]).toBeInstanceOf('People');
			});

			it("fetches homeworld (synonym of planets) from a planet uri", function(){
				var homeworld = species.fetchHomeworld();
				expect(homeworld).toBeInstanceOf('Planets');
			});

			it("it errors when fetching something that doesn't exist", function(){
				species(function(){
					species.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "Method not found.")
			});

			it("fetches url, a uri to load", function(){
				var theSameSpecies = species.fetchURL();
				expect(theSameSpecies).toBeInstanceOf('Species');
			});

			it("it errors when trying to fetch something that doesn't exist", function(){
				expect(function(){
					species.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "There is no resource 'FoobarGoblledyGuck' to fetch.")
			});

			it("it errors when trying to fetch something that isn't a uri", function(){
				expect(function(){
					species.fetchName();
				}).toThrow("exception", "Title is not a valid uri to fetch for.")
			});

			it("it errors when a method doesn't exist", function(){
				expect(function(){
					species.SomeJunkIMadeUpThatDoesntExist();
				}).toThrow("exception", "There is no method with the name SomeJunkIMadeUpThatDoesntExist")
			});
		});

		describe("Schema", function(){
			it("can gets its schema", function(){
				var species = new lib.Species();
				var response = species.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/speciesSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}