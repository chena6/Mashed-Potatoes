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

import com.revature.daos.interfaces.UserDAO;
import com.revature.entities.User;

@Repository
public class UserRepoHibernate implements UserDAO {

	@Autowired
	private SessionFactory sf;

	
	@Transactional
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

	@Transactional
	@Override
	public User getUserById(int id) {
		
		Session session = sf.getCurrentSession();
		User u = (User) session.get(User.class, id);
		
		return u;
	}
	
	@Transactional
	@Override
	public Set<User> getAllUsers() {
		Session session = sf.getCurrentSession();
		Criteria cr = session.createCriteria(User.class);
		cr.add(Restrictions.gt("id", 0));
		
		return new HashSet<User>(cr.list());
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
