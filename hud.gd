extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

#var titleText = "The Road to Rainbow"

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$TitleLabel.text = "The Road to\nRainbow"
	$TitleLabel.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func show_win():
	show_message("You win!")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$TitleLabel.text = "The Road to\nRainbow"
	$TitleLabel.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func show_message(text):
	$TitleLabel.text = text
	$TitleLabel.show()
	$MessageTimer.start()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$TitleLabel.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$TitleLabel.hide()
