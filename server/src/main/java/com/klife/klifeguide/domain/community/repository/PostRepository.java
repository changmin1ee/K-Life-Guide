package com.klife.klifeguide.domain.community.repository;

import com.klife.klifeguide.domain.community.entity.Post;
import com.klife.klifeguide.domain.community.enums.BoardType;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface PostRepository extends MongoRepository<Post, String> {
    List<Post> findAllByOrderByCreatedAtDesc();
    List<Post> findByBoardTypeOrderByCreatedAtDesc(BoardType boardType);
    List<Post> findByMemberIdOrderByCreatedAtDesc(Long memberId);
}
