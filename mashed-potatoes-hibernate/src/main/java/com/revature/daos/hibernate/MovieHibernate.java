package com.revature.daos.hibernate;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.interfaces.MovieDAO;
import com.revature.entities.Movie;

@Repository
public class MovieHibernate implements MovieDAO {

	Logger log = Logger.getRootLogger();
	
	@Autowired
	private SessionFactory sf;
	
	@Transactional
	public Movie get(String id) {
		
		log.info("Attempting to get movie by id.");
		Session sess = sf.getCurrentSession();
		Movie b = (Movie) sess.get(Movie.class, id);
		
		return b;
	}
}
