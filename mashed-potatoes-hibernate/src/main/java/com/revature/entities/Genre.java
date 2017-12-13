package com.revature.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "genres")
public class Genre {
	
	@Id
	@Column(name = "genre_id")
	@SequenceGenerator(name = "genre_id_seq", sequenceName = "genre_id_seq")
	@GeneratedValue(generator = "genre_id_seq", strategy = GenerationType.AUTO)
	private int id;
	
	String genre;
	
	public Genre() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Genre(int id, String genre) {
		super();
		this.id = id;
		this.genre = genre;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	@Override
	public String toString() {
		return "Genre [id=" + id + ", genre=" + genre + "]";
	}
	
	
}
