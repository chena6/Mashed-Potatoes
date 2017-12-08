package com.revature.daos.hibernate;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.interfaces.UserDAO;
import com.revature.entities.User;

@Repository
public class UserRepoHibernate implements UserDAO {

	@Autowired
	private SessionFactory sf;

	@Override
	public void registerUser(User u) {
		Session session = sf.getCurrentSession();
		session.persist(u);
	}

	@Transactional
	@Override
	public User findByUsernameAndPassword(String username, String password) {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(User.class);
		cr.add(Restrictions.ilike("username", username));
		cr.add(Restrictions.ilike("password", password));

		User u = (User) cr.uniqueResult();
		return u;

	}

}
