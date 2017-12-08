package com.revature.daos.hibernate;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.revature.daos.interfaces.DirectorDAO;
import com.revature.entities.Director;

@Repository
public class DirectorHibernate implements DirectorDAO {
	
	@Autowired
	SessionFactory sf;
	
	@Override
	public Director get(int id) {
		
		Session sess = sf.getCurrentSession();
		Director b = (Director) sess.get(Director.class, id);
		
		return b;
	}
	
}
