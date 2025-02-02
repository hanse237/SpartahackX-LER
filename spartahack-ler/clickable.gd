extends Node2D
@export var message = ""
@export var active = false
@export var imagePath = ""
var mouse_in = false
signal clicked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if imagePath != "":
		$Area2D/Sprite2D.texture = load(imagePath)
		$Area2D/CollisionShape2D.shape.set_size(Vector2($Area2D/Sprite2D.texture.get_width(),
														$Area2D/Sprite2D.texture.get_height()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	mouse_in = true


func _on_area_2d_mouse_exited() -> void:
	mouse_in = false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("LeftClick") and mouse_in == true:
		emit_signal("clicked", message, active)
