package com.revature.daos.hibernate;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import com.revature.daos.interfaces.MovieDAO;
import com.revature.entities.Movie;
import com.revature.util.SessionUtil;

@Repository
public class MovieHibernate implements MovieDAO {

	Logger log = Logger.getRootLogger();
	
	//@Autowired
	//private SessionFactory sf;
	
	public Movie get(String id) {
		
		log.info("Attempting to get movie by id.");
		Session sess = SessionUtil.getSessionUtil().getSession();//sf.getCurrentSession();
		Movie b = (Movie) sess.get(Movie.class, id);
		
		sess.close();
		return b;
	}
}
