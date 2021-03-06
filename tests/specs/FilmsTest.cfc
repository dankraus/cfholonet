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

			it("404s on non-existent records", function(){
				var films = new lib.Films();
				expect(function(){
					var film = films.find(9999999999999);
				}).toThrow("exception", "Resource not found.")
			});
		});

		describe("fetch methods", function(){
			var films = new lib.Films();
			var film = films.find(1);

			it("fetches starships from an array of starship uris", function(){
				var starships = film.fetchStarships();
				expect(starships[1]).toBeInstanceOf('Starships');
			});

			it("fetches species from an array of species uris", function(){
				var species = film.fetchSpecies();
				expect(species[1]).toBeInstanceOf('Species');
			});

			it("fetches planets from an array of planet uris", function(){
				var planets = film.fetchPlanets();
				expect(planets[1]).toBeInstanceOf('Planets');
			});

			it("fetches characters (synonym for people) from an array of people uris", function(){
				var characters = film.fetchCharacters();
				expect(characters[1]).toBeInstanceOf('People');
			});

			it("fetches vehicles from an array of vehicle uris", function(){
				var vehicles = film.fetchVehicles();

				expect(vehicles[1]).toBeInstanceOf('Vehicles');
			});

			it("fetches url, a uri to load", function(){
				var theSameFilm = film.fetchURL();
				expect(theSameFilm).toBeInstanceOf('Films');
			});

			it("it errors when trying to fetch something that doesn't exist", function(){
				expect(function(){
					film.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "There is no resource 'FoobarGoblledyGuck' to fetch.")
			});

			it("it errors when trying to fetch something that isn't a uri", function(){
				expect(function(){
					film.fetchTitle();
				}).toThrow("exception", "Title is not a valid uri to fetch for.")
			});

			it("it errors when a method doesn't exist", function(){
				expect(function(){
					film.SomeJunkIMadeUpThatDoesntExist();
				}).toThrow("exception", "There is no method with the name SomeJunkIMadeUpThatDoesntExist")
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