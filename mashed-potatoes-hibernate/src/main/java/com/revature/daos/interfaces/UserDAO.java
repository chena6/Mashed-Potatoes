package com.revature.daos.interfaces;

import com.revature.entities.User;

public interface UserDAO {
	
	public void registerUser(User u);

	public User findByUsernameAndPassword(String username, String password);

	public User getUserById(int id);
	
}
