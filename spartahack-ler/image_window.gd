extends Window
@export var imagePath = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sprite2D.texture = load(imagePath)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
