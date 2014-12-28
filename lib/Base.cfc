/**
*
* @file  /lib/Base.cfc
* @author Dan Kraus
* @description Base class for Star Wars API Wrapper
*
*/

component {

	public function init(){
		variables.baseURL = "http://swapi.co/api/";
		return this;
	}

	public function getResource(string resource, numeric id, string uri){
		var results = {};

		if(arguments.id gt 0){
			results = getURI(variables.baseURL & arguments.resource & "/" & toString(arguments.id));
		} else if(len(arguments.uri)){
			results = getURI(arguments.uri);
		} else {
			throw(type="exception", message="Requires numeric id for resource or complete resource URI string");
		}

		return results;
	}

	public function getSchema(required string resource){
		return getURI(variables.baseURL & resource & "/schema");;
	}

	private function getURI(required string uri){
		var response = makeHTTPRequest(uri = uri, method = "get");
		return deserializeJSON(response);
	}

	private function makeHTTPRequest(required string uri, string method ){
		var http = new http();
		var response = "";

		http.setUrl(arguments.uri);
		http.setMethod(arguments.method);
    	http.setCharset("utf-8");
    	http.addParam(type="header", name="User-Agent", value="swapi-coldfusion");

    	response = http.send().getPrefix();

    	handleHTTPResponse(response);

    	return response.filecontent;
	}

	private function handleHTTPResponse(required response){
		if(response.status_code eq "404"){
			throw(type="exception", message="Resource not found");
		}

		if(not isJSON(response.filecontent)){
			throw(type="exception", message="Response is not valid JSON");
		}
	}

}