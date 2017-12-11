package com.revature.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.entities.Credential;
import com.revature.entities.User;
import com.revature.services.UserService;

@RestController
@RequestMapping("users")
public class UserController {
	
	@Autowired
	UserService us;
	
	@PostMapping("login")
	public User login(@RequestBody Credential cred) {
            return us.findByUsernameAndPassword(cred.getUsername(), cred.getPassword());
	}
	
	@PostMapping("register")
	public void register(@RequestBody User user) {
		us.registerUser(user);
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
/*	@ExceptionHandler(CustomHttpException.class)
	public ResponseEntity<String> customExceptionHandler(CustomHttpException e){
		return new ResponseEntity<>(e.getMessage(), e.getStats());
	}*/
}
