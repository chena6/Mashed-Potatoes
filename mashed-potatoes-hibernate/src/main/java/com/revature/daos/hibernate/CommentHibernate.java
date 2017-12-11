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

import com.revature.daos.interfaces.CommentDAO;
import com.revature.entities.Comment;

@Repository
public class CommentHibernate implements CommentDAO {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	SessionFactory sf;
	
	@Override
	@Transactional
	public Set<Comment> getCommentsByMovieId(String id) {
		
		log.info("Attempting to get comments by movie id.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Comment.class);
		crit.add(Restrictions.ilike("movie_id", id));

		return new HashSet<Comment>(crit.list());
	}
	
	@Override
	@Transactional
	public Set<Comment> getCommentsByUserId(int id) {
		
		log.info("Attempting to get comments by user id.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Comment.class);
		crit.add(Restrictions.eq("user.id", id));

		return new HashSet<Comment>(crit.list());
	}

	@Override
	@Transactional
	public void createComment(Comment comm) {
		log.info("Attempting to persist comment comm...");
		Session sess = sf.getCurrentSession();
		
		sess.persist(comm);
	}
}
