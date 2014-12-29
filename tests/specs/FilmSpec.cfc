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
			});

			it("gets all films", function(){
				var films = new lib.Films();
				var films = films.all();
				expect(films).toBeTypeOf('array');
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

		// film = Films.find 1
  //     expect(film['title']).to eq 'A New Hope'
  //     expect(film['episode_id']).to eq 4



		// describe("Populates model properties", function(){
		// 	var film = new lib.Film(1);

		// 	it("can get itstitle", function(){
		// 		expect(film.title).toBePresent();
		// 	});
		// 	it("can get itsepisodeId", function(){
		// 		expect(film.episodeId).toBePresent();
		// 	});
		// 	it("can get itsopeningCrawl", function(){
		// 		expect(film.openingCrawl).toBePresent();
		// 	});
		// 	it("can get itsdirector", function(){
		// 		expect(film.director).toBePresent();
		// 	});
		// 	it("can get itsproducer", function(){
		// 		expect(film.producer).toBePresent();
		// 	});
		// 	it("can get itsurl", function(){
		// 		expect(film.url).toBePresent();
		// 	});
		// 	it("can get itscreatedAt", function(){
		// 		expect(film.created).toBePresent();
		// 	});
		// 	it("can get itseditedAt", function(){
		// 		expect(film.edited).toBePresent();
		// 	});
		// });

		// describe("Gets associated resources", function(){
		// 	it("gets characters", function(){
		// 		var film = new lib.Film(1);
		// 		var characters = film.getCharacters();
		// 		expect(characters).toBeTypeOf('array');
		// 		expect(characters[1]).toBeInstanceOf('Person');
		// 	});
		// 	it("gets planets", function(){
		// 		var film = new lib.Film(1);
		// 		var planets = film.getPlanets();
		// 		expect(planets).toBeTypeOf('array');
		// 		expect(planets[1]).toBeInstanceOf('Planet');
		// 	});
		// 	it("gets starships", function(){
		// 		var film = new lib.Film(1);
		// 		var starships = film.getStarships();
		// 		expect(starships).toBeTypeOf('array');
		// 		expect(starships[1]).toBeInstanceOf('Starship');
		// 	});
		// 	it("gets vehicles", function(){
		// 		var film = new lib.Film(1);
		// 		var vehicles = film.getVehicles();
		// 		expect(vehicles).toBeTypeOf('array');
		// 		expect(vehicles[1]).toBeInstanceOf('Vehicle');
		// 	});
		// 	it("gets species", function(){
		// 		var film = new lib.Film(1);
		// 		var species = film.getSpecies();
		// 		expect(species).toBeTypeOf('array');
		// 		expect(species[1]).toBeInstanceOf('Species');
		// 	});
		// });


	}

}