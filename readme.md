#CFHolonet - A CFML Wrapper for The Star Wars API

##Intro

This is a wrapper lib for the [Star Wars API](http://swapi.co) written in CFML (ColdFusion). It's been tested against Railo 4, so quite honestly, I don't know if it works in Adobe ColdFusion. I haven't tried. If you want to try it and it doesn't work, then by all means submit a pull request on a new branch. Write tests please :)

I'll document this a bit more, but it closely follows the original REST API with support for the following resources:

* Films
* People
* Planets
* Species
* Starships
* Vehicles


## Examples
Pulled from the specs for reference

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

	it("fetches characters (synonym for people) from an array of people uris", function(){
		var films = new lib.Films();
		var film = films.find(1);
		var characters = film.fetchCharacters();

		expect(characters[1]).toBeInstanceOf('People');
	});

	it("fetches vehicles from an array of vehicle uris", function(){
		var films = new lib.Films();
		var film = films.find(1);
		var vehicles = film.fetchVehicles();

		expect(vehicles[1]).toBeInstanceOf('Vehicles');
	});

	it("can gets its schema", function(){
		var films = new lib.Films();
		var response = films.getSchema();
		var schemaJSON = fileRead(getDirectoryFromPath("/tests/resources/") & "/filmsSchema.json");

		expect(response).toBeTypeOf('struct');
		expect(response).toBe(deserializeJSON(schemaJSON));

	});


You can look at the SWAPI for the complete reference of properties available to each entity. The library uses some metaprogramming techniques inspired by a lot of Ruby   based REST API wrappers to support whatever comes back in the API to be accessible by the object.

## Tests

These tests take forever to run. I haven't quite determined why yet. It's in part due to making calls to the live API to fetch data, but seems excessivley long. If anyone has ideas, I'd love to hear them.
