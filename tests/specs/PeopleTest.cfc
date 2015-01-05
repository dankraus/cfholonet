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
			it("finds a Person", function(){
				var people = new lib.People();
				var person = people.find(1);
				expect(person).toBeInstanceOf('People');
				expect(people.name).toBe('Luke Skywalker');
				expect(people.birth_year).toBe('19BBY');
				expect(person.id).toBe(1);
			});

			it("gets all people", function(){
				var people = new lib.People();
				var people = people.all();
				expect(people).toBeTypeOf('array');
				expect(people[1]).toBeInstanceOf('People');
				expect(people[1].name).toBe('Luke Skywalker');
				expect(people[1].birth_year).toBe('19BBY');
				expect(people[1].id).toBe(1);
			});

			it("404s on non-existent records", function(){
				var people = new lib.People();
				expect(function(){
					var person = people.find(9999999999999);
				}).toThrow("exception", "Resource not found.")
			});
		});

		describe("fetch methods", function(){
			it("fetches starships", function(){
				var people = new lib.People();
				var people = people.find(1);
				var starships = people.fetchStarships();

				expect(starships[1]).toBeInstanceOf('Starships');
			});

			it("fetches species", function(){
				var people = new lib.People();
				var person = people.find(1);
				var species = person.fetchSpecies();

				expect(species[1]).toBeInstanceOf('Species');
			});

			it("fetches films", function(){
				var people = new lib.People();
				var person = people.find(1);
				var films = person.fetchFilms();

				expect(films[1]).toBeInstanceOf('Films');
			});

			it("fetches homeworld (synonym of planets)", function(){
				var people = new lib.People();
				var person = people.find(1);
				var planet = person.fetchHomeworld();

				expect(planets).toBeInstanceOf('Planets');
			});

			it("fetches planets", function(){
				var people = new lib.People();
				var person = people.find(1);
				var planet = person.fetchPlanets();

				expect(planets).toBeInstanceOf('Planets');
			});

			it("fetches vehicles when they're present", function(){
				var people = new lib.People();
				var people = people.find(1);
				var vehicles = people.fetchVehicles();

				expect(vehicles[1]).toBeInstanceOf('Vehicles');
			});
		});

		describe("Schema", function(){
			it("can gets its schema", function(){
				var films = new lib.Films();
				var response = films.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/peopleSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});

	}

}