extends Window
@export var imagePath = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if imagePath != "":
		$Sprite2D.texture = load(imagePath)
		$".".size = $Sprite2D.texture.get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_requested() -> void:
	hide()
