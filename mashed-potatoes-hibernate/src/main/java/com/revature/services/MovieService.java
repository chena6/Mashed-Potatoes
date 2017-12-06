package com.revature.services;

import java.util.ArrayList;
import java.util.List;

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

	public List<Movie> getMoviesBySearch(String query) {
		
		log.info("In get movies by search in MovieService controller.");
		
		List<Movie> movies = new ArrayList<>();
		
		movies.add(movieRepo.get(query));
		
		return movies;
	}
	
	
	
}
