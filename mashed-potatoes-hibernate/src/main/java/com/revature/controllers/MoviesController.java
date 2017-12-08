package com.revature.controllers;

import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.entities.Movie;
import com.revature.services.MovieService;

@RestController
@RequestMapping("movies")
public class MoviesController {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	MovieService msvc;
	
	@GetMapping
	public String printHelloMovies() {
		return "Hello movies!";
	}
	
	@GetMapping("search={query}")
	public Set<Movie> searchMovies(@PathVariable String query) {
		
		log.info("in search movies controller.");
		
		Set<Movie> movies = msvc.getMoviesBySearch(query);
		
		return movies;
	}
}
