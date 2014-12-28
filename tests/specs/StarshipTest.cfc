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
				var starship = new lib.Starship(2);
				expect(starship).toBeInstanceOf('Starship');
			});

			it('inits with a uri', function(){
				var starship = new lib.Starship(uri='http://swapi.co/api/starships/2');
				expect(starship).toBeInstanceOf('Starship');
			});

			it('throws error without an id or uri', function(){
				expect(function(){ new lib.Starship() }).toThrow("exception", "Requires numeric id for resource or complete resource URI string");
			});
		});

		describe("Populates model properties", function(){
			var starship = new lib.Starship(2);

			it("can get its name", function(){
				expect(starship.getName()).toBePresent();
			});
			it("can get its model", function(){
				expect(starship.getModel()).toBePresent();
			});
			it("can get its manufacturer", function(){
				expect(starship.getManufacturer()).toBePresent();
			});
			it("can get its costInCredits", function(){
				expect(starship.getCostInCredits()).toBePresent();
			});
			it("can get its length", function(){
				expect(starship.getLength()).toBePresent();
			});
			it("can get its maxAtmospheringSpeed", function(){
				expect(starship.getMaxAtmospheringSpeed()).toBePresent();
			});
			it("can get its crew", function(){
				expect(starship.getCrew()).toBePresent();
			});
			it("can get its passengers", function(){
				expect(starship.getPassengers()).toBePresent();
			});
			it("can get its cargoCapacity", function(){
				expect(starship.getCargoCapacity()).toBePresent();
			});
			it("can get its consumables", function(){
				expect(starship.getConsumables()).toBePresent();
			});
			it("can get its hyperdriveRating", function(){
				expect(starship.getPassengers()).toBePresent();
			});
			it("can get its MGLT", function(){
				expect(starship.getMGLT()).toBePresent();
			});
			it("can get its starshipClass", function(){
				expect(starship.getStarshipClass()).toBePresent();
			});
			it("can get its createdAt", function(){
				expect(starship.getCreatedAT()).toBePresent();
			});
			it("can get its editedAt", function(){
				expect(starship.getEditedAt()).toBePresent();
			});
		});

		describe("Gets associated resources", function(){
			it("gets pilots", function(){
				var starship = new lib.Starship(10);
				var pilots = starship.getPilots();
				expect(pilots).toBeTypeOf('array');
				expect(pilots[1]).toBeInstanceOf('Person');
			});
			it("gets films", function(){
				var starship = new lib.Starship(10);
				var films = starship.getFilms();
				expect(films).toBeTypeOf('array');
				expect(films[1]).toBeInstanceOf('Film');
			});
		});

		describe("Schema", function(){
			it("gets its schema", function(){
				var starship = new lib.Starship(2);
				var response = starship.getSchema();
				var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/starshipsSchema.json");

				expect(response).toBeTypeOf('struct');
				expect(response).toBe(deserializeJSON(schemaJSON));
			});
		});
	}

}