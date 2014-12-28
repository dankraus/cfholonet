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
				var person = new lib.Person(1);
				expect(person).toBeInstanceOf('Person');
			});

			it('inits with a uri', function(){
				var person = new lib.Person(uri='http://swapi.co/api/people/1');
				expect(person).toBeInstanceOf('Person');
			});

			it('throws error without an id or uri', function(){
				expect(function(){ new lib.Person() }).toThrow("exception", "Requires numeric id for resource or complete resource URI string");
			});
		});

		describe("Populates model properties", function(){
			var person = new lib.Person(1);
			it("can get its name", function(){
				expect(person.getName()).toBePresent();
			});
			it("can get its height", function(){
				expect(person.getHeight()).toBePresent();
			});
			it("can get its mass", function(){
				expect(person.getMass()).toBePresent();
			});
			it("can get its hairColor", function(){
				expect(person.getHairColor()).toBePresent();
			});
			it("can get its skinColor", function(){
				expect(person.getSkinColor()).toBePresent();
			});
			it("can get its eyeColor", function(){
				expect(person.getEyeColor()).toBePresent();
			});
			it("can get its birthYear", function(){
				expect(person.getBirthYear()).toBePresent();
			});
			it("can get its gender", function(){
				expect(person.getGender()).toBePresent();
			});
			it("can get its url", function(){
				expect(person.getUrl()).toBePresent();
			});
			it("can get its createdAt", function(){
				expect(person.getCreatedAt()).toBePresent();
			});
			it("can get its editedAt", function(){
				expect(person.getEditedAt()).toBePresent();
			});
		});

		describe("Gets associated resources", function(){
			it("gets starships", function(){
				var person = new lib.Person(1);
				var starships = person.getStarships();
				expect(starships).toBeTypeOf('array');
				expect(starships[1]).toBeInstanceOf('Starship');
			});

			it("gets vehicles", function(){
				var person = new lib.Person(1);
				var vehicles = person.getVehicles();
				expect(vehicles).toBeTypeOf('array');
				expect(vehicles[1]).toBeInstanceOf('Vehicle');
			});

			it("gets homeworld", function(){
				var person = new lib.Person(1);
				var homeworld = person.getHomeworld();
				expect(homeworld).toBeInstanceOf('Planet');
			});

			it("gets species", function(){
				var person = new lib.Person(1);
				var species = person.getSpecies();
				expect(species).toBeTypeOf('array');
				expect(species[1]).toBeInstanceOf('Species');
			});

			it("gets films", function(){
				var person = new lib.Person(1);
				var films = person.getFilms();
				expect(films).toBeTypeOf('array');
				expect(films[1]).toBeInstanceOf('Film');
			});
		});

		describe("Schema", function(){
			it("gets its schema", function(){
				var person = new lib.Person(1);
				var response = person.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/peopleSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}