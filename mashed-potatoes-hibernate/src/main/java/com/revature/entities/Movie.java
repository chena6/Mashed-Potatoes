package com.revature.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "movies")
public class Movie {
	
	@Id
	@Column(name = "MOVIE_ID")
	private String id;
	
	private String title;
	private String year;
	private double rating;
	private String runtime;
	
	@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name = "director")
	private Director director;
	
	private String plot;
	private String poster;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "movie_genre", 
		joinColumns = @JoinColumn(name="movie_id"),
		inverseJoinColumns = @JoinColumn(name="genre_id")
	)
	private List<Genre> genres;
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "movie_actor", 
		joinColumns = @JoinColumn(name="movie_id"),
		inverseJoinColumns = @JoinColumn(name="actor_id")
	)
	private List<Actor> actors;
	
	
	public Movie() {
		super();
	}

	public Movie(String id, String title, String year, double rating, String runtime, Director director, String plot,
			String poster, List<Genre> genres, List<Actor> actors) {
		super();
		this.id = id;
		this.title = title;
		this.year = year;
		this.rating = rating;
		this.runtime = runtime;
		this.director = director;
		this.plot = plot;
		this.poster = poster;
		this.genres = genres;
		this.actors = actors;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public String getRuntime() {
		return runtime;
	}

	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}

	public Director getDirector() {
		return director;
	}

	public void setDirector(Director director) {
		this.director = director;
	}

	public String getPlot() {
		return plot;
	}

	public void setPlot(String plot) {
		this.plot = plot;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public List<Genre> getGenres() {
		return genres;
	}

	public void setGenres(List<Genre> genres) {
		this.genres = genres;
	}

	public List<Actor> getActors() {
		return actors;
	}

	public void setActors(List<Actor> actors) {
		this.actors = actors;
	}
	
	@Override
	public String toString() {
		return "Movie [id=" + id + ", title=" + title + ", year=" + year + ", rating=" + rating + ", runtime=" + runtime
				+ ", director=" + director + ", plot=" + plot + ", poster=" + poster + ", genres=" + genres
				+ ", actors=" + actors + "]";
	}
}
