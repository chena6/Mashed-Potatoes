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

import com.revature.daos.interfaces.BacklogDAO;
import com.revature.entities.Backlog;
import com.revature.entities.Movie;
import com.revature.entities.Watched;

@Repository
public class BacklogHibernate implements BacklogDAO {

		@Autowired
		SessionFactory sf;

		@Override
		@Transactional
		public void addMovieToBacklog(Backlog b) {
			Session sess = sf.getCurrentSession();
			sess.persist(b);
			
		}

		@Override
		@Transactional
		public Set<Movie> getBacklog(int id) {
			Session sess = sf.getCurrentSession();

			Criteria crit = sess.createCriteria(Backlog.class);
			crit.add(Restrictions.eq("user.id", id)	);
			Set<Backlog> set = new HashSet<Backlog>(crit.list());
			Set<Movie> movies = new HashSet<Movie>();
			
			for(Backlog log: set) {
				movies.add(log.getMovie());
			}
			
			return movies;
		}

		@Override
		public void deleteMovieFromBacklog(Backlog b) {
			Session sess = sf.getCurrentSession();
			Criteria crit = sess.createCriteria(Backlog.class);
			crit.add(Restrictions.eq("user", b.getUser()));
			crit.add(Restrictions.eq("movie", b.getMovie()));
			Movie m = (Movie) crit.uniqueResult();
			sess.delete(m);
		}
		
		
}
