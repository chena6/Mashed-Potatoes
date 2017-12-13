package com.revature.controllers;

import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.entities.Movie;
import com.revature.services.MovieService;

@RestController
@RequestMapping("movies")
@CrossOrigin(origins = "http://localhost:4200")
public class MoviesController {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	MovieService msvc;
	
	@GetMapping
	public Set<Movie> getTopRated() {
		return msvc.getTopRatedMovies();
	}
	
	@GetMapping("{id}")
	public Movie movieById(@PathVariable String id) {
		log.info("In get movie by id controller.");
		
		return msvc.getMovieById(id);
	}
	
	@PostMapping("search")
	public Set<Movie> searchMovies(@RequestBody String query) {
		
		log.info("in search movies controller. Query: " + query);
		
		Set<Movie> movies = msvc.getMoviesBySearch(query);
		
		return movies;
	}
}
