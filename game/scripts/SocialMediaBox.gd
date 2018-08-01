extends Container

# --- Social media buttons ---

func _on_GitHub_pressed():
    OS.shell_open("https://github.com/abarichello/gamine")

func _on_Twitter_pressed():
    OS.shell_open("https://twitter.com/a_barichello")

func _on_Telegram_pressed():
    OS.shell_open("https://t.me/barichello")
