extends Control

@onready var confirmation_panel = $GiveUpPanel

var endings_counter: int = 0
const MAX_COUNT: int = 11

func _on_give_up_button_pressed() -> void:
	confirmation_panel.popup_centered() # Show popup in center


func _on_yes_button_pressed() -> void:
	get_tree().quit() # Quit the game


func _on_no_button_pressed() -> void:
	confirmation_panel.hide() # Close popup


func _process(delta):
	$EndingsCounterLabel.text = str(endings_counter) + "/" + str(MAX_COUNT)
