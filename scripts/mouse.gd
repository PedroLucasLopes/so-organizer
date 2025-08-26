extends Node2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position(), 22.0 * delta)
	rotation_degrees = lerp(rotation_degrees, -15.0 if Input.is_action_pressed("click") else 0.0, 25.0 * delta)
	scale = lerp(scale, Vector2(0.175, 0.175) if Input.is_action_pressed("click") else Vector2(0.2, 0.2), 25.0 * delta)
