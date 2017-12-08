package com.revature.exceptions;

import org.springframework.http.HttpStatus;

public class InvalidCredentialException extends CustomHttpException {
	
	
	
	public InvalidCredentialException() {
		super();	
	}
	
	public InvalidCredentialException(String message) {
		super(message);
	}
	
	@Override
	public HttpStatus getStats() {
		return status;
	}
}
