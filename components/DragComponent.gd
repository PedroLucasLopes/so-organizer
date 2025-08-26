class_name DragComponent extends Node

@export var node: Node2D
@export var area_2d: Area2D
@export var sprite: Sprite2D
@export var tile_size: Vector2

var draggable:bool = false
var default_scale: Vector2 = Vector2(1, 1)

var occupied_tiles: Array = []

var scale_tween: Tween

var last_pos: Vector2
var max_card_rotation: float = 12.5

static var current_drag: DragComponent = null

func _ready() -> void:
	area_2d.mouse_entered.connect(_on_area_mouse_entered)
	area_2d.mouse_exited.connect(_on_area_mouse_exited)

func _process(delta: float) -> void:
	mouse_drag(delta)
	
func _on_area_mouse_entered() -> void:
	if current_drag == null:
		tilt_drag(Vector2(1.2, 1.2))
		draggable = true

func _on_area_mouse_exited() -> void:
	if current_drag == null:
		tilt_drag(default_scale)
		draggable = false

func mouse_drag(delta: float) -> void:
	if draggable and Input.is_action_pressed("click"):
		current_drag = self
	
	if current_drag == self and Input.is_action_pressed("click"):
		node.global_position = node.get_global_mouse_position()
		tilt_drag(Vector2(1.2, 1.2))
		set_rotation(delta)
		node.z_index = 50
		
	if current_drag == self and Input.is_action_just_released("click"):
		current_drag = null
		tilt_drag(default_scale)
		snap_object()
		sprite.rotation_degrees = 0.0
		node.z_index = 0

func snap_object() -> void:
	var target_pos: Vector2 = (node.get_global_mouse_position() / tile_size).floor() * tile_size + tile_size / 2
	var tween := create_tween()
	tween.tween_property(node, "global_position", target_pos, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func tilt_drag(desired_scale: Vector2) -> void:
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	scale_tween.tween_property(sprite, "scale", desired_scale, 0.125)

func set_rotation(delta: float) -> void:
	var desired_rotation: float = clamp((node.global_position - last_pos).x * 2.0, -max_card_rotation, max_card_rotation)
	sprite.rotation_degrees = lerp(sprite.rotation_degrees, desired_rotation, 25.0 * delta)
	
	last_pos = node.global_position
