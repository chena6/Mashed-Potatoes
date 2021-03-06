package com.revature.controllers;

import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.entities.AuthObject;
import com.revature.entities.Credential;
import com.revature.entities.Movie;
import com.revature.entities.User;
import com.revature.exceptions.CustomHttpException;
import com.revature.services.UserService;

@RestController
@RequestMapping("users")
@CrossOrigin(origins = "http://localhost:4200")
public class UserController {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	UserService us;
	
	@GetMapping("all")
	public Set<User> getAllUsers() {
		return us.getAllUsers();
	}
	
	@GetMapping("{id}")
	public User getUserById(@PathVariable int id) {
		return us.getUserById(id);
	}
	
	@GetMapping("login")
	public User getLogin(HttpSession session) {
		
		log.info("In get current login for session " + session.getId());
		return null;
	}
	
	@GetMapping("logout")
	public void logout(HttpSession session) {
		log.info("In logout controller for session " + session.getId());
	}
	
	@PostMapping("login")
	public User login(HttpSession session, @RequestBody Credential cred) {
		log.info("In login controller: " + cred + " for session " + session.getId());
		User newLogin = us.findByUsernameAndPassword(cred.getUsername(), cred.getPassword());
		session.setAttribute("user", newLogin);
		return newLogin;
	}
	
	@PostMapping("register")
	public void register(@RequestBody User user) {
		us.registerUser(user);
	}
	
	@PostMapping("ban={id}")
	public User adminBan(@RequestBody AuthObject auth, @PathVariable int id) {
		return us.banByUserId(id);
	}
	
	@PostMapping("ruser={id}")
	public User adminSetRoleToUser(@RequestBody AuthObject auth, @PathVariable int id) {
		return us.setRoleToUser(id);
	}
	
	@PostMapping("radmin={id}")
	public User adminSetRoleToAdmin(@RequestBody AuthObject auth, @PathVariable int id) {
		return us.setRoleToAdmin(id);
	}
	
	@PostMapping("watched={id}-{mid}")
	public Object personalAddMovieToWatched(@RequestBody AuthObject auth, @PathVariable int id, @PathVariable String mid) {
		us.addMovieToWatched(id, mid);
		return null;
	}
	
	@GetMapping("watched/{id}")
	public Set<Movie> getWatched(@PathVariable int id){
		return us.getWatched(id);
	}
	
	@PostMapping("backlog={id}-{mid}")
	public Object personalAddMovieToBacklog(@RequestBody AuthObject auth, @PathVariable int id, @PathVariable String mid) {
		us.addMovieToBacklog(id,mid);
		return null;
	}
	
	@GetMapping("backlog/{id}")
	public Set<Movie> getBacklog(@PathVariable int id){
		return us.getBacklog(id);
	}
	
	@PostMapping("backlog/delete={id}-{mid}")
	public Object personalDeleteMovieFromBacklog(@RequestBody AuthObject auth, @PathVariable int id, @PathVariable String mid) {
		us.deleteMovieFromBacklog(id, mid);
		return null;
	}
	
	@PostMapping("watched/delete={id}-{mid}")
	public Object personalDeleteMovieFromWatched(@RequestBody AuthObject auth, @PathVariable int id, @PathVariable String mid) {
		us.deleteMovieFromWatched(id, mid);
		return null;
	}

	@ExceptionHandler(CustomHttpException.class)
	public ResponseEntity<String> customExceptionHandler(CustomHttpException e){
		return new ResponseEntity<>(e.getMessage(), e.getStatus());
	}
}