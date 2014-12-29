/**
*
* @file  /lib/Films.cfc
* @author Dan Kraus
* @description Films class for Star Wars API Wrapper
*
*/

component extends="Base"{

	public function init(struct data = {}){
		super.init(arguments.data);
		return this;
	}

}