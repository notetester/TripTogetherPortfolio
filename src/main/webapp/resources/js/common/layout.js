document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.getElementById("chatbot-toggle");
    const box = document.getElementById("chatbot-box");
    const closeBtn = document.getElementById("chatbot-close");
    const sendBtn = document.getElementById("chatbot-send");
    const input = document.getElementById("chatbot-input");
    const body = document.getElementById("chatbot-body");
    const cfg = window.__chatbotConfig || {};
    const labels = cfg.msg || {};

    if (!toggle || !box || !closeBtn || !sendBtn || !input || !body) return;

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
        if (/travel|trip|\uC5EC\uD589|旅行|旅游/i.test(msg)) {
            return labels.suggestPopularMsg || "Open destination search: /explore";
        }
        if (/course|plan|\uCF54\uC2A4|日程|路线/i.test(msg)) {
            return labels.suggestCoursesMsg || "Open travel courses: /courses";
        }
        return labels.error || "This question is not supported.";
    }
});
