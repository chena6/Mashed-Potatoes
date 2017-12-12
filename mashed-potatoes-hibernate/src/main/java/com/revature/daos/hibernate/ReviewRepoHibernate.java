package com.revature.daos.hibernate;

import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.interfaces.ReviewDAO;
import com.revature.entities.Comment;
import com.revature.entities.Review;
import com.revature.entities.User;

@Repository
public class ReviewRepoHibernate implements ReviewDAO {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	SessionFactory sf;
	
	@Transactional
	@Override
	public Set<Review> getAllReviews() {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(Review.class);
		cr.add(Restrictions.gt("id", 0));
		
		return new HashSet<Review>(cr.list());
	}
	
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
	
	@Override
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void createReview(Review rev) {
		log.info("Attempting to persist review rev...");
		Session sess = sf.getCurrentSession();
		
		sess.persist(rev);
	}
	
	@Override
	@Transactional
	public void updateMovieAverage(Review rev) {
		log.info("Attempting to update movie score for review rev...");
		Session sess = sf.getCurrentSession();
		
		Query avgQuery = sess.getNamedQuery("callMovieAverageStoredProcedure");
		avgQuery.setParameter("movieId", rev.getMovie_id());
		avgQuery.executeUpdate();
	}

	@Override
	@Transactional
	public void deleteReview(int id) {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(Review.class);
		cr.add(Restrictions.eq("id", id));
		Review r = (Review) cr.uniqueResult();
		session.delete(r);
		
	}
}
