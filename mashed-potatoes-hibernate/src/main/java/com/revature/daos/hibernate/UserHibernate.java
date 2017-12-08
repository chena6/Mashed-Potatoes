package com.revature.daos.hibernate;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.revature.daos.interfaces.UserDAO;
import com.revature.entities.User;

public class UserHibernate implements UserDAO{

	@Autowired
	SessionFactory sf;
	
	@Override
	public void registerUser(User u) {
		Session session = sf.getCurrentSession();
		session.persist(u);
	}

}
