package com.klifeguide.backend.domain.post;

import com.klifeguide.backend.domain.common.ContentStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

public interface PostRepository extends MongoRepository<Post, String> {

    Page<Post> findByStatusAndPostTypeOrderByCreatedAtDesc(ContentStatus status, PostType postType, Pageable pageable);

    Page<Post> findByStatusAndCategoryOrderByCreatedAtDesc(ContentStatus status, String category, Pageable pageable);

    Page<Post> findByAuthorIdOrderByCreatedAtDesc(Long authorId, Pageable pageable);

    Page<Post> findByPostTypeAndStatusAndQnaIsResolvedOrderByCreatedAtDesc(
            PostType postType, ContentStatus status, boolean isResolved, Pageable pageable);

    @Query("{ $text: { $search: ?0 }, status: ?1 }")
    Page<Post> searchByKeyword(String keyword, ContentStatus status, Pageable pageable);
}
