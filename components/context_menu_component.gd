class_name ContextMenuComponent extends Node

const CONTEXT_MENU = preload("res://scenes/context_menu.tscn")
signal context_menu_button_pressed

@export var node: Node2D
@export var control_node : Control
@export var area_2d: Area2D
@export var sprite: Sprite2D
@export var context_menu_size : Vector2 = Vector2(32, 16)

@export var contexto_id : String = "desktop" ## menu de contexto

var context_menu_active : bool = false
var is_mouse_inside : bool = false
var context_menu : ContextMenu = null

func _ready() -> void:
	if area_2d:
		area_2d.mouse_entered.connect(_on_area_mouse_entered)
		area_2d.mouse_exited.connect(_on_area_mouse_exited)

func _on_area_mouse_entered() -> void:
	is_mouse_inside = true

func _on_area_mouse_exited() -> void:
	is_mouse_inside = false

func _input(event: InputEvent) -> void:
	# checa pra ver se da pra abrir
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
		if is_mouse_inside and DesktopState.can_interact(contexto_id) and not context_menu_active:
			open_menu()

func _unhandled_input(event: InputEvent) -> void:
	if context_menu_active and event is InputEventMouseButton and event.is_pressed():
		close_menu()

func open_menu() -> void:
	DesktopState.current_state = DesktopState.State.CONTEXT_MENU
	context_menu_active = true
	
	context_menu = CONTEXT_MENU.instantiate()
	node.add_child(context_menu)
	context_menu.global_position = node.get_global_mouse_position()
	context_menu.reveal_context_menu(context_menu_size)
	context_menu.context_menu_button_pressed.connect(_on_context_menu_button_pressed)

func close_menu() -> void:
	if context_menu:
		context_menu.queue_free()
	context_menu_active = false
	
	DesktopState.current_state = DesktopState.State.IDLE

func _on_context_menu_button_pressed(command) -> void:
	context_menu_button_pressed.emit(node, command)
	close_menu()
