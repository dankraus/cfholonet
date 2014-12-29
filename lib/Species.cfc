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
		this.Name = response["name"];
		this.Classification = response["classification"];
		this.Designation = response["designation"];
		this.AverageHeight = response["average_height"];
		this.SkinColors = listToArray(response["skin_colors"];
		this.HairColors = listToArray(response["hair_colors"];
		this.EyeColors = listToArray(response["eye_colors"];
		this.AverageLifespan = response["average_lifespan"];
		this.Language = response["language"];
		this.Url = response["url"];
		this.CreatedAt = response["created"];
		this.EditedAt = response["edited"];

		variables.associations.films = response["films"];
		variables.associations.people = response["people"];

		variables.associations.homeworld = response["homeworld"];
	}

}