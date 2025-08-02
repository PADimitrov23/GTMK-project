extends Control

var button_type = null

func _ready() -> void:
	$Transition/AnimationPlayer.play("fade_out")


func _on_start_button_pressed() -> void:
	button_type = "start"
	_play_cord_pull_animation()


func _on_options_button_pressed() -> void:
	button_type = "options"
	_play_cord_pull_animation()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _play_cord_pull_animation():
	$CordPullAnimation.play()
	while $CordPullAnimation.stream_position <= 1.26:
		await get_tree().process_frame
	$Transition/FadeTimer.start()
	$Transition/AnimationPlayer.play("fade_in")
	while $CordPullAnimation.stream_position <= 1.282:
		await get_tree().process_frame
	$CordPullAnimation.paused = true


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		
	elif button_type == "options":
		get_tree().change_scene_to_file("res://scenes/options.tscn")
