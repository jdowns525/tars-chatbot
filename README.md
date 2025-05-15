# 🤖 TARS AI Terminal

A web-based AI chatbot styled like a retro COBOL terminal, powered by Ruby on Rails and OpenAI. TARS brings sarcastic wit and accurate information together in one dry-humored assistant, just like its namesake from *Interstellar*.

---

## 🚀 Features

- **Interactive Terminal UI** – Styled after a COBOL-era system with line numbers, fixed-width font, and blinking cursor.
- **Sarcastic AI Personality** – Emulates TARS’s dry humor while ensuring answers are accurate, helpful, and fact-based.
- **Conversation Memory** – Maintains a lightweight message history for context-aware replies.
- **Rate Limiting** – Limits users to 25 messages per hour using Rails session tracking.
- **OpenAI Integration** – Uses GPT-3.5-turbo for generating chat responses.

---

## 🛠️ Built With

- **Ruby on Rails** – Backend server, routing, and session management
- **HTML + CSS + JS** – Frontend interface styled with custom retro terminal aesthetics
- **OpenAI API** – AI chatbot logic (via `openai` Ruby gem)
- **Sessions** – Used for simple rate limiting (no user authentication required)

---

## 📸 Preview

<img width="1271" alt="Screenshot 2025-05-15 at 10 47 07 AM" src="https://github.com/user-attachments/assets/3cbd3007-daa2-4c30-b923-32421c092489" />

---

## ⚙️ Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/tars-ai-terminal.git
   cd tars-ai-terminal
