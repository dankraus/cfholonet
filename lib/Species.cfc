/**
*
* @file  /lib/Species.cfc
* @author Dan Kraus
* @description Species class for Star Wars API Wrapper
*
*/

component extends="Base" accessors="true"{

	property string name;
	property string classification;
	property string designation;
	property string averageHeight;
	property array skinColors;
	property array hairColors;
	property array eyeColors;
	property string averageLifespan;
	property string language;
	property string gender;
	property string url;
	property timestamp createdAt;
	property timestamp editedAt;

	public function init(numeric id, string uri){
		var results = {};

		variables.resource = "species";
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

	public function getPeople(){
		return variables.associations.people.map(function(uri){
			return new Person(uri=uri);
		});
	}

	public function getHomeworld(){
		if(isDefined(variables.associations.homeworld) and len(variables.associations.homeworld)){
			return new Planet(uri=variables.associations.homeworld);
		} else {
			return {};
		}
	}

	public function getSchema(){
		return super.getSchema(variables.resource);
	}


	private function populateModel(required struct response){
		setName(response["name"]);
		setClassification(response["classification"]);
		setDesignation(response["designation"]);
		setAverageHeight(response["average_height"]);
		setSkinColors(listToArray(response["skin_colors"]));
		setHairColors(listToArray(response["hair_colors"]));
		setEyeColors(listToArray(response["eye_colors"]));
		setAverageLifespan(response["average_lifespan"]);
		setLanguage(response["language"]);
		setUrl(response["url"]);
		setCreatedAt(response["created"]);
		setEditedAt(response["edited"]);

		variables.associations.films = response["films"];
		variables.associations.people = response["people"];

		variables.associations.homeworld = response["homeworld"];
	}

}