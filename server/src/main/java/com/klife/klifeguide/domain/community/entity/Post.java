package com.klife.klifeguide.domain.community.entity;

import com.klife.klifeguide.domain.community.enums.BoardType;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Document(collection = "posts")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Post {

    @Id
    private String id;

    private Long memberId;
    private String authorName;
    private String authorProfileImageUrl;

    private BoardType boardType;

    private String titleKo;
    private String titleEn;
    private String contentKo;
    private String contentEn;

    @Builder.Default
    private int likeCount = 0;

    @Builder.Default
    private int replyCount = 0;

    @Builder.Default
    private boolean solved = false;

    // 좋아요 누른 memberId 목록 (MongoDB에서 JOIN 대신 embed)
    @Builder.Default
    private List<Long> likedMemberIds = new ArrayList<>();

    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    public void markAsSolved() { this.solved = true; }

    public void addLike(Long memberId) {
        if (this.likedMemberIds == null) this.likedMemberIds = new java.util.ArrayList<>();
        if (!this.likedMemberIds.contains(memberId)) {
            this.likedMemberIds.add(memberId);
            this.likeCount++;
        }
    }

    public void removeLike(Long memberId) {
        if (this.likedMemberIds != null && this.likedMemberIds.remove(memberId)) {
            this.likeCount--;
        }
    }

    public boolean isLikedBy(Long memberId) {
        return this.likedMemberIds != null && this.likedMemberIds.contains(memberId);
    }

    public void incrementReply() { this.replyCount++; }
    public void decrementReply() { if (this.replyCount > 0) this.replyCount--; }
}
