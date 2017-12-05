package com.revature.daos.hibernate;

import org.hibernate.Session;

import com.revature.daos.interfaces.MovieDAO;
import com.revature.entities.Movie;
import com.revature.util.SessionUtil;

public class MovieHibernate implements MovieDAO {

	public Movie get(String id) {
		
		Session sess = SessionUtil.getSessionUtil().getSession();
		Movie b = (Movie) sess.get(Movie.class, id);
		
		sess.close();
		return b;
	}
	
}
