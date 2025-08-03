extends Control

@onready var left_hand: ItemDropZone = $RobberLeftHand/ItemDropZone
@onready var right_hand: ItemDropZone = $RobberRightHand/ItemDropZone

func _ready() -> void:
	$Transition/AnimationPlayer.play("fade_out")
	#if PlayerData.completed_endings.has("res://scenes/endings/cash_ending.tscn"):
		#$ItemKnife.show()


func _play_ending(path: String):
	$RobberFace.hide()
	$RobberDarkenedFace.show()
	$EndingTimer.start()
	if not PlayerData.completed_endings.has(path):
		PlayerData.completed_endings.append(path)
		PlayerData.endings_counter += 1
	await $EndingTimer.timeout
	$Transition/AnimationPlayer.play("fade_in")
	await $Transition/AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(path)


func _check_for_pair(a: DraggableItem, b: DraggableItem):
	return (left_hand.item == a and right_hand.item == b) or (left_hand.item == b and right_hand.item == a)


func _on_confirm_button_pressed() -> void:
	if left_hand.item == null and right_hand.item == null:
		return
	elif _check_for_pair($ItemKnife, $ItemCash):
		_play_ending("res://scenes/endings/knife_cash.tscn")
	elif _check_for_pair($ItemBooze, $ItemPhone):
		_play_ending("res://scenes/endings/booze_phone.tscn")
	else:
		_one_item_endings()


func _one_item_endings() -> void:
	var item: DraggableItem
	if left_hand.item == null:
		item = right_hand.item
	else:
		item = left_hand.item
	
	if item == $ItemCash:
		_play_ending("res://scenes/endings/cash_ending.tscn")
	elif item == $ItemKnife:
		_play_ending("res://scenes/endings/knife_ending.tscn")
	elif item == $ItemBooze:
		_play_ending("res://scenes/endings/booze_ending.tscn")
	elif item == $ItemFlashlight:
		_play_ending("res://scenes/endings/flashlight_ending.tscn")
	elif item == $ItemPhone:
		_play_ending("res://scenes/endings/phone_ending.tscn")
	elif item == $ItemCarKeys:
		_play_ending("res://scenes/endings/finale_ending.tscn")


func _on_give_up_button_pressed() -> void:
	$GiveUpPanel.popup_centered() # Show popup in center


func _on_yes_button_pressed() -> void:
	get_tree().quit() # Quit the game


func _on_no_button_pressed() -> void:
	$GiveUpPanel.hide() # Close popup


func _process(_delta):
	$EndingsCounterLabel.text = str(PlayerData.endings_counter) + "/" + str(PlayerData.MAX_ENDINGS)
