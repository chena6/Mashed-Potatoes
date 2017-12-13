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

import com.revature.entities.Review;
import com.revature.entities.User;
import com.revature.services.ReviewService;

@RestController
@RequestMapping("reviews")
@CrossOrigin(origins = "http://localhost:4200")
public class ReviewsController {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	ReviewService rs;
	
	@GetMapping("all")
	public Set<Review> getAllReviews() {
		return rs.getAllReviews();
	}
	
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
	
	@PostMapping
	public void createReview(@RequestBody Review rev) {
		log.info("In new review controller, :" + rev);
		rs.createNewReview(rev);
	}
	
	@PostMapping("delete={id}")
	public void deleteReview (@PathVariable int id) {
		rs.deleteReview(id);
	}
	
}