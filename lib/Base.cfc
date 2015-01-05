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

		if(not structIsEmpty(data)){
			populateModel(data);
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
		var entity = replace(arguments.name, "fetch", "");
		var entityPathToLoad = replaceNoCase(variables.meta.fullname, variables.slug, entity);
		var data = {};

		if(structKeyExists(this, entity)){
			if(isArray(this[entity])){
				return this[entity].map(function(uri){
					data = getURI(uri);
					return createObject("component", entityPathToLoad).init(data);
				});
			} else if(isValidURL(this[entity])){
				data = getURI(uri);
				return createObject("component", entityPathToLoad).init(data);
			}
		}
	}

	public function getSchema(){
		return getURI("#variables.baseURL##variables.slug#/schema");
	}

	private function populateModel(required struct data){
		data.each(function(key){
			if(structKeyExists(data, key)){
				this[key] = data[key];
			} else {
				this[key] = '';
			}

		});
		this.id = listLast(data['url'], '/');
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

	private function isValidURL(required string url){
		var url = "";
		try {
			url = createObject("java", "java.net.URL").init(arguments.url);
		} catch(any){
			return false;
		}

		try {
			url.toURI();
		} catch(any){
			return false;
		}

		return true;
	}

}