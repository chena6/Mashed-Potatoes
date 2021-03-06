package com.revature.daos.interfaces;

import java.util.Set;

import com.revature.entities.Comment;

public interface CommentDAO {
	
	/**
	 * @param movieid
	 * @returns Returns a set of comments attached to the given Movie ID.
	 */
	public Set<Comment> getCommentsByMovieId(String id);
	
	/**
	 * @param movieid
	 * @returns Returns a set of comments attached to the given Movie ID.
	 */
	public Set<Comment> getCommentsByUserId(int id);

	/**
	 * @param comm
	 */
	public void createComment(Comment comm);
	
	public Comment deleteCommentById(int id);

	public Set<Comment> getAllComments();
}