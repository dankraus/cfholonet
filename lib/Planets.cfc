/**
*
* @file  /lib/Planets.cfc
* @author Dan Kraus
* @description Planets class for Star Wars API Wrapper
*
*/

component extends="Base"{

	public function init(struct data = {}){
		super.init(arguments.data);
		return this;
	}

}