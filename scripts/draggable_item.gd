class_name DraggableItem
extends AnimatedSprite2D

@export var rest_zone: ItemDropZone = null
var selected: bool = false
var rest_zones: Array

func _ready() -> void:
	rest_zones = get_tree().get_nodes_in_group("drop_zone")
	rest_zone.register_item(self)


func _on_click_area_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true


func _input(event: InputEvent) -> void:
	if selected and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		selected = false
		
		var old_rest_zone: ItemDropZone = rest_zone.deregister_item()
		var shortest_distance = global_position.distance_to(rest_zones[0].global_position)
		var distance
		for zone in rest_zones:
			distance = global_position.distance_to(zone.global_position)
			if distance <= shortest_distance:
				rest_zone = zone
				shortest_distance = distance
		if rest_zone.item != null:
			rest_zone.swap(self, old_rest_zone)
		else:
			rest_zone.register_item(self)


func _physics_process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_zone.global_position, 10 * delta)
