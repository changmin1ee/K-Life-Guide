package com.klifeguide.backend.domain.comment;

import com.klifeguide.backend.domain.comment.dto.CommentCreateRequest;
import com.klifeguide.backend.domain.comment.dto.CommentResponse;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class CommentController {

    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @PostMapping("/api/posts/{postId}/comments")
    public ResponseEntity<CommentResponse> createComment(
            @AuthenticationPrincipal String authorId,
            @PathVariable String postId,
            @Valid @RequestBody CommentCreateRequest request
    ) {
        Comment comment = commentService.createComment(
                postId, Long.valueOf(authorId), request.parentCommentId(), request.content());
        return ResponseEntity.status(HttpStatus.CREATED).body(CommentResponse.from(comment));
    }

    @GetMapping("/api/posts/{postId}/comments")
    public ResponseEntity<List<CommentResponse>> getComments(@PathVariable String postId) {
        List<CommentResponse> responses = commentService.getComments(postId).stream()
                .map(CommentResponse::from)
                .toList();
        return ResponseEntity.ok(responses);
    }

    @DeleteMapping("/api/comments/{commentId}")
    public ResponseEntity<Void> deleteComment(
            @AuthenticationPrincipal String authorId,
            @PathVariable String commentId
    ) {
        commentService.deleteComment(commentId, Long.valueOf(authorId));
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/api/posts/{postId}/comments/{commentId}/accept")
    public ResponseEntity<CommentResponse> acceptComment(
            @AuthenticationPrincipal String authorId,
            @PathVariable String postId,
            @PathVariable String commentId
    ) {
        Comment comment = commentService.acceptComment(postId, commentId, Long.valueOf(authorId));
        return ResponseEntity.ok(CommentResponse.from(comment));
    }
}
