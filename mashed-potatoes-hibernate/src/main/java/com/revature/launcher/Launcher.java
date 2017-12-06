package com.revature.launcher;

import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.XmlWebApplicationContext;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.revature.daos.hibernate.DirectorHibernate;
import com.revature.daos.hibernate.MovieHibernate;
import com.revature.daos.interfaces.DirectorDAO;
import com.revature.daos.interfaces.MovieDAO;
import com.revature.entities.Director;
import com.revature.entities.Movie;


public class Launcher {
	
	//private static MovieDAO daoMovie = new MovieHibernate();
	private static DirectorDAO daoDirector = new DirectorHibernate();
	
	public static void main(String[] args) {
		
		ApplicationContext ac = new XmlWebApplicationContext();
		MovieDAO daoMovie = (MovieDAO) ac.getBean("movrepo");
		
		Movie mov = daoMovie.get("tt3896198");
		
		String json = JSONStringify(mov);
		Director dir = mov.getDirector();
		//Director dir = daoDirector.get(1);
		
		System.out.println(json);
	}
	
	public static String JSONStringify(Object obj) {
		try {
			ObjectMapper map = new ObjectMapper();
			ObjectWriter writer = map.writer().withDefaultPrettyPrinter();
			String json = writer.writeValueAsString(obj);
			return json;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
}
