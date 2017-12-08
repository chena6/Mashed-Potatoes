package com.revature.daos.interfaces;

import java.util.Set;

import com.revature.entities.Comment;

public interface CommentDAO {
	
	/**
	 * @param movieid
	 * @returns Returns a set of comments attached to the given Movie ID.
	 */
	public Set<Comment> getCommentsByMovieId(String id);
}
