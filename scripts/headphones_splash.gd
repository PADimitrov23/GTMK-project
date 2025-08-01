extends Control

@onready var timer = $Timer

func _ready() -> void:
	$Transition/AnimationPlayer.play("fade_out") 


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	$Transition/AnimationPlayer.play("fade_in") 
