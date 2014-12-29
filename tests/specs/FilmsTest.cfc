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
				var films = new lib.Films();
				var film = films.find(1);
				expect(film).toBeInstanceOf('Films');
				expect(film.title).toBe('A New Hope');
				expect(film.episode_id).toBe('4');
				expect(film.id).toBe(1);
			});

			it("gets all films", function(){
				var films = new lib.Films();
				var films = films.all();
				expect(films).toBeTypeOf('array');
				expect(films[1]).toBeInstanceOf('Films');
				expect(films[1].title).toBe('A New Hope');
				expect(films[1].episode_id).toBe('4');
			});
		});

		describe("fetch methods", function(){
			it("fetches starships", function(){
				var films = new lib.Films();
				var film = films.find(1);
				var starships = film.fetchStarships();

				expect(starships[1]).toBeInstanceOf('Starships');
			});

			it("fetches species", function(){
				var films = new lib.Films();
				var film = films.find(1);
				var species = film.fetchSpecies();

				expect(species[1]).toBeInstanceOf('Species');
			});

			it("fetches planets", function(){
				var films = new lib.Films();
				var film = films.find(1);
				var planets = film.fetchPlanets();

				expect(planets[1]).toBeInstanceOf('Planets');
			});

			it("fetches characters (synonym for people)", function(){
				var films = new lib.Films();
				var film = films.find(1);
				var people = film.fetchPeople();

				expect(people[1]).toBeInstanceOf('People');
			});

			it("fetches people", function(){
				var films = new lib.Films();
				var film = films.find(1);
				var people = film.fetchPeople();

				expect(people[1]).toBeInstanceOf('People');
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
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/filmsSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});

	}

}