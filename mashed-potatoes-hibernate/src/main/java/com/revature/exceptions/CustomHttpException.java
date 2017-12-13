package com.revature.exceptions;

import org.springframework.http.HttpStatus;

public abstract class CustomHttpException extends Exception {
	
	// [Eclipse] Generated Field
	private static final long serialVersionUID = -1547208911554696112L;

	public CustomHttpException() {
		super();
	}
	
	public CustomHttpException(String message) {
		super(message);
	}
	
	public abstract HttpStatus getStatus();
}
