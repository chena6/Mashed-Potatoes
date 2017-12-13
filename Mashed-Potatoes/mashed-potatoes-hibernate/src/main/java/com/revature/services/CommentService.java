package com.revature.services;

import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.revature.daos.interfaces.CommentDAO;
import com.revature.entities.Comment;

@Service
public class CommentService {
	
	Logger log = Logger.getRootLogger();
	
	@Autowired
	CommentDAO commentRepo;
	
	public Set<Comment> getCommentsByMovieId(String id) {
		return commentRepo.getCommentsByMovieId(id);
	}

	public Set<Comment> getCommentsByUserId(int id) {
		return commentRepo.getCommentsByUserId(id);
	}

	public void createNewReview(Comment comm) {
		log.info("In post comment service: " + comm);
		commentRepo.createComment(comm);
	}
	
	public Comment deleteCommentById(int id) {
		return commentRepo.deleteCommentById(id);
	}

	public Set<Comment> getAllComments() {
		return commentRepo.getAllComments();
	}
}