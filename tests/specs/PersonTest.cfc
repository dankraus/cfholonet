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
		// describe("Init", function(){
		// 	it('inits with a numeric id', function(){
		// 		var person = new lib.Person(1);
		// 		expect(person).toBeInstanceOf('Person');
		// 	});

		// 	it('inits with a uri', function(){
		// 		var person = new lib.Person(uri='http://swapi.co/api/people/1');
		// 		expect(person).toBeInstanceOf('Person');
		// 	});

		// 	it('throws error without an id or uri', function(){
		// 		expect(function(){ new lib.Person() }).toThrow("exception", "Requires numeric id for resource or complete resource URI string");
		// 	});
		// });

		// describe("Populates model properties", function(){
		// 	var person = new lib.Person(1);
		// 	it("can get its name", function(){
		// 		expect(person.name).toBePresent();
		// 	});
		// 	it("can get its height", function(){
		// 		expect(person.height).toBePresent();
		// 	});
		// 	it("can get its mass", function(){
		// 		expect(person.mass).toBePresent();
		// 	});
		// 	it("can get its hairColor", function(){
		// 		expect(person.hairColor).toBePresent();
		// 	});
		// 	it("can get its skinColor", function(){
		// 		expect(person.skinColor).toBePresent();
		// 	});
		// 	it("can get its eyeColor", function(){
		// 		expect(person.eyeColor).toBePresent();
		// 	});
		// 	it("can get its birthYear", function(){
		// 		expect(person.birthYear).toBePresent();
		// 	});
		// 	it("can get its gender", function(){
		// 		expect(person.gender).toBePresent();
		// 	});
		// 	it("can get its url", function(){
		// 		expect(person.url).toBePresent();
		// 	});
		// 	it("can get its created", function(){
		// 		expect(person.created).toBePresent();
		// 	});
		// 	it("can get its edited", function(){
		// 		expect(person.edited).toBePresent();
		// 	});
		// });

		// describe("Gets associated resources", function(){
		// 	it("gets starships", function(){
		// 		var person = new lib.Person(1);
		// 		var starships = person.getStarships();
		// 		expect(starships).toBeTypeOf('array');
		// 		expect(starships[1]).toBeInstanceOf('Starship');
		// 	});

		// 	it("gets vehicles", function(){
		// 		var person = new lib.Person(1);
		// 		var vehicles = person.getVehicles();
		// 		expect(vehicles).toBeTypeOf('array');
		// 		expect(vehicles[1]).toBeInstanceOf('Vehicle');
		// 	});

		// 	it("gets homeworld", function(){
		// 		var person = new lib.Person(1);
		// 		var homeworld = person.getHomeworld();
		// 		expect(homeworld).toBeInstanceOf('Planet');
		// 	});

		// 	it("gets species", function(){
		// 		var person = new lib.Person(1);
		// 		var species = person.getSpecies();
		// 		expect(species).toBeTypeOf('array');
		// 		expect(species[1]).toBeInstanceOf('Species');
		// 	});

		// 	it("gets films", function(){
		// 		var person = new lib.Person(1);
		// 		var films = person.getFilms();
		// 		expect(films).toBeTypeOf('array');
		// 		expect(films[1]).toBeInstanceOf('Film');
		// 	});
		// });

		// describe("Schema", function(){
		// 	it("gets its schema", function(){
		// 		var person = new lib.Person(1);
		// 		var response = person.getSchema();
		// 		var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/peopleSchema.json");

		// 		expect(response).toBeTypeOf('struct');
		// 		expect(response).toBe(deserializeJSON(schemaJSON));
		// 	});
		// });
	}

}