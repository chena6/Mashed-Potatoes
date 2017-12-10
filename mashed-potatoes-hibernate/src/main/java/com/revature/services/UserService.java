package com.revature.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.hibernate.UserRepoHibernate;
import com.revature.daos.interfaces.UserDAO;
import com.revature.entities.User;
@Service
public class UserService {
	
	@Autowired 
	UserDAO ud;
	
	@Transactional
	public void registerUser(User u) {
		
	}

	public User findByUsernameAndPassword(String username, String password) {
		return ud.findByUsernameAndPassword(username, password);
	}
	
	public User getUserById(int id) {
		return ud.getUserById(id);
	}
	
	
}
