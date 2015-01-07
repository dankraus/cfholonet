/**
*
* @file  /lib/Base.cfc
* @author Dan Kraus
* @description Base class for Star Wars API Wrapper
*
*/

component {

	public function init(struct data = {}){
		variables.meta = getMetaData();
		variables.baseURL = "http://swapi.co/api/";
		variables.slug = lCase(listLast(variables.meta.fullname, "."));

		if(not structIsEmpty(arguments.data)){
			populateModel(arguments.data);
		}
		return this;
	}

	public function find(required numeric id){
		var data = getURI("#variables.baseURL##variables.slug#/#arguments.id#");
		return createObject("component", variables.meta.fullname).init(data);
	}

	public function all(){
		var results = [];
		var hasMore = true;

		while(hasMore){
			var data = getURI("#variables.baseURL##variables.slug#/");
			results.addAll(data['results']);
			if(structKeyExists(data, 'next') and len(data['next']) ){
				results.addAll(getUri(data['next'])['results']);
			} else {
				hasMore = false;
			}
		}

		return results.map(function(entityData){
			return createObject("component", variables.meta.fullname).init(entityData);
		});

	}

	public function onMissingMethod(name){
		var resource = replace(arguments.name, "fetch", "");
		var resourceObjectToLoad = "";
		var resourcePathToLoad = replaceNoCase(variables.meta.fullname, variables.slug, resource);
		var data = {};

		if(findNoCase("fetch", arguments.name)){
			//check to make sure the resource exists in the object
			if(structKeyExists(this, resource)){
				//it could be an array of URIs
				if(isArray(this[resource])){
					return this[resource].map(function(uri){
						return findResourceByURI(uri);
					});
				} else if(isValidUrl(this[resource])) {
					return findResourceByURI(this[resource]);
				} else {
					throw(type="exception", message="#resource# is not a valid uri to fetch for.");
				}
			} else {
				//special nice message to tell them that they can't 'fetch' the thing they want
				throw(type="exception", message="There is no resource '#resource#' to fetch.");
			}
		} else {
			//regular method not found error;
			throw(type="exception", message="There is no method with the name #name#");
		}
	}

	public function getSchema(){
		return getURI("#variables.baseURL##variables.slug#/schema");
	}

	private function populateModel(required struct data){
		var theData = arguments.data;
		theData.each(function(key){
			if(structKeyExists(theData, key)){
				this[key] = theData[key];
			} else {
				this[key] = '';
			}

		});
		this.id = listLast(theData['url'], '/');
	}

	private function findResourceByURI(required string uri){
		//break up the uri into it's path
		//ex: http://swapi.co/api/people/2 becomes ["people", "2"]
		var path = replace(arguments.uri, variables.baseURL, "");
		path = listToArray(path, "/");

		var resourceToLoad = path[path.size() -1];
		var resourceIdToLoad = path[path.size()];

		//in case someone stick these cfcs anywhere, we look at the meta.fullname
		//which gives us the full path to the cfc.
		//replace the current resoure name out with the one we're about to load
		// this will give us a full path like "something.lib.People" or "lib.People"
		var resourcePathToLoad = replaceNoCase(variables.meta.fullname, variables.slug, resourceToLoad);
		var resourceObject = createObject("component", resourcePathToLoad).init();

		return resourceObject.find(resourceIdToLoad);
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
			throw(type="exception", message="Resource not found.");
		}

		if(not isJSON(response.filecontent)){
			throw(type="exception", message="Response is not valid JSON.");
		}
	}

	private function isValidUrl(required string url){
		var javaURL = "";
		try {
			javaURL = createObject("java", "java.net.URL").init(arguments.url);
			javaURL.toURI();
		} catch(any){
			return false;
		}

		return true;
	}

}