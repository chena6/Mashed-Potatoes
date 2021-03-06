package com.revature.controllers;

import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.entities.AuthObject;
import com.revature.entities.Comment;
import com.revature.services.CommentService;

@RestController
@RequestMapping("comments")
@CrossOrigin(origins = "http://localhost:4200")
public class CommentsController {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	CommentService csvc;
	
	@GetMapping("all")
	public Set<Comment> getAllComments() {
		return csvc.getAllComments();
	}
	
	@GetMapping("movie={id}")
	public Set<Comment> getCommentsByMovieId(@PathVariable String id) {
		
		log.info("In getCommentsByMovieId: " + id);
		return csvc.getCommentsByMovieId(id);
	}
	
	@GetMapping("user={id}")
	public Set<Comment> getCommentsByUserId(@PathVariable int id) {
		
		log.info("In getCommentsByUserId: " + id);
		return csvc.getCommentsByUserId(id);
	}
	
	@PostMapping
	public Object socialCreateComment(@RequestBody AuthObject auth) {
		Comment comm = auth.getComment();
		log.info("In new comment controller, :" + comm);
		csvc.createNewReview(comm);
		return null;
	}
	
	@PostMapping("delete")
 	public Object moderatorDeleteCommentById(@RequestBody AuthObject auth) {
		Integer id = (Integer) auth.getData();
 		return csvc.deleteCommentById(id);
 	}
}