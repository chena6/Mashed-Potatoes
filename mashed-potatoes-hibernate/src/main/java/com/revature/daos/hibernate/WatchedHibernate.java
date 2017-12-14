package com.revature.daos.hibernate;

import java.util.HashSet;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.interfaces.WatchedDAO;
import com.revature.entities.Movie;
import com.revature.entities.Watched;

@Repository
public class WatchedHibernate implements WatchedDAO {

	@Autowired
	SessionFactory sf;
	
	@Override
	@Transactional
	public void addMovieToWatched(Watched w) {
		Session sess = sf.getCurrentSession();
		sess.persist(w);
		
	}

	@Override
	@Transactional
	public Set<Movie> getWatched(int id) {
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Watched.class);
		crit.add(Restrictions.eq("user.id", id));
		Set<Watched> set = new HashSet<Watched>(crit.list());
		Set<Movie> movies = new HashSet<Movie>();
		
		for(Watched watch: set) {
			movies.add(watch.getMovie());
		}
		return movies;
	}
	
	@Override
	@Transactional
	public void deleteMovieFromWatched(Watched w) {
		Session sess = sf.getCurrentSession();
		Criteria crit = sess.createCriteria(Watched.class);
		crit.add(Restrictions.eq("user", w.getUser()));
		crit.add(Restrictions.eq("movie", w.getMovie()));
		Movie m = (Movie) crit.uniqueResult();
		sess.delete(m);
	}
	
}
