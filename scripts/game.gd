extends Node2D


func _ready() -> void:
	$Control/Transition/AnimationPlayer.play("fade_out") 
