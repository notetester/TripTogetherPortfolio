document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.getElementById("chatbot-toggle");
    const box = document.getElementById("chatbot-box");
    const closeBtn = document.getElementById("chatbot-close");
    const sendBtn = document.getElementById("chatbot-send");
    const input = document.getElementById("chatbot-input");
    const body = document.getElementById("chatbot-body");

    toggle.onclick = () => box.classList.toggle("hidden");
    closeBtn.onclick = () => box.classList.add("hidden");

    sendBtn.onclick = sendMessage;
    input.addEventListener("keypress", function (e) {
        if (e.key === "Enter") sendMessage();
    });

    function sendMessage() {
        const msg = input.value.trim();
        if (!msg) return;

        const userMsg = document.createElement("div");
        userMsg.textContent = msg;
        userMsg.style.textAlign = "right";
        body.appendChild(userMsg);

        const botMsg = document.createElement("div");
        botMsg.textContent = getBotResponse(msg);
        body.appendChild(botMsg);

        input.value = "";
        body.scrollTop = body.scrollHeight;
    }

    function getBotResponse(msg) {
        if (msg.includes("여행")) return "여행지 탐색 페이지로 이동하세요: /explore";
        if (msg.includes("코스")) return "여행 코스 페이지: /courses";
        return "죄송합니다. 해당 질문은 지원하지 않습니다.";
    }
});
