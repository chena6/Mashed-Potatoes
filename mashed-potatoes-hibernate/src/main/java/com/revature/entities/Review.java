package com.revature.entities;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "reviews")
public class Review implements Serializable {

	// [Eclipse] Generated Field
	private static final long serialVersionUID = 1778935356125898337L;

	@Id
	@Column(name = "review_id")
	@SequenceGenerator(name = "review_id_seq", sequenceName = "review_id_seq")
	@GeneratedValue(generator = "review_id_seq", strategy = GenerationType.AUTO)
	private int id;

	@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name = "user_id")
	private User user;
	private String movie_id;

	private String review;
	private int score;

	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Review(int id, User user, String movie_id, String review, int score) {
		super();
		this.id = id;
		this.user = user;
		this.movie_id = movie_id;
		this.review = review;
		this.score = score;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((movie_id == null) ? 0 : movie_id.hashCode());
		result = prime * result + ((review == null) ? 0 : review.hashCode());
		result = prime * result + score;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
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
		if (id != other.id)
			return false;
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
		if (score != other.score)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Review [id=" + id + ", user=" + user + ", movie_id=" + movie_id + ", review=" + review + ", score="
				+ score + "]";
	}

}
