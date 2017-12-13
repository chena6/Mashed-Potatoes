package com.revature.daos.interfaces;

import java.util.Set;

import com.revature.entities.Movie;

public interface MovieDAO {

	/**
	 * @param id
	 * @return Returns the movie with the given ID.
	 */
	public Movie get(String id);

	/**
	 * @param title
	 * @return Returns set of movies with a word in the title.
	 */
	public Set<Movie> getMoviesByTitle(String title);

	/**
	 * @param plot
	 * @return Returns set of movies with a word in the plot.
	 */
	public Set<Movie> getMoviesByPlot(String plot);

	/**
	 * @param year
	 * @return Returns set of movies that came out on a given year.
	 */
	public Set<Movie> getMoviesByYear(int year);

	/**
	 * @param genre
	 * @return Returns set of movies that fall within a given genre.
	 */
	public Set<Movie> getMoviesByGenre(String genre);
	
	/**
	 * @param rating
	 * @return Returns set of movies that fall within a given age rating.
	 */
	public Set<Movie> getMoviesByRating(String rating);
	
	/**
	 * @param name
	 * @return Returns a set of movies that have a given actor's name, first or last.
	 */
	public Set<Movie> getMoviesByActor(String name);
	
	/**
	 * @return Returns a set of all movies in the database.
	 */
	public Set<Movie> getAllMovies();
	
	/**
	 * @return Returns first 20 movies by rating.
	 */
	public Set<Movie> getTopRatedMovies();

}
