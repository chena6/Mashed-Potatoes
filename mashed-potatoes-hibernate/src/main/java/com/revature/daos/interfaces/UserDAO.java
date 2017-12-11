package com.revature.daos.interfaces;

import java.util.Set;

import com.revature.entities.User;

public interface UserDAO {
	
	public void registerUser(User u);

	public User findByUsernameAndPassword(String username, String password);

	public User getUserById(int id);
	
	/**
	 * @return
	 */
	public Set<User> getAllUsers();
	
	public User banByUserId(int id);

	public User setRoleToUser(int id);

	public User setRoleToAdmin(int id);
	
}
