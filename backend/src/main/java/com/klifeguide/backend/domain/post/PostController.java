package com.klifeguide.backend.domain.post;

import com.klifeguide.backend.domain.post.dto.PostCreateRequest;
import com.klifeguide.backend.domain.post.dto.PostResponse;
import com.klifeguide.backend.domain.post.dto.PostUpdateRequest;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/posts")
public class PostController {

    private final PostService postService;

    public PostController(PostService postService) {
        this.postService = postService;
    }

    @PostMapping
    public ResponseEntity<PostResponse> createPost(
            @AuthenticationPrincipal String authorId,
            @Valid @RequestBody PostCreateRequest request
    ) {
        Post post = postService.createPost(
                Long.valueOf(authorId), request.postType(), request.title(), request.content(),
                request.category(), request.tags());
        return ResponseEntity.status(HttpStatus.CREATED).body(PostResponse.from(post));
    }

    @GetMapping
    public ResponseEntity<Page<PostResponse>> getPosts(
            @RequestParam(required = false) PostType postType,
            @RequestParam(required = false) String category,
            Pageable pageable
    ) {
        Page<Post> posts;
        if (category != null) {
            posts = postService.getPostsByCategory(category, pageable);
        } else {
            posts = postService.getPostsByType(postType != null ? postType : PostType.FREE, pageable);
        }
        return ResponseEntity.ok(posts.map(PostResponse::from));
    }

    @GetMapping("/qna/unresolved")
    public ResponseEntity<Page<PostResponse>> getUnresolvedQnaPosts(Pageable pageable) {
        return ResponseEntity.ok(postService.getUnresolvedQnaPosts(pageable).map(PostResponse::from));
    }

    @GetMapping("/search")
    public ResponseEntity<Page<PostResponse>> searchPosts(@RequestParam String keyword, Pageable pageable) {
        return ResponseEntity.ok(postService.searchPosts(keyword, pageable).map(PostResponse::from));
    }

    @GetMapping("/{postId}")
    public ResponseEntity<PostResponse> getPost(@PathVariable String postId) {
        return ResponseEntity.ok(PostResponse.from(postService.getPost(postId)));
    }

    @PatchMapping("/{postId}")
    public ResponseEntity<PostResponse> updatePost(
            @AuthenticationPrincipal String authorId,
            @PathVariable String postId,
            @Valid @RequestBody PostUpdateRequest request
    ) {
        Post post = postService.updatePost(
                postId, Long.valueOf(authorId), request.title(), request.content(),
                request.category(), request.tags());
        return ResponseEntity.ok(PostResponse.from(post));
    }

    @DeleteMapping("/{postId}")
    public ResponseEntity<Void> deletePost(
            @AuthenticationPrincipal String authorId,
            @PathVariable String postId
    ) {
        postService.deletePost(postId, Long.valueOf(authorId));
        return ResponseEntity.noContent().build();
    }
}
