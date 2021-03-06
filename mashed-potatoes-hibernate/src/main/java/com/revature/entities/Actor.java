package com.revature.entities;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

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
	
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "movie_actor", 
		joinColumns = @JoinColumn(name="actor_id"),
		inverseJoinColumns = @JoinColumn(name="movie_id")
	)
	@JsonBackReference
	private Set<Movie> starredIn;

	public Actor() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Actor(int id, String firstname, String lastname, Set<Movie> starredIn) {
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

	public Set<Movie> getStarredIn() {
		return starredIn;
	}

	public void setStarredIn(Set<Movie> starredIn) {
		this.starredIn = starredIn;
	}

	@Override
	public String toString() {
		return "Actor [id=" + id + ", firstname=" + firstname + ", lastname=" + lastname + "]";
	}
}
