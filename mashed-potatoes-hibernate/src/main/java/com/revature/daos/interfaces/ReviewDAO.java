package com.revature.daos.interfaces;

import java.util.Set;

import com.revature.entities.Review;

public interface ReviewDAO {
	
	/**
	 * @param id
	 * @return Returns a set of reviews from the given Movie ID.
	 */
	Set<Review> getReviewsByMovieId(String id);
	
	/**
	 * @param id
	 * @return Returns a set of reviews from the given Movie ID.
	 */
	Set<Review> getReviewsByUserId(int id);
	
}
