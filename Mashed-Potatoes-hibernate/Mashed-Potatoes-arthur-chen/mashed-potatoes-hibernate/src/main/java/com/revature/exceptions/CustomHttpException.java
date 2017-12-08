package com.revature.exceptions;

import org.springframework.http.HttpStatus;

public class CustomHttpException extends Exception {
	HttpStatus status;
	
	public CustomHttpException() {
		super();
	}
	
	public CustomHttpException(String message) {
		super(message);
	}
	
	public HttpStatus getStats() {
		return status;
	}
}
