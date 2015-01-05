/**
*
* @file  /lib/Species.cfc
* @author Dan Kraus
* @description Species class for Star Wars API Wrapper
*
*/

component extends="Base"{

	public function init(struct data = {}){
		super.init(arguments.data);
		return this;
	}

}