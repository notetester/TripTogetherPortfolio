-- 레벨 보상 뱃지 4종을 POINT_SHOP_ITEM에 등록
-- is_active = 0: 상점에서 직접 구매 불가 (레벨업 보상으로만 지급)
-- 장착(USER_POINT_ITEM_EQUIP) 및 댓글 표시는 정상 동작
INSERT INTO POINT_SHOP_ITEM
    (item_code, item_name, item_type, point_price, is_repeatable, is_active, item_payload_json, description)
VALUES
    ('LEVEL_BADGE_BRONZE_10',
     'Lv.10 브론즈 성장 뱃지',
     'PROFILE_BADGE',
     0, 0, 0,
     '{"label": "브론즈", "cssClass": "badge-level-bronze"}',
     'Lv.10 달성 레벨업 보상 뱃지 (상점 비판매)'),
    ('LEVEL_BADGE_SILVER_20',
     'Lv.20 실버 성장 뱃지',
     'PROFILE_BADGE',
     0, 0, 0,
     '{"label": "실버", "cssClass": "badge-level-silver"}',
     'Lv.20 달성 레벨업 보상 뱃지 (상점 비판매)'),
    ('LEVEL_BADGE_GOLD_30',
     'Lv.30 골드 성장 뱃지',
     'PROFILE_BADGE',
     0, 0, 0,
     '{"label": "골드", "cssClass": "badge-level-gold"}',
     'Lv.30 달성 레벨업 보상 뱃지 (상점 비판매)'),
    ('LEVEL_BADGE_MASTER_50',
     'Lv.50 마스터 성장 뱃지',
     'PROFILE_BADGE',
     0, 0, 0,
     '{"label": "마스터", "cssClass": "badge-level-master"}',
     'Lv.50 달성 레벨업 보상 뱃지 (상점 비판매)');