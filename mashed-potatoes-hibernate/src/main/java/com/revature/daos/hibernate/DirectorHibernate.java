package com.revature.daos.hibernate;

import org.hibernate.Session;

import com.revature.daos.interfaces.DirectorDAO;
import com.revature.entities.Director;
import com.revature.util.SessionUtil;

public class DirectorHibernate implements DirectorDAO {

	@Override
	public Director get(int id) {
		
		Session sess = SessionUtil.getSessionUtil().getSession();
		Director b = (Director) sess.get(Director.class, id);
		
		sess.close();
		return b;
	}
	
}
