package com.revature.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "actors")
public class Actor {

	@Id
	@Column(name = "actor_id")
	@SequenceGenerator(name = "actor_id_seq", sequenceName = "actor_id_seq")
	@GeneratedValue(generator = "actor_id_seq", strategy = GenerationType.AUTO)
	private int id;
	
	private String firstname;
	private String lastname;
	
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Movie> starredIn;

	public Actor() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Actor(int id, String firstname, String lastname, List<Movie> starredIn) {
		super();
		this.id = id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.starredIn = starredIn;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public List<Movie> getStarredIn() {
		return starredIn;
	}

	public void setStarredIn(List<Movie> starredIn) {
		this.starredIn = starredIn;
	}

	@Override
	public String toString() {
		return "Actor [id=" + id + ", firstname=" + firstname + ", lastname=" + lastname + "]";
	}
}
