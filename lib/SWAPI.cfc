/**
*
* @file  /lib/SWAPI.cfc
* @author Dan Kraus
* @description Base class for Star Wars API Wrapper
*
*/

component {

	public function init(){
		variables.baseURL = "http://swapi.co/api/";

		return this;
	}

	public function getPeople(numeric id){
		// result = new Person(id=arguments.id);
		// return result;
	}

}