/**
*
* @file  /lib/Starship.cfc
* @author Dan Kraus
* @description Person class for Star Wars API Wrapper
*
*/

component extends="Base"{

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
	property timestamp created;
	property timestamp edited;

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
		this.name = response["name"];
		this.crew = response["crew"];
		this.length = response["length"];
		this.hyperDriveRating = response["hyperdrive_rating"];
		this.passengers = response["passengers"];
		this.MGLT = response["MGLT"];
		this.maxAtmospheringSpeed = response["max_atmosphering_speed"];
		this.starshipClass = response["starship_class"];
		this.manufacturer = response["manufacturer"];
		this.cargoCapacity = response["cargo_capacity"];
		this.model = response["model"];
		this.consumables = response["consumables"];
		this.costInCredits = response["cost_in_credits"];
		this.url = response["url"];
		this.created = response["created"];
		this.edited = response["edited"];

		variables.associations.films = response["films"];
		variables.associations.pilots = response["pilots"];
	}

}