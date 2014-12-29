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
			it("finds a Film", function(){
				var people = new lib.People();
				var film = people.find(1);
				expect(film).toBeInstanceOf('People');
				expect(film.title).toBe('A New Hope');
				expect(film.episode_id).toBe('4');
				expect(film.id).toBe(1);
			});

			it("gets all people", function(){
				var people = new lib.People();
				var people = people.all();
				expect(people).toBeTypeOf('array');
				expect(people[1]).toBeInstanceOf('People');
				expect(people[1].title).toBe('A New Hope');
				expect(people[1].episode_id).toBe('4');
			});
		});

		describe("fetch methods", function(){
			it("fetches starships", function(){
				var people = new lib.People();
				var people = people.find(1);
				var starships = film.fetchStarships();

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

				expect(species[1]).toBeInstanceOf('Films');
			});

			it("fetches homeworld (synonym of planets)", function(){
				var people = new lib.People();
				var person = people.find(1);
				var planet = film.fetchHomeworld();

				expect(planets).toBeInstanceOf('Planets');
			});

			it("fetches planets", function(){
				var people = new lib.People();
				var person = people.find(1);
				var planet = film.fetchPlanets();

				expect(planets).toBeInstanceOf('Planets');
			});

			it("fetches vehicles", function(){
				var films = new lib.Films();
				var film = films.find(1);
				var people = film.fetchVehicles();

				expect(people[1]).toBeInstanceOf('Vehicles');
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