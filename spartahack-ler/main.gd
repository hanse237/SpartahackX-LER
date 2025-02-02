extends Control
@onready var directions = [$PanelContainer/ScreenOne,
						   $PanelContainer/ScreenTwo,
						   $PanelContainer/ScreenThree,
						   $PanelContainer/ScreenFour]
@onready var activePanel = $PanelContainer/ScreenOne
@export var imageWindow : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/ScreenOne/Page1.connect("clicked", _on_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Button.visible = false
	$Label2.visible = false
	$PanelContainer3.visible = false


func _on_up_button_pressed() -> void:
	set_active_panel(0)


func _on_down_button_pressed() -> void:
	set_active_panel(1)


func _on_left_button_pressed() -> void:
	set_active_panel(2)


func _on_right_button_pressed() -> void:
	set_active_panel(3)


func set_active_panel(dir) -> void:
	activePanel.visible = false
	activePanel = directions[dir]
	activePanel.visible = true


func _on_button_2_pressed() -> void:
	$Label.text += 'a'


func _on_clicked(message, active) -> void:
	if not active:
		$Label.text = message
		return
	
	match message:
		"page1":
			var page = imageWindow.instantiate()
			page.imagePath = "res://icon.svg"
			add_child.call_deferred(page)
		"page2":
			pass
		"page3":
			pass
		"page4":
			pass
