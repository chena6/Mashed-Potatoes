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
public class UserHibernate implements UserDAO {

	@Autowired
	private SessionFactory sf;

	@Override
	public void registerUser(User u) {
		Session session = sf.getCurrentSession();
		session.persist(u);
	}

	@Override
	@Transactional
	public User findByUsernameAndPassword(String username, String password) {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(User.class);
		cr.add(Restrictions.ilike("username", username));
		cr.add(Restrictions.ilike("password", password));

		User u = (User) cr.uniqueResult();
		return u;

	}

	@Override
	@Transactional
	public User banByUserId(int id) {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(User.class);
		cr.add(Restrictions.eq("id", id));
		User u = (User) cr.uniqueResult();
		u.setRoleid(1);
		session.persist(u);
		return u;
	}

	@Override
	@Transactional
	public User setRoleToUser(int id) {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(User.class);
		cr.add(Restrictions.eq("id", id));
		User u = (User) cr.uniqueResult();
		u.setRoleid(2);
		session.persist(u);
		return u;
	}

	@Override
	@Transactional
	public User setRoleToAdmin(int id) {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(User.class);
		cr.add(Restrictions.eq("id", id));
		User u = (User) cr.uniqueResult();
		u.setRoleid(3);
		session.persist(u);
		return u;
	}

}
