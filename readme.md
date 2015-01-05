#Star Wars API - CFML Wrapper

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

	it("fetches vehicles", function(){
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

There are a few failing tests at this exact moment. The API frequently uses some synonyms for referencing other resources. Ex: `someVehicle.pilots` is really a reference to an array of `People` resources who have piloted that particular vehicle. The original API returns `pilots` as an array of URIs that point to `People`resources. I'll get these cleaned up shortly, but for now those, resources that use relevant synonyms won't work until I fix them.
