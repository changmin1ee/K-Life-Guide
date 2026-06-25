package com.klifeguide.backend.domain.comment;

import com.klifeguide.backend.domain.common.ContentStatus;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface CommentRepository extends MongoRepository<Comment, String> {

    List<Comment> findByPostIdAndStatusOrderByCreatedAtAsc(String postId, ContentStatus status);

    List<Comment> findByPostIdAndParentCommentIdAndStatusOrderByCreatedAtAsc(
            String postId, String parentCommentId, ContentStatus status);

    long countByPostIdAndStatus(String postId, ContentStatus status);

    List<Comment> findByAuthorIdOrderByCreatedAtDesc(Long authorId);
}
