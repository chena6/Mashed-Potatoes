package com.revature.launcher;

import com.revature.daos.hibernate.DirectorHibernate;
import com.revature.daos.hibernate.MovieHibernate;
import com.revature.daos.interfaces.DirectorDAO;
import com.revature.daos.interfaces.MovieDAO;
import com.revature.entities.Director;
import com.revature.entities.Movie;

public class Launcher {
	
	private static MovieDAO daoMovie = new MovieHibernate();
	private static DirectorDAO daoDirector = new DirectorHibernate();
	
	public static void main(String[] args) {
		
		Movie mov = daoMovie.get("tt3896198");
		Director dir = mov.getDirector();
		//Director dir = daoDirector.get(1);
		
		System.out.println(mov);
	}
	
}
