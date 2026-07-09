package com.klife.klifeguide.domain.community.service;

import com.klife.klifeguide.domain.community.converter.PostConverter;
import com.klife.klifeguide.domain.community.dto.PostReqDTO;
import com.klife.klifeguide.domain.community.dto.PostResDTO;
import com.klife.klifeguide.domain.community.entity.Post;
import com.klife.klifeguide.domain.community.entity.Reply;
import com.klife.klifeguide.domain.community.enums.BoardType;
import com.klife.klifeguide.domain.community.exception.CommunityException;
import com.klife.klifeguide.domain.community.exception.code.CommunityErrorCode;
import com.klife.klifeguide.domain.community.repository.PostRepository;
import com.klife.klifeguide.domain.community.repository.ReplyRepository;
import com.klife.klifeguide.domain.member.entity.Member;
import com.klife.klifeguide.domain.member.exception.MemberException;
import com.klife.klifeguide.domain.member.exception.code.MemberErrorCode;
import com.klife.klifeguide.domain.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommunityService {

    private final PostRepository postRepository;
    private final ReplyRepository replyRepository;
    private final MemberRepository memberRepository;
    private final PostConverter postConverter;

    public List<PostResDTO.PostSummary> getPosts(BoardType boardType, Long memberId) {
        List<Post> posts;
        if (boardType == null) {
            posts = postRepository.findAllByOrderByCreatedAtDesc();
        } else {
            posts = postRepository.findByBoardTypeOrderByCreatedAtDesc(boardType);
        }

        return posts.stream()
                .map(post -> {
                    boolean isLiked = memberId != null && post.isLikedBy(memberId);
                    return postConverter.toPostSummary(post, isLiked);
                })
                .collect(Collectors.toList());
    }

    public PostResDTO.PostDetail getPostDetail(String postId, Long memberId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new CommunityException(CommunityErrorCode.POST_NOT_FOUND));

        List<Reply> replies = replyRepository.findByPostIdOrderByCreatedAtAsc(postId);
        boolean isLiked = memberId != null && post.isLikedBy(memberId);

        return postConverter.toPostDetail(post, replies, isLiked);
    }

    public PostResDTO.PostSummary createPost(Long memberId, PostReqDTO.CreatePost req) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new MemberException(MemberErrorCode.MEMBER_NOT_FOUND));

        Post post = Post.builder()
                .memberId(memberId)
                .authorName(member.getName())
                .authorProfileImageUrl(member.getProfileImageUrl())
                .boardType(req.getBoardType())
                .titleKo(req.getTitleKo())
                .titleEn(req.getTitleEn())
                .contentKo(req.getContentKo())
                .contentEn(req.getContentEn())
                .build();

        Post saved = postRepository.save(post);
        return postConverter.toPostSummary(saved, false);
    }

    public PostResDTO.ReplyInfo createReply(Long memberId, String postId, PostReqDTO.CreateReply req) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new MemberException(MemberErrorCode.MEMBER_NOT_FOUND));

        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new CommunityException(CommunityErrorCode.POST_NOT_FOUND));

        Reply reply = Reply.builder()
                .memberId(memberId)
                .authorName(member.getName())
                .authorProfileImageUrl(member.getProfileImageUrl())
                .postId(postId)
                .content(req.getContent())
                .build();

        post.incrementReply();
        postRepository.save(post);

        Reply saved = replyRepository.save(reply);
        return postConverter.toReplyInfo(saved);
    }

    public PostResDTO.LikeResult toggleLike(Long memberId, String postId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new CommunityException(CommunityErrorCode.POST_NOT_FOUND));

        boolean isLiked;
        if (post.isLikedBy(memberId)) {
            post.removeLike(memberId);
            isLiked = false;
        } else {
            post.addLike(memberId);
            isLiked = true;
        }

        postRepository.save(post);

        return PostResDTO.LikeResult.builder()
                .postId(postId)
                .likeCount(post.getLikeCount())
                .isLiked(isLiked)
                .build();
    }

    public PostResDTO.SolveResult solvePost(Long memberId, String postId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new CommunityException(CommunityErrorCode.POST_NOT_FOUND));

        if (!BoardType.QNA.equals(post.getBoardType())) {
            throw new CommunityException(CommunityErrorCode.ONLY_QNA_CAN_SOLVE);
        }

        if (!post.getMemberId().equals(memberId)) {
            throw new CommunityException(CommunityErrorCode.NOT_POST_AUTHOR);
        }

        post.markAsSolved();
        postRepository.save(post);

        return PostResDTO.SolveResult.builder()
                .postId(postId)
                .solved(post.isSolved())
                .build();
    }

    public List<PostResDTO.PostSummary> getMyPosts(Long memberId) {
        List<Post> posts = postRepository.findByMemberIdOrderByCreatedAtDesc(memberId);

        return posts.stream()
                .map(post -> {
                    boolean isLiked = post.isLikedBy(memberId);
                    return postConverter.toPostSummary(post, isLiked);
                })
                .collect(Collectors.toList());
    }
}
