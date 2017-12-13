package com.revature.daos.interfaces;

import java.util.Set;

import com.revature.entities.Backlog;
import com.revature.entities.Movie;

public interface BacklogDAO {

	public void addMovieToBacklog(Backlog b);
	
	public Set<Movie> getBacklog(int id);

}
