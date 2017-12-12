package com.revature.aspects;

import java.util.Arrays;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.revature.entities.AuthObject;
import com.revature.entities.User;
import com.revature.exceptions.CustomHttpException;
import com.revature.exceptions.InvalidCredentialException;
import com.revature.services.UserService;

@Component
@Aspect
public class AuthenticationAspect {
	
	private Logger log = Logger.getRootLogger();
	
	@Autowired
	private UserService us;
	
	@Around("authMethods()")
	public Object authAroundAll(ProceedingJoinPoint pjp) {
		
		log.info("AOP: Authenticating action for " + pjp.getSignature() + "...");
		
		AuthObject input = (AuthObject) pjp.getArgs()[0];
		log.info(input);
		
		User authUser = getUserFromAuthObject(input);
		
		Object returnObject = null;
		int minLevel = getAuthorityLevel(pjp.getSignature().getName());
		
		if(authUser == null) { // 401 Unauthorized.
			
			CustomHttpException e = new InvalidCredentialException("Invalid username or password.");
			returnObject = new ResponseEntity<>(e.getMessage(), e.getStatus());
			
		} else if (minLevel > authUser.getRoleid()) {
			
			CustomHttpException e = new InvalidCredentialException("Insufficient privileges to use this command.");
			returnObject = new ResponseEntity<>(e.getMessage(), e.getStatus());
			
		} else {
			try {
				returnObject = pjp.proceed();
			} catch (Throwable t) {
				log.warn("Auth AOP: Method " + pjp.getSignature() + " threw " + t.getMessage());
				log.warn(Arrays.toString(t.getStackTrace()));
				returnObject = null;
			}
		}
		
		return returnObject;
	}
	
	private User getUserFromAuthObject(AuthObject input) {
		
		if(input.getCred() == null) {
			return null;
		} else {
			if(input.getCred().getUsername() == null || input.getCred().getPassword() == null) {
				return null;
			} else {
				return us.findByUsernameAndPassword(input.getCred().getUsername(), input.getCred().getPassword());
			}
		}
	}
	
	// [Micah] This is sort of an extrapolation of the concept applied by Spring Data.
	// This method takes in the method name of a Proceeding Join Point and figures the 
	// level of authority a given user needs to execute it based purely on that. If none can be found,
	// the guest user is assumed, and all requests made to that method pass automatically.
	public int getAuthorityLevel(String method) {
		log.info("Getting minimum authority level required to execute " + method);
		
		int level = 0;
		
		if(method != null) {
			method = method.toLowerCase();
			
			if(method.contains("moderator")) {
				level = 3;
			} else if (method.contains("social")) {
				level = 2;
			} else if (method.contains("basic")) {
				level = 1;
			}
		}
		
		log.info("Getting minimum level found: " + level);
		return level;
	}
	
	@Pointcut("execution(* com.revature.*..*(com.revature.entities.AuthObject))")
	public void authMethods() { }
}
