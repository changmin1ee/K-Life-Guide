package com.klifeguide.backend.domain.comment;

import com.klifeguide.backend.domain.common.ContentStatus;
import com.klifeguide.backend.domain.post.Post;
import com.klifeguide.backend.domain.post.PostService;
import com.klifeguide.backend.domain.post.PostType;
import com.klifeguide.backend.global.exception.BusinessException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    private final CommentRepository commentRepository;
    private final PostService postService;

    public CommentService(CommentRepository commentRepository, PostService postService) {
        this.commentRepository = commentRepository;
        this.postService = postService;
    }

    public Comment createComment(String postId, Long authorId, String parentCommentId, String content) {
        postService.getPostWithoutViewCount(postId);

        if (parentCommentId != null) {
            Comment parent = findActiveComment(parentCommentId);
            if (parent.getDepth() != 0) {
                throw new BusinessException(HttpStatus.BAD_REQUEST, "REPLY_DEPTH_EXCEEDED", "대댓글에는 답글을 달 수 없습니다.");
            }
        }

        Comment comment = Comment.builder()
                .postId(postId)
                .authorId(authorId)
                .parentCommentId(parentCommentId)
                .content(content)
                .build();
        Comment saved = commentRepository.save(comment);
        postService.increaseCommentCount(postId);
        return saved;
    }

    public List<Comment> getComments(String postId) {
        return commentRepository.findByPostIdAndStatusOrderByCreatedAtAsc(postId, ContentStatus.ACTIVE);
    }

    public void deleteComment(String commentId, Long requesterId) {
        Comment comment = findActiveComment(commentId);
        if (!comment.getAuthorId().equals(requesterId)) {
            throw new BusinessException(HttpStatus.FORBIDDEN, "NOT_COMMENT_OWNER", "본인이 작성한 댓글만 삭제할 수 있습니다.");
        }
        comment.delete();
        commentRepository.save(comment);
        postService.decreaseCommentCount(comment.getPostId());
    }

    public Comment acceptComment(String postId, String commentId, Long requesterId) {
        Post post = postService.getPostWithoutViewCount(postId);
        if (!post.getAuthorId().equals(requesterId)) {
            throw new BusinessException(HttpStatus.FORBIDDEN, "NOT_POST_OWNER", "본인이 작성한 게시글에서만 답변을 채택할 수 있습니다.");
        }
        if (post.getPostType() != PostType.QNA) {
            throw new BusinessException(HttpStatus.BAD_REQUEST, "NOT_QNA_POST", "Q&A 게시글이 아닙니다.");
        }

        Comment comment = findActiveComment(commentId);
        if (!comment.getPostId().equals(postId)) {
            throw new BusinessException(HttpStatus.BAD_REQUEST, "COMMENT_POST_MISMATCH", "해당 게시글의 댓글이 아닙니다.");
        }

        comment.accept();
        Comment accepted = commentRepository.save(comment);
        postService.resolveQna(postId, requesterId, commentId);
        return accepted;
    }

    private Comment findActiveComment(String commentId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "COMMENT_NOT_FOUND", "댓글을 찾을 수 없습니다."));
        if (comment.getStatus() == ContentStatus.DELETED) {
            throw new BusinessException(HttpStatus.NOT_FOUND, "COMMENT_NOT_FOUND", "댓글을 찾을 수 없습니다.");
        }
        return comment;
    }
}
