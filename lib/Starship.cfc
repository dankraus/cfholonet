/**
*
* @file  /lib/Starship.cfc
* @author Dan Kraus
* @description Person class for Star Wars API Wrapper
*
*/

component extends="Base" accessors="true"{

	property string name;
	property string crew;
	property string length;
	property string hyperDriveRating;
	property string passengers;
	property string MGLT;
	property string maxAtmospheringSpeed;
	property string starshipClass;
	property string manufacturer;
	property string cargoCapacity;
	property string model;
	property string consumables;
	property string costInCredits;
	property string url;
	property timestamp createdAt;
	property timestamp editedAt;

	public function init(numeric id, string uri){
		var results = {};

		variables.resource = "starships";
		super.init();

		results = super.getResource(resource, arguments.id, arguments.uri);
		populateModel(results);
		return this;
	}

	public function getFilms(){
		return variables.associations.films.map(function(uri){
			return new Film(uri=uri);
		});
	}

	public function getPilots(){
		return variables.associations.pilots.map(function(uri){
			return new Person(uri=uri);
		});
	}

	public function getSchema(){
		return super.getSchema(variables.resource);
	}


	private function populateModel(required struct response){
		setName(response["name"]);
		setCrew(response["crew"]);
		setLength(response["length"]);
		setHyperDriveRating(response["hyperdrive_rating"]);
		setPassengers(response["passengers"]);
		setMGLT(response["MGLT"]);
		setMaxAtmospheringSpeed(response["max_atmosphering_speed"]);
		setStarshipClass(response["starship_class"]);
		setManufacturer(response["manufacturer"]);
		setCargoCapacity(response["cargo_capacity"]);
		setModel(response["model"]);
		setConsumables(response["consumables"]);
		setCostInCredits(response["cost_in_credits"]);
		setUrl(response["url"]);
		setCreatedAt(response["created"]);
		setEditedAt(response["edited"]);

		variables.associations.films = response["films"];
		variables.associations.pilots = response["pilots"];
	}

}