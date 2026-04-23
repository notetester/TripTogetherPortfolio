package org.triptogether.moderation.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.triptogether.moderation.mapper.ModerationMapper;
import org.triptogether.moderation.vo.ContentModerationPolicyVO;

@Service
public class ModerationPolicyServiceImpl implements ModerationPolicyService {

    @Autowired
    private ModerationMapper moderationMapper;

    private volatile ContentModerationPolicyVO cached;

    @Override
    public ContentModerationPolicyVO getPolicy() {
        ContentModerationPolicyVO local = cached;
        if (local != null) return local;

        synchronized (this) {
            if (cached == null) {
                ContentModerationPolicyVO loaded = moderationMapper.selectPolicy();
                cached = (loaded != null) ? loaded : defaultPolicy();
            }
            return cached;
        }
    }

    @Override
    public void updatePolicy(ContentModerationPolicyVO policy) {
        moderationMapper.updatePolicy(policy);
        invalidate();
    }

    @Override
    public void invalidate() {
        cached = null;
    }

    private ContentModerationPolicyVO defaultPolicy() {
        ContentModerationPolicyVO p = new ContentModerationPolicyVO();
        p.setId(1);
        p.setToxicityLevel("NORMAL");
        p.setPostWindowMinutes(5);
        p.setPostMaxCount(3);
        p.setCommentWindowMinutes(1);
        p.setCommentMaxCount(5);
        p.setInquiryWindowMinutes(10);
        p.setInquiryMaxCount(3);
        return p;
    }
}
