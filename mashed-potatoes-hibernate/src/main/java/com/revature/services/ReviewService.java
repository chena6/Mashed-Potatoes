package com.revature.services;

import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.interfaces.ReviewDAO;
import com.revature.entities.Review;

@Service
public class ReviewService {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	ReviewDAO reviewRepo;
	
	public Set<Review> getReviewsByMovieId(String id) {
		log.info("In reviews service, id: " + id);
		return reviewRepo.getReviewsByMovieId(id);
	}

	public Set<Review> getReviewsByUserId(int id) {
		log.info("In reviews service, id: " + id);
		return reviewRepo.getReviewsByUserId(id);
	}
	
	@Transactional
	public void createNewReview(Review rev) {
		log.info("In post reviews service: " + rev);
		reviewRepo.createReview(rev);
		reviewRepo.updateMovieAverage(rev);
	}
}
