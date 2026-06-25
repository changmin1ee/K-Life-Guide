package com.klifeguide.backend.domain.post;

import com.klifeguide.backend.domain.common.ContentStatus;
import com.klifeguide.backend.global.exception.BusinessException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostService {

    private final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public Post createPost(Long authorId, PostType postType, String title, String content,
                            String category, List<String> tags) {
        Post post = Post.builder()
                .postType(postType)
                .authorId(authorId)
                .title(title)
                .content(content)
                .category(category)
                .tags(tags)
                .build();
        return postRepository.save(post);
    }

    public Post getPost(String postId) {
        Post post = findActivePost(postId);
        post.increaseViewCount();
        return postRepository.save(post);
    }

    public Post getPostWithoutViewCount(String postId) {
        return findActivePost(postId);
    }

    public Page<Post> getPostsByType(PostType postType, Pageable pageable) {
        return postRepository.findByStatusAndPostTypeOrderByCreatedAtDesc(ContentStatus.ACTIVE, postType, pageable);
    }

    public Page<Post> getPostsByCategory(String category, Pageable pageable) {
        return postRepository.findByStatusAndCategoryOrderByCreatedAtDesc(ContentStatus.ACTIVE, category, pageable);
    }

    public Page<Post> getUnresolvedQnaPosts(Pageable pageable) {
        return postRepository.findByPostTypeAndStatusAndQnaIsResolvedOrderByCreatedAtDesc(
                PostType.QNA, ContentStatus.ACTIVE, false, pageable);
    }

    public Page<Post> searchPosts(String keyword, Pageable pageable) {
        return postRepository.searchByKeyword(keyword, ContentStatus.ACTIVE, pageable);
    }

    public Post updatePost(String postId, Long requesterId, String title, String content,
                            String category, List<String> tags) {
        Post post = findActivePost(postId);
        validateOwner(post, requesterId);
        post.update(title, content, category, tags);
        return postRepository.save(post);
    }

    public void deletePost(String postId, Long requesterId) {
        Post post = findActivePost(postId);
        validateOwner(post, requesterId);
        post.delete();
        postRepository.save(post);
    }

    public Post resolveQna(String postId, Long requesterId, String acceptedCommentId) {
        Post post = findActivePost(postId);
        validateOwner(post, requesterId);
        if (post.getPostType() != PostType.QNA) {
            throw new BusinessException(HttpStatus.BAD_REQUEST, "NOT_QNA_POST", "Q&A 게시글이 아닙니다.");
        }
        post.resolveQna(acceptedCommentId);
        return postRepository.save(post);
    }

    public void increaseCommentCount(String postId) {
        Post post = findActivePost(postId);
        post.increaseCommentCount();
        postRepository.save(post);
    }

    public void decreaseCommentCount(String postId) {
        Post post = findActivePost(postId);
        post.decreaseCommentCount();
        postRepository.save(post);
    }

    private Post findActivePost(String postId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "POST_NOT_FOUND", "게시글을 찾을 수 없습니다."));
        if (post.getStatus() == ContentStatus.DELETED) {
            throw new BusinessException(HttpStatus.NOT_FOUND, "POST_NOT_FOUND", "게시글을 찾을 수 없습니다.");
        }
        return post;
    }

    private void validateOwner(Post post, Long requesterId) {
        if (!post.getAuthorId().equals(requesterId)) {
            throw new BusinessException(HttpStatus.FORBIDDEN, "NOT_POST_OWNER", "본인이 작성한 게시글만 처리할 수 있습니다.");
        }
    }
}
