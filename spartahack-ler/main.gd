extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/Panel2/Node2D.connect("clicked", _on_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$PanelContainer/Panel.visible = not $PanelContainer/Panel.visible
	$PanelContainer/Panel2.visible = not $PanelContainer/Panel2.visible


func _on_button_2_pressed() -> void:
	$Label.text += 'a'


func _on_clicked(message) -> void:
	$Label.text = message
