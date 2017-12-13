package com.revature.launcher;

import com.revature.daos.hibernate.CommentHibernate;
import com.revature.daos.interfaces.CommentDAO;

public class Launcher {
	
	//private static MovieDAO daoMovie = new MovieHibernate();
	//private static DirectorDAO daoDirector = new DirectorHibernate();
	
	public static void main(String[] args) {
		
		//ApplicationContext ac = new XmlWebApplicationContext();
		//MovieDAO daoMovie = (MovieDAO) ac.getBean("movrepo");
		//
		//Movie mov = daoMovie.get("tt3896198");
		//
		//String json = JSONStringify(mov);
		//Director dir = mov.getDirector();
		//Director dir = daoDirector.get(1);
		//
		//System.out.println(json);
		//
		//ac.close();
		
		CommentDAO daoComment = new CommentHibernate();
		
	}
	
}
