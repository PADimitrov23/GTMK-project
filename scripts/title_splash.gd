extends Control

func _on_timer_timeout() -> void:
	$Transition/AnimationPlayer.play("fade_in")
	await $Transition/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/headphones_splash.tscn")
