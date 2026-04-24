package org.triptogether.cloudinary;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Cloudinary 이미지 업로드 서비스.
 *
 * <p>커뮤니티·문의 게시판 등 이미지 업로드가 필요한 모듈에서 공통으로 사용한다.</p>
 * <ul>
 *   <li>허용 확장자: jpg / jpeg / png / gif / webp</li>
 *   <li>업로드 성공 시 Cloudinary secure_url 반환, 실패 시 null 반환 (예외 전파 없음)</li>
 * </ul>
 */
@Slf4j
@Service
public class CloudinaryService {

    private final Cloudinary cloudinary;

    private static final Set<String> ALLOWED_EXTS = Set.of(".jpg", ".jpeg", ".png", ".gif", ".webp");

    public CloudinaryService(
            @Value("${cloudinary.cloud-name}") String cloudName,
            @Value("${cloudinary.api-key}") String apiKey,
            @Value("${cloudinary.api-secret}") String apiSecret) {
        this.cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key",    apiKey,
                "api_secret", apiSecret
        ));
    }

    /**
     * 이미지를 Cloudinary에 업로드하고 secure_url을 반환한다.
     *
     * @param file   업로드할 파일
     * @param folder Cloudinary 내 저장 폴더 (예: "community", "inquiry")
     * @return Cloudinary secure_url, 실패 시 null
     */
    public String uploadImage(MultipartFile file, String folder) {
        if (file == null || file.isEmpty()) return null;

        String ext = getExtension(file.getOriginalFilename()).toLowerCase();
        if (!ALLOWED_EXTS.contains(ext)) {
            log.warn("허용되지 않는 파일 형식 업로드 시도: {}", ext);
            return null;
        }

        try {
            Map<?, ?> result = cloudinary.uploader().upload(
                    file.getBytes(),
                    ObjectUtils.asMap("folder", folder)
            );
            return (String) result.get("secure_url");
        } catch (Exception e) {
            log.error("Cloudinary 업로드 실패: {}", e.getMessage());
            return null;
        }
    }

    /**
     * byte[] 이미지를 Cloudinary에 업로드한다. publicId를 지정하면 덮어쓰기(overwrite)된다.
     *
     * @param bytes    이미지 바이트 배열
     * @param folder   Cloudinary 내 저장 폴더
     * @param publicId 고정 public_id (null이면 자동 생성)
     * @return Cloudinary secure_url, 실패 시 null
     */
    public String uploadImageFromBytes(byte[] bytes, String folder, String publicId) {
        if (bytes == null || bytes.length == 0) return null;
        try {
            Map<String, Object> options = new java.util.HashMap<>();
            options.put("folder", folder);
            options.put("overwrite", true);
            options.put("resource_type", "image");
            if (publicId != null) options.put("public_id", publicId);
            Map<?, ?> result = cloudinary.uploader().upload(bytes, options);
            return (String) result.get("secure_url");
        } catch (Exception e) {
            log.error("Cloudinary byte 업로드 실패: {}", e.getMessage());
            return null;
        }
    }

    private String getExtension(String filename) {
        if (filename == null || !filename.contains(".")) return "";
        return filename.substring(filename.lastIndexOf("."));
    }

    /**
     * Cloudinary Admin API로 특정 폴더 내 모든 리소스를 조회한다.
     * next_cursor로 반복하여 페이지네이션 전체 수집.
     *
     * @param folder Cloudinary 폴더 경로 (예: "community/inline")
     * @return 각 항목: {publicId, secureUrl, createdAt(ISO8601 String)}
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> listResourcesInFolder(String folder) {
        List<Map<String, Object>> all = new ArrayList<>();
        String nextCursor = null;
        int pageCount = 0;
        try {
            do {
                Map<String, Object> options = new HashMap<>();
                options.put("type", "upload");
                options.put("prefix", folder + "/");
                options.put("max_results", 500);
                if (nextCursor != null) options.put("next_cursor", nextCursor);

                Map<?, ?> result = cloudinary.api().resources(options);
                List<Map<String, Object>> resources = (List<Map<String, Object>>) result.get("resources");
                if (resources != null) {
                    for (Map<String, Object> r : resources) {
                        Map<String, Object> item = new HashMap<>();
                        item.put("publicId",  r.get("public_id"));
                        item.put("secureUrl", r.get("secure_url"));
                        item.put("createdAt", r.get("created_at"));
                        all.add(item);
                    }
                }
                nextCursor = (String) result.get("next_cursor");
                pageCount++;
                if (pageCount > 200) {  // 안전 가드: 최대 10만개
                    log.warn("Cloudinary 리소스 페이지 초과. 조기 종료. folder={}", folder);
                    break;
                }
            } while (nextCursor != null);
        } catch (Exception e) {
            log.error("Cloudinary 리소스 조회 실패 folder={}, error={}", folder, e.getMessage());
        }
        return all;
    }

    /**
     * Cloudinary에서 단일 리소스를 삭제한다.
     *
     * @param publicId Cloudinary public_id (폴더 포함, 확장자 제외)
     * @return 성공 여부
     */
    public boolean deleteResource(String publicId) {
        if (publicId == null || publicId.isBlank()) return false;
        try {
            Map<?, ?> result = cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
            Object status = result.get("result");
            return "ok".equals(status);
        } catch (Exception e) {
            log.error("Cloudinary 삭제 실패 publicId={}, error={}", publicId, e.getMessage());
            return false;
        }
    }
}
