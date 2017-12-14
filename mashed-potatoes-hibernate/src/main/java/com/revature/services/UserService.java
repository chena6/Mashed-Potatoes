package com.revature.services;

import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.log4j.spi.RootLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.daos.interfaces.BacklogDAO;
import com.revature.daos.interfaces.MovieDAO;
import com.revature.daos.interfaces.UserDAO;
import com.revature.daos.interfaces.WatchedDAO;
import com.revature.entities.Backlog;
import com.revature.entities.Movie;
import com.revature.entities.User;
import com.revature.entities.Watched;
@Service
public class UserService {
	Logger log = Logger.getRootLogger();
	@Autowired 
	UserDAO ud;
	
	@Autowired
	BacklogDAO bd;
	
	@Autowired
	WatchedDAO wd;
	
	@Autowired
	MovieDAO md;
	
	public void registerUser(User u) {
		log.debug(u);
		u.setRoleid(2);
		ud.registerUser(u);
	}

	public User findByUsernameAndPassword(String username, String password) {
		return ud.findByUsernameAndPassword(username, password);
	}
	
	public User getUserById(int id) {
		return ud.getUserById(id);
	}

	public Set<User> getAllUsers() {
		return ud.getAllUsers();
	}
	
	public User banByUserId(int id) {
		return ud.banByUserId(id);
	}

	public User setRoleToUser(int id) {
		return ud.setRoleToUser(id);
	}

	public User setRoleToAdmin(int id) {
		return ud.setRoleToAdmin(id);
	}
	
	public void addMovieToWatched(int id, String mid){
		Watched w = new Watched(ud.getUserById(id), md.get(mid));
		wd.addMovieToWatched(w);
	}
	
	public Set<Movie> getWatched(int id){
		return wd.getWatched(id);
	}
	
	public void addMovieToBacklog(int id, String mid) {
		Backlog b = new Backlog(ud.getUserById(id), md.get(mid));
		bd.addMovieToBacklog(b); 
	}
	
	public Set<Movie> getBacklog(int id){
		return bd.getBacklog(id);
	}
	
	public void deleteMovieFromBacklog(int id, String mid) {
		Backlog b = new Backlog(ud.getUserById(id), md.get(mid));
		bd.deleteMovieFromBacklog(b);
	}
	
	public void deleteMovieFromWatched(int id, String mid) {
		Watched w = new Watched(ud.getUserById(id), md.get(mid));
		wd.deleteMovieFromWatched(w);
	}
}
