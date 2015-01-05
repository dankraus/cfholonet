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
			it("fetches films", function(){
				var species = new lib.Species();
				var species = species.find(1);
				var films = species.fetchFilms();

				expect(films[1]).toBeInstanceOf('Films');
			});

			it("fetches people", function(){
				var species = new lib.Species();
				var species = species.find(1);
				var people = species.fetchPeople();

				expect(people[1]).toBeInstanceOf('People');
			});

			it("fetches homeworld (synonym of planets)", function(){
				var species = new lib.Species();
				var species = species.find(1);
				var homeworld = species.fetchHomeworld();

				expect(homeworld).toBeInstanceOf('Planets');
			});

			it("fetches planets", function(){
				var species = new lib.Species();
				var species = species.find(1);
				var homeworld = species.fetchPlanets();

				expect(homeworld).toBeInstanceOf('Planets');
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