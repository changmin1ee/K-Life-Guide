package com.klife.klifeguide.domain.community.repository;

import com.klife.klifeguide.domain.community.entity.Reply;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface ReplyRepository extends MongoRepository<Reply, String> {
    List<Reply> findByPostIdOrderByCreatedAtAsc(String postId);
    List<Reply> findByMemberIdOrderByCreatedAtDesc(Long memberId);
    long countByPostId(String postId);
}
