extends Control

var button_type = null

func _on_start_button_pressed() -> void:
	print("start pressed")
	button_type = "start"
	$Transition.show()
	$Transition/FadeTimer.start()
	$Transition/AnimationPlayer.play("fade_in")


func _on_options_button_pressed() -> void:
	print("options pressed")
	button_type = "options"
	$Transition.show()
	$Transition/FadeTimer.start()
	$Transition/AnimationPlayer.play("fade_in")


func _on_quit_button_pressed() -> void:
	print("quit pressed")  
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start" :
		get_tree().change_scene_to_file("res://game.tscn")
		
	elif button_type == "options" :
		get_tree().change_scene_to_file("res://options.tscn")
