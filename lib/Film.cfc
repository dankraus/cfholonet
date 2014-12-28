/**
*
* @file  /lib/Film.cfc
* @author Dan Kraus
* @description Person class for Star Wars API Wrapper
*
*/

component extends="Base" accessors="true"{

	property string title;
	property string episodeId;
	property string openingCrawl;
	property string director;
	property string producer;
	property string url;
	property timestamp createdAt;
	property timestamp editedAt;

	public function init(numeric id, string uri){
		var results = {};

		variables.resource = "films";
		super.init();

		results = super.getResource(resource, arguments.id, arguments.uri);
		populateModel(results);
		return this;
	}

	public function getCharacters(){
		return variables.associations.characters.map(function(uri){
			return new Person(uri=uri);
		});
	}

	public function getPlanets(){
		return variables.associations.planets.map(function(uri){
			return new Planet(uri=uri);
		});
	}

	public function getStarships(){
		return variables.associations.starships.map(function(uri){
			return new Starship(uri=uri);
		});
	}

	public function getVehicles(){
		return variables.associations.vehicles.map(function(uri){
			return new Vehicle(uri=uri);
		});
	}

	public function getSpecies(){
		return variables.associations.species.map(function(uri){
			return new Species(uri=uri);
		});
	}

	public function getSchema(){
		return super.getSchema(variables.resource);
	}


	private function populateModel(required struct response){
		setTitle(response["title"]);
		setEpisodeId(response["episode_id"]);
		setOpeningCrawl(response["opening_crawl"]);
		setDirector(response["director"]);
		setProducer(response["producer"]);
		setUrl(response["url"]);
		setCreatedAt(response["created"]);
		setEditedAt(response["edited"]);

		variables.associations.characters = response["characters"];
		variables.associations.planets = response["planets"];
		variables.associations.starships = response["starships"];
		variables.associations.vehicles = response["vehicles"];
		variables.associations.species = response["species"];
	}

}