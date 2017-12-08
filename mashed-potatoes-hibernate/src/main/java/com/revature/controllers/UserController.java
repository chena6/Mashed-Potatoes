package com.revature.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
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
public class UserController {
	
	@Autowired
	UserService us;
	
	@PostMapping("login")
	public User login(@RequestBody Credential cred) {
		if("user".equals(cred.getUsername()) && "password".equals(cred.getPassword())) {
            //us.getUserById();
			return new User();
        } else {
            return null;
        }
	}
	
	@PostMapping("register")
	public void register(@RequestBody User user) {
		us.registerUser(user);
	}
	
	@ExceptionHandler(CustomHttpException.class)
	public ResponseEntity<String> customExceptionHandler(CustomHttpException e){
		return new ResponseEntity<>(e.getMessage(), e.getStats());
	}
}
