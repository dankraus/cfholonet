/**
*
* @file  /lib/Vehicle.cfc
* @author Dan Kraus
* @description Vehicle class for Star Wars API Wrapper
*
*/

component extends="Base" {

	property string name;
	property string model;
	property string manufacturer;
	property string costInCredits;
	property string length;
	property string maxAtmospheringSpeed;
	property string crew;
	property string passengers;
	property string cargoCapacity;
	property string consumables;
	property string vehicleClass;
	property string url;
	property timestamp createdAt;
	property timestamp editedAt;

	public function init(numeric id, string uri){
		var results = {};

		variables.resource = "vehicles";
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
		this.model = response["model"];
		this.manufacturer = response["manufacturer"];
		this.costInCredits = response["cost_in_credits"];
		this.length = response["length"];
		this.maxAtmospheringSpeed = response["max_atmosphering_speed"];
		this.crew = response["crew"];
		this.passengers = response["passengers"];
		this.cargoCapacity = response["cargo_capacity"];
		this.consumables = response["consumables"];
		this.vehicleClass = response["vehicle_class"];
		this.url = response["url"];
		this.created = response["created"];
		this.edited = response["edited"];

		variables.associations.films = response["films"];
		variables.associations.pilots = response["pilots"];
	}

}