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
				var species = new lib.Species(1);
				expect(species).toBeInstanceOf('Species');
			});

			it('inits with a uri', function(){
				var species = new lib.Species(uri='http://swapi.co/api/species/1');
				expect(species).toBeInstanceOf('Species');
			});

			it('throws error without an id or uri', function(){
				expect(function(){ new lib.Species() }).toThrow("exception", "Requires numeric id for resource or complete resource URI string");
			});
		});

		describe("Populates model properties", function(){
			var species = new lib.Species(1);

			it("can get its name", function(){
				expect(species.getName()).toBePresent();
			});
			it("can get its classification", function(){
				expect(species.getClassification()).toBePresent();
			});
			it("can get its designation", function(){
				expect(species.getDesignation()).toBePresent();
			});
			it("can get its averageHeight", function(){
				expect(species.getAverageHeight()).toBePresent();
			});
			it("can get its skinColors", function(){
				expect(species.getSkinColors()).toBePresent();
				expect(species.getSkinColors()).toBeTypeOf('array');
			});
			it("can get its hairColors", function(){
				expect(species.getHairColors()).toBePresent();
				expect(species.getHairColors()).toBeTypeOf('array');
			});
			it("can get its eyeColors", function(){
				expect(species.getEyeColors()).toBePresent();
				expect(species.getEyeColors()).toBeTypeOf('array');
			});
			it("can get its averageLifespan", function(){
				expect(species.getAverageLifespan()).toBePresent();
			});
			it("can get its language", function(){
				expect(species.getLanguage()).toBePresent();
			});
			it("can get its url", function(){
				expect(species.getUrl()).toBePresent();
			});
			it("can get its createdAt", function(){
				expect(species.getCreatedAt()).toBePresent();
			});
			it("can get its editedAt", function(){
				expect(species.getEditedAt()).toBePresent();
			});
		});

		describe("Gets associated resources", function(){
			it("gets films", function(){
				var species = new lib.Species(1);
				var films = species.getFilms();
				expect(films).toBeTypeOf('array');
				expect(films[1]).toBeInstanceOf('Film');
			});
			it("gets people", function(){
				var species = new lib.Species(1);
				var people = species.getPeople();
				expect(people).toBeTypeOf('array');
				expect(people[1]).toBeInstanceOf('Person');
			});
			it("gets homeworld", function(){
				var species = new lib.Species(1);
				var planet = species.getHomeworld();
				expect(planet).toBeInstanceOf('Planet');
			});
		});

		describe("Schema", function(){
			it("gets its schema", function(){
				var person = new lib.Species(1);
				var response = person.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/speciesSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}