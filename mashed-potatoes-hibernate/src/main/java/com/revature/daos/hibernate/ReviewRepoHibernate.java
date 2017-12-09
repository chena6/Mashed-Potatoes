package com.revature.daos.hibernate;

import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.interfaces.ReviewDAO;
import com.revature.entities.Review;

@Repository
public class ReviewRepoHibernate implements ReviewDAO {
	
Logger log = Logger.getRootLogger();
	
	@Autowired
	SessionFactory sf;
	
	@Override
	@Transactional
	public Set<Review> getReviewsByMovieId(String id) {
		log.info("Attempting to get reviews by movie id.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Review.class);
		crit.add(Restrictions.ilike("movie_id", id));

		return new HashSet<Review>(crit.list());
	}
	
	@Override
	@Transactional
	public Set<Review> getReviewsByUserId(int id) {
		log.info("Attempting to get reviews by movie id.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Review.class);
		crit.add(Restrictions.eq("user.id", id));

		return new HashSet<Review>(crit.list());
	}
}
