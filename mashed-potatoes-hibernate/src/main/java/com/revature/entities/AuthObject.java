package com.revature.entities;

public class AuthObject {

	private Credential cred;
	private Object data;

	public AuthObject() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AuthObject(Credential cred, Object data) {
		super();
		this.cred = cred;
		this.data = data;
	}

	public Credential getCred() {
		return cred;
	}

	public void setCred(Credential cred) {
		this.cred = cred;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cred == null) ? 0 : cred.hashCode());
		result = prime * result + ((data == null) ? 0 : data.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AuthObject other = (AuthObject) obj;
		if (cred == null) {
			if (other.cred != null)
				return false;
		} else if (!cred.equals(other.cred))
			return false;
		if (data == null) {
			if (other.data != null)
				return false;
		} else if (!data.equals(other.data))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "AuthObject [cred=" + cred + ", data=" + data + "]";
	}

}
