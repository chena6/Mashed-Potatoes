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

	public void findByUsernameAndPassword(String username, String password) {
			ud.findByUsernameAndPassword(username, password);
		
	}
	
	
}
