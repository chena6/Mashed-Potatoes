package com.revature.services;

import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.daos.interfaces.MovieDAO;
import com.revature.entities.Movie;

@Service
public class MovieService {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	MovieDAO movieRepo;

	public Set<Movie> getMoviesBySearch(String query) {
		
		log.info("In get movies by search in MovieService controller.");
		
		Set<Movie> movies = movieRepo.getMoviesByRating(query.toUpperCase());
		/*movies.addAll(movieRepo.getMoviesByPlot(query.toUpperCase()));
		movies.addAll(movieRepo.getMoviesByGenre(query.toUpperCase()));
		movies.addAll(movieRepo.);
		movies.addAll(movieRepo.getMoviesByActor(query.toUpperCase()));*/
		
		return movies;
	}
}
