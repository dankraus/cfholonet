/**
*
* @file  /lib/Vehicles.cfc
* @author Dan Kraus
* @description Vehicles class for Star Wars API Wrapper
*
*/

component extends="Base"{

	public function init(struct data = {}){
		super.init(arguments.data);
		return this;
	}

}