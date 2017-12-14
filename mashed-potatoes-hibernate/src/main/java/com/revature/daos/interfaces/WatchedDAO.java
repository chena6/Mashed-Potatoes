package com.revature.daos.interfaces;

import java.util.Set;

import com.revature.entities.Movie;
import com.revature.entities.Watched;

public interface WatchedDAO {

	public void addMovieToWatched(Watched w);

	public Set<Movie> getWatched(int id);
	
	public void deleteMovieFromWatched(Watched w);
}
