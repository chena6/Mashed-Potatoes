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

import com.revature.entities.Credential;
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
		return (User) session.getAttribute("user");
	}
	
	@GetMapping("logout")
	public void logout(HttpSession session) {
		log.info("In logout controller for session " + session.getId());
		session.setAttribute("user", null);
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
	
	@ExceptionHandler(CustomHttpException.class)
	public ResponseEntity<String> customExceptionHandler(CustomHttpException e){
		return new ResponseEntity<>(e.getMessage(), e.getStatus());
	}
  
  	@PostMapping("ban={id}")
	public User ban(@PathVariable int id) {
		return us.banByUserId(id);
	}
	
	@PostMapping("ruser={id}")
	public User setRoleToUser(@PathVariable int id) {
		return us.setRoleToUser(id);
	}
	
	@PostMapping("radmin={id}")
	public User setRoleToAdmin(@PathVariable int id) {
		return us.setRoleToAdmin(id);
	}
}
