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
			var people = new lib.People();
			var person = people.find(1);

			it("fetches starships from an array of starships uris", function(){
				var starships = person.fetchStarships();
				expect(starships[1]).toBeInstanceOf('Starships');
			});

			it("fetches species from an array of species uris", function(){
				var species = person.fetchSpecies();
				expect(species[1]).toBeInstanceOf('Species');
			});

			it("fetches films from an array of film uris", function(){
				var films = person.fetchFilms();
				expect(films[1]).toBeInstanceOf('Films');
			});

			it("fetches homeworld (synonym of planets) from a planet uri", function(){
				var planet = person.fetchHomeworld();
				expect(planets).toBeInstanceOf('Planets');
			});

			it("fetches vehicles when they're present from an array of vehicles uris", function(){
				var vehicles = people.fetchVehicles();

				expect(vehicles[1]).toBeInstanceOf('Vehicles');
			});

			it("it errors when fetching something that doesn't exist", function(){
				expect(function(){
					var person = people.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "Method not found.")
			});

			it("fetches url, a uri to load", function(){
				var theSamePerson = person.fetchURL();
				expect(theSamePerson).toBeInstanceOf('People');
			});

			it("it errors when trying to fetch something that doesn't exist", function(){
				expect(function(){
					person.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "There is no resource 'FoobarGoblledyGuck' to fetch.")
			});

			it("it errors when trying to fetch something that isn't a uri", function(){
				expect(function(){
					person.fetchName();
				}).toThrow("exception", "Title is not a valid uri to fetch for.")
			});

			it("it errors when a method doesn't exist", function(){
				expect(function(){
					person.SomeJunkIMadeUpThatDoesntExist();
				}).toThrow("exception", "There is no method with the name SomeJunkIMadeUpThatDoesntExist")
			});
		});

		describe("Schema", function(){
			it("can gets its schema", function(){
				var people = new lib.People();
				var response = people.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/peopleSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});

	}

}