package org.triptogether.cloudinary;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.Set;

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
}
