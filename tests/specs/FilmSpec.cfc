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
		describe("Init", function(){
			it('inits with a numeric id', function(){
				var film = new lib.Film(2);
				expect(film).toBeInstanceOf('Film');
			});

			it('inits with a uri', function(){
				var film = new lib.Film(uri='http://swapi.co/api/films/2');
				expect(film).toBeInstanceOf('Film');
			});

			it('throws error without an id or uri', function(){
				expect(function(){ new lib.Film() }).toThrow("exception", "Requires numeric id for resource or complete resource URI string");
			});
		});

		describe("Populates model properties", function(){
			var film = new lib.Film(1);

			it("can get its title", function(){
				expect(film.getTitle()).toBePresent();
			});
			it("can get its episodeId", function(){
				expect(film.getEpisodeId()).toBePresent();
			});
			it("can get its openingCrawl", function(){
				expect(film.getOpeningCrawl()).toBePresent();
			});
			it("can get its director", function(){
				expect(film.getDirector()).toBePresent();
			});
			it("can get its producer", function(){
				expect(film.getProducer()).toBePresent();
			});
			it("can get its url", function(){
				expect(film.getUrl()).toBePresent();
			});
			it("can get its createdAt", function(){
				expect(film.getCreatedAt()).toBePresent();
			});
			it("can get its editedAt", function(){
				expect(film.getEditedAt()).toBePresent();
			});
		});

		describe("Gets associated resources", function(){
			it("gets characters", function(){
				var film = new lib.Film(1);
				var characters = film.getCharacters();
				expect(characters).toBeTypeOf('array');
				expect(characters[1]).toBeInstanceOf('Person');
			});
			it("gets planets", function(){
				var film = new lib.Film(1);
				var planets = film.getPlanets();
				expect(planets).toBeTypeOf('array');
				expect(planets[1]).toBeInstanceOf('Planet');
			});
			it("gets starships", function(){
				var film = new lib.Film(1);
				var starships = film.getStarships();
				expect(starships).toBeTypeOf('array');
				expect(starships[1]).toBeInstanceOf('Starship');
			});
			it("gets vehicles", function(){
				var film = new lib.Film(1);
				var vehicles = film.getVehicles();
				expect(vehicles).toBeTypeOf('array');
				expect(vehicles[1]).toBeInstanceOf('Vehicle');
			});
			it("gets species", function(){
				var film = new lib.Film(1);
				var species = film.getSpecies();
				expect(species).toBeTypeOf('array');
				expect(species[1]).toBeInstanceOf('Species');
			});
		});

		describe("Schema", function(){
			it("gets its schema", function(){
				var film = new lib.Film(2);
				var response = film.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/filmsSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}