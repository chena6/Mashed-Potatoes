package com.revature.exceptions;

import org.springframework.http.HttpStatus;

public class InvalidCredentialException extends CustomHttpException {
	
	// [Eclipse] Generated Field
	private static final long serialVersionUID = -8734503972931428583L;
	private HttpStatus status = HttpStatus.UNAUTHORIZED;
	
	public InvalidCredentialException() {
		super();
	}
	
	public InvalidCredentialException(String message) {
		super(message);
	}
	
	@Override
	public HttpStatus getStatus() {
		return status;
	}

}
