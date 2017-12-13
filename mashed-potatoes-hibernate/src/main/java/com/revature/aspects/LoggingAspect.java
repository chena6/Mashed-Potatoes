package com.revature.aspects;

import java.util.Arrays;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.revature.services.UserService;

@Component
@Aspect
public class LoggingAspect {
	
	private Logger log = Logger.getRootLogger();
	
	@Autowired
	UserService us;
	
	@Around("logMethods()")
	public Object aroundAll(ProceedingJoinPoint pjp) {
		log.info("AOP: Executing method " + pjp.getSignature() + ".");
		
		Object[] args = pjp.getArgs();
		Arrays.stream(args).forEach(log::trace);
		
		Object returnObject = null;
		
		try {
			returnObject = pjp.proceed();
		} catch (Throwable t) {
			log.info("AOP: Method " + pjp.getSignature() + " threw " + t.getMessage());
			log.warn(Arrays.toString(t.getStackTrace()));
		}
		log.info(pjp.getSignature() + " finished.");
		
		return returnObject;
	}
	
	
	@Pointcut("execution(* com.revature.*..*(..))")
	public void logMethods() {}
	
}
