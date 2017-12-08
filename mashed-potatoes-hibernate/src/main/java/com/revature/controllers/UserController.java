package com.revature.controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.entities.Credential;
import com.revature.entities.User;

@RestController
@RequestMapping("users")
public class UserController {
	
	@PostMapping("login")
	public User login(@RequestBody Credential cred) {
		if("user".equals(cred.getUsername()) && "password".equals(cred.getPassword())) {
			//us.getUserById();
			return new User();
        } else {
            return null;
        }
	}
}
