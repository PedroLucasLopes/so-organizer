class_name ContextMenuComponent extends Node

const CONTEXT_MENU = preload("res://scenes/context_menu.tscn")

@export var node: Node2D
@export var control_node : Control
@export var area_2d: Area2D
@export var sprite: Sprite2D
@export var context_menu_size : Vector2 = Vector2(32, 16)

var context_menu_active : bool = false
var clickable : bool = false
var context_menu : ContextMenu = null

func _process(delta: float) -> void:
	print(context_menu)

func _ready() -> void:
	if area_2d:
		area_2d.mouse_entered.connect(_on_area_mouse_entered)
		area_2d.mouse_exited.connect(_on_area_mouse_exited)
	elif control_node:
		pass

func _on_area_mouse_entered() -> void:
	clickable = true
	pass

func _on_area_mouse_exited() -> void:
	clickable = false
	if context_menu_active:
		if context_menu:
			context_menu.queue_free()
		context_menu_active = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and !context_menu_active and event.is_released():
		if event.button_index == MOUSE_BUTTON_RIGHT:
			context_menu = CONTEXT_MENU.instantiate()
			node.add_child(context_menu)
			context_menu.global_position = node.get_global_mouse_position()
			context_menu.reveal_context_menu(context_menu_size)
			context_menu_active = true
