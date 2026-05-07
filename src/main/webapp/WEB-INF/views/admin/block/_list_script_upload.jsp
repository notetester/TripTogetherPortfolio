<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
(function () {
    const form = document.getElementById('policyFeedUploadForm');
    if (!form) return;
    const resultBox = document.getElementById('policyFeedUploadResult');
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        const formData = new FormData(form);
        resultBox.textContent = '${msg_admin_blocks_policyFeed_uploading_js}';
        fetch('${pageContext.request.contextPath}/admin/blocks/policy-feed/upload', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    resultBox.textContent =
                        '${msg_admin_blocks_policyFeed_uploadSuccess_js}'
                        + ' batch=' + data.batchCode
                        + ', success=' + data.successCount
                        + ', failed=' + data.failedCount;
                    renderSectionByMode('ip-rules');
                    renderSectionByMode('batches');
                } else {
                    resultBox.textContent = data.message || '${msg_admin_blocks_policyFeed_uploadFailed_js}';
                }
            })
            .catch(error => {
                resultBox.textContent = error.message || '${msg_admin_blocks_policyFeed_uploadFailed_js}';
            });
    });
})();
</script>
