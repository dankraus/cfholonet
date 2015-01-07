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
			it("finds a Starship", function(){
				var starships = new lib.Starships();
				var starship = starships.find(9);
				expect(starship).toBeInstanceOf('Starships');
				expect(starship.name).toBe('Death Star');
				expect(starship.model).toBe('DS-1 Orbital Battle Station');
			});

			it("gets all Starships", function(){
				var starships = new lib.Starships();
				var starships = starships.all();
				expect(starships).toBeTypeOf('array');
				expect(starships[1].name).toBe('Sentinel-class landing craft');
				expect(starships[1].model).toBe('Sentinel-class landing craft');
			});

			it("404s on non-existent records", function(){
				var starships = new lib.Starships();
				expect(function(){
					var starship = starships.find(9999999999999);
				}).toThrow("exception", "Resource not found.")
			});
		});

		describe("fetch methods", function(){
			var starships = new lib.Starships();
			var starship = starships.find(10);

			it("fetches films", function(){
				var films = starships.fetchFilms();
				expect(films[1]).toBeInstanceOf('Films');
			});

			it("fetches pilots (synonym of people) when they're present from an array of people uris", function(){
				var pilots = starships.fetchPilots();
				expect(starships[1]).toBeInstanceOf('People');
			});

			it("it errors when fetching something that doesn't exist", function(){
				expect(function(){
					var starships = starships.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "Method not found.")
			});

			it("fetches url, a uri to load", function(){
				var theSameStarship = starships.fetchURL();

				expect(theSameStarship).toBeInstanceOf('starships');
			});

			it("it errors when trying to fetch something that doesn't exist", function(){
				expect(function(){
					starship.fetchFoobarGoblledyGuck();
				}).toThrow("exception", "There is no resource 'FoobarGoblledyGuck' to fetch.")
			});

			it("it errors when trying to fetch something that isn't a uri", function(){
				expect(function(){
					starship.fetchName();
				}).toThrow("exception", "Title is not a valid uri to fetch for.")
			});

			it("it errors when a method doesn't exist", function(){
				expect(function(){
					starship.SomeJunkIMadeUpThatDoesntExist();
				}).toThrow("exception", "There is no method with the name SomeJunkIMadeUpThatDoesntExist")
			});
		});

		describe("Schema", function(){
			it("can gets its schema", function(){
				var films = new lib.Films();
				var response = films.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/starshipsSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}