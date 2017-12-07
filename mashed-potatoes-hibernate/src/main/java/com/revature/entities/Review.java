package com.revature.entities;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user_reviews")
public class Review implements Serializable {
	
	// [Eclipse] Generated Field
	private static final long serialVersionUID = 1778935356125898337L;
	
	@Id
	private int user_id;
	@Id
	private String movie_id;
	
	private String review;

	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Review(int user_id, String movie_id, String review) {
		super();
		this.user_id = user_id;
		this.movie_id = movie_id;
		this.review = review;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((movie_id == null) ? 0 : movie_id.hashCode());
		result = prime * result + ((review == null) ? 0 : review.hashCode());
		result = prime * result + user_id;
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
		Review other = (Review) obj;
		if (movie_id == null) {
			if (other.movie_id != null)
				return false;
		} else if (!movie_id.equals(other.movie_id))
			return false;
		if (review == null) {
			if (other.review != null)
				return false;
		} else if (!review.equals(other.review))
			return false;
		if (user_id != other.user_id)
			return false;
		return true;
	}
}
