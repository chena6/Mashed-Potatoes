package com.revature.controllers;

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
	
	@GetMapping("{id}")
	public User getUserById(@PathVariable int id) {
		return us.getUserById(id);
	}
	
	@GetMapping("login")
	public User getLogin(HttpSession session) {
		
		return null;
	}
	
	@PostMapping("login")
	public User login(@RequestBody Credential cred) {
            us.findByUsernameAndPassword(cred.getUsername(), cred.getPassword());
            return null;
	}
	
	@PostMapping("register")
	public void register(@RequestBody User user) {
		us.registerUser(user);
	}
	
	@ExceptionHandler(CustomHttpException.class)
	public ResponseEntity<String> customExceptionHandler(CustomHttpException e){
		return new ResponseEntity<>(e.getMessage(), e.getStatus());
	}
}
