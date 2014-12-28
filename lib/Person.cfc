/**
*
* @file  /lib/Person.cfc
* @author Dan Kraus
* @description Person class for Star Wars API Wrapper
*
*/

component extends="Base" accessors="true"{

	property string name;
	property string height;
	property string mass;
	property string hairColor;
	property string skinColor;
	property string eyeColor;
	property string birthYear;
	property string gender;
	property string url;
	property timestamp createdAt;
	property timestamp editedAt;

	public function init(numeric id, string uri){
		var results = {};

		variables.resource = "people";
		super.init();

		results = super.getResource(resource, arguments.id, arguments.uri);
		populateModel(results);
		return this;
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

	public function getHomeworld(){
		return new Planet(uri=variables.associations.homeworld);
	}

	public function getSpecies(){
		return variables.associations.species.map(function(uri){
			return new Species(uri=uri);
		});
	}

	public function getFilms(){
		return variables.associations.films.map(function(uri){
			return new Film(uri=uri);
		});
	}

	public function getSchema(){
		return super.getSchema(variables.resource);
	}


	private function populateModel(required struct response){
		setName(response["name"]);
		setHeight(response["height"]);
		setMass(response["mass"]);
		setHairColor(response["hair_color"])
		setSkinColor(response["skin_color"]);
		setEyeColor(response["eye_color"]);
		setBirthYear(response["birth_year"]);
		setGender(response["gender"]);
		setUrl(response["url"]);
		setCreatedAt(response["created"]);
		setEditedAt(response["edited"]);

		variables.associations.homeworld = response["homeworld"];
		variables.associations.films = response["films"];
		variables.associations.species = response["species"];
		variables.associations.vehicles = response["vehicles"];
		variables.associations.starships = response["starships"];
	}

}