extends VideoStreamPlayer

func _ready():
	$Transition/AnimationPlayer.play("fade_out")
	await get_tree().create_timer(0.15).timeout
	play()
	await finished
	
	$RobberScene.show()
	await get_tree().create_timer(5.0).timeout
	
	$Transition/AnimationPlayer.play("fade_in")
	await $Transition/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")
