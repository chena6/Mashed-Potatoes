package com.revature.entities;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "directors")
public class Director {

	@Id
	@Column(name = "director_id")
	@SequenceGenerator(name = "director_id_seq", sequenceName = "director_id_seq")
	@GeneratedValue(generator = "director_id_seq", strategy = GenerationType.AUTO)
	private int id;
	
	private String firstname;
	private String lastname;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "director")
	@JsonBackReference
	private Set<Movie> directed;
	
	public Director() {
		super();
	}

	public Director(int id, String firstname, String lastname, Set<Movie> directed) {
		super();
		this.id = id;
		this.firstname = firstname;
		this.lastname = lastname;
		this.directed = directed;
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

	public Set<Movie> getDirected() {
		return directed;
	}

	public void setDirected(Set<Movie> directed) {
		this.directed = directed;
	}

	@Override
	public String toString() {
		return "Director [id=" + id + ", firstname=" + firstname + ", lastname=" + lastname /*+ ", directed=" + directed*/
				+ "]";
	}
}
