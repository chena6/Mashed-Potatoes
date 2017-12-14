package com.revature.daos.hibernate;

import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.revature.daos.interfaces.MovieDAO;
import com.revature.entities.Movie;

@Repository
public class MovieHibernate implements MovieDAO {

	Logger log = Logger.getRootLogger();

	@Autowired
	private SessionFactory sf;

	@Override
	@Transactional
	public Movie get(String id) {

		log.info("Attempting to get movie by id.");
		Session sess = sf.getCurrentSession();
		Movie b = (Movie) sess.get(Movie.class, id);

		return b;
	}

	@Override
	@Transactional
	public Set<Movie> getMoviesByTitle(String title) {

		log.info("Attempting to get movie by title.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Movie.class);
		crit.add(Restrictions.ilike("title", title, MatchMode.ANYWHERE));

		return new HashSet<Movie>(crit.list());
	}

	@Override
	@Transactional
	public Set<Movie> getMoviesByPlot(String plot) {

		log.info("Attempting to get movie by plot.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Movie.class);
		crit.add(Restrictions.ilike("plot", plot, MatchMode.ANYWHERE));

		return new HashSet<Movie>(crit.list());
	}

	@Override
	@Transactional
	public Set<Movie> getMoviesByYear(int year) {
		log.info("Attempting to get movies by year.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Movie.class);
		crit.add(Restrictions.eq("year", year));
		
		return new HashSet<Movie>(crit.list());
	}

	@Override
	@Transactional
	public Set<Movie> getMoviesByGenre(String genre) {

		log.info("Attempting to get movies by genre.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Movie.class);
		crit.createAlias("genres", "genresj"); // [Micah] Aliases force inner joins.
		crit.add(Restrictions.eq("genresj.genre", genre));

		return new HashSet<Movie>(crit.list());
	}
	
	@Override
	@Transactional
	public Set<Movie> getMoviesByRating(String rating) {

		log.info("Attempting to get movies by genre.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Movie.class);
		crit.createAlias("rating", "ratingj");
		crit.add(Restrictions.ilike("ratingj.rating", rating, MatchMode.ANYWHERE));

		return new HashSet<Movie>(crit.list());
	}
	
	@Override
	@Transactional
	public Set<Movie> getMoviesByActor(String name) {

		log.info("Attempting to get movies by genre.");
		Session sess = sf.getCurrentSession();

		Criteria crit = sess.createCriteria(Movie.class);
		
		crit.createAlias("actors", "actorsj");
		crit.add(Restrictions.disjunction()
				.add(Restrictions.ilike("actorsj.firstname", name, MatchMode.ANYWHERE))
				.add(Restrictions.ilike("actorsj.lastname", name, MatchMode.ANYWHERE))
				);

		return new HashSet<Movie>(crit.list());
	}

	@Override
	@Transactional
	public Set<Movie> getAllMovies() {
		
		Session sess = sf.getCurrentSession();
		Criteria crit = sess.createCriteria(Movie.class);
		crit.add(Restrictions.isNotNull("title"));
		
		return new HashSet<Movie>(crit.list());
	}

	@Override
	@Transactional
	public Set<Movie> getTopRatedMovies() {
		Session sess = sf.getCurrentSession();
		
		Query query = sess.getNamedQuery("selectTop20");
		
		Set<Movie> movieSelect = new HashSet<Movie>(query.list());
		
		return movieSelect;
	}
}
