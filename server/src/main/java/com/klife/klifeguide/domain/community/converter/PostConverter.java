package com.klife.klifeguide.domain.community.converter;

import com.klife.klifeguide.domain.community.dto.PostResDTO;
import com.klife.klifeguide.domain.community.entity.Post;
import com.klife.klifeguide.domain.community.entity.Reply;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class PostConverter {

    public PostResDTO.PostSummary toPostSummary(Post post, boolean isLiked) {
        return PostResDTO.PostSummary.builder()
                .id(post.getId())
                .boardType(post.getBoardType())
                .titleKo(post.getTitleKo())
                .titleEn(post.getTitleEn())
                .authorName(post.getAuthorName())
                .likeCount(post.getLikeCount())
                .replyCount(post.getReplyCount())
                .solved(post.isSolved())
                .createdAt(post.getCreatedAt())
                .isLiked(isLiked)
                .build();
    }

    public PostResDTO.PostDetail toPostDetail(Post post, List<Reply> replies, boolean isLiked) {
        List<PostResDTO.ReplyInfo> replyInfos = replies.stream()
                .map(this::toReplyInfo)
                .collect(Collectors.toList());

        return PostResDTO.PostDetail.builder()
                .id(post.getId())
                .boardType(post.getBoardType())
                .titleKo(post.getTitleKo())
                .titleEn(post.getTitleEn())
                .authorName(post.getAuthorName())
                .likeCount(post.getLikeCount())
                .replyCount(post.getReplyCount())
                .solved(post.isSolved())
                .createdAt(post.getCreatedAt())
                .isLiked(isLiked)
                .contentKo(post.getContentKo())
                .contentEn(post.getContentEn())
                .replies(replyInfos)
                .build();
    }

    public PostResDTO.ReplyInfo toReplyInfo(Reply reply) {
        return PostResDTO.ReplyInfo.builder()
                .id(reply.getId())
                .authorName(reply.getAuthorName())
                .authorProfileImageUrl(reply.getAuthorProfileImageUrl())
                .content(reply.getContent())
                .likeCount(reply.getLikeCount())
                .createdAt(reply.getCreatedAt())
                .build();
    }
}
