package com.revature.controllers;

import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.entities.Review;
import com.revature.services.ReviewService;

@RestController
@RequestMapping("reviews")
@CrossOrigin(origins = "http://localhost:4200")
public class ReviewsController {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	ReviewService rs;
	
	@GetMapping("movie={id}")
	public Set<Review> getReviewsByMovieId(@PathVariable String id) {
		log.info("In reviews controller, movie id given: " + id);
		return rs.getReviewsByMovieId(id);
	}
	
	@GetMapping("user={id}")
	public Set<Review> getReviewsByUserId(@PathVariable int id) {
		log.info("In reviews controller, user id given: " + id);
		return rs.getReviewsByUserId(id);
	}
	
}
