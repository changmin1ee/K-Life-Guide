package com.klifeguide.backend.domain.post;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.data.mongodb.core.mapping.FieldType;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class QnaInfo {

    private boolean isResolved;

    @Field(targetType = FieldType.OBJECT_ID)
    private String acceptedCommentId;

    public QnaInfo(boolean isResolved, String acceptedCommentId) {
        this.isResolved = isResolved;
        this.acceptedCommentId = acceptedCommentId;
    }

    public void resolve(String acceptedCommentId) {
        this.isResolved = true;
        this.acceptedCommentId = acceptedCommentId;
    }
}
