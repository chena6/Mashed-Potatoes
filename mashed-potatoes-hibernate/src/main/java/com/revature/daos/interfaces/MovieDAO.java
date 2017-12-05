package com.revature.daos.interfaces;

import com.revature.entities.Movie;

public interface MovieDAO {
	
	/**
	 * @param id
	 * @return Returns the movie with the given ID.
	 */
	public Movie get(String id);
	
}
