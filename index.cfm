<cfscript>
	films = new lib.Films();
	film = films.find(1);
	writeDump(film);
	writeDump(film.fetchStarships());
</cfscript>