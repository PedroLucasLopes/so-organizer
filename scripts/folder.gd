class_name Folder extends SOIcon

@onready var sprite_2d: Sprite2D = $Base/Sprite2D
@onready var area_2d: Area2D = $Base/Area2D

var mouse_over: bool = false
var current_area_overlap: Area2D = null
var files: Node2D = Node2D.new()

func _ready() -> void:
	files.name = "Files"
	add_child(files)
	add_to_group('folder')
	area_2d.area_entered.connect(_on_overlap_folder)
	area_2d.area_exited.connect(_on_area_exited)

func _on_overlap_folder(other_area: Area2D) -> void:
	if other_area.get_parent().is_in_group("icons"):
		mouse_over = true
		current_area_overlap = other_area

func _on_area_exited(other_area: Area2D) -> void:
	mouse_over = false
	if current_area_overlap == other_area:
		current_area_overlap = null

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		if mouse_over:
			enter_the_folder(current_area_overlap)
			current_area_overlap = null
			
func enter_the_folder(other_area: Area2D) -> void:
	if other_area and is_instance_valid(other_area):
		var parent = other_area.get_parent()
		if parent and is_instance_valid(parent) and parent.has_method("enter_folder"):
			var world = parent.get_parent()
			parent.enter_folder()
			parent.global_position = world.global_position
			world.remove_child(parent)
			files.add_child(parent)
