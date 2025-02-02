extends Control
@onready var directions = [$PanelContainer/ScreenOne,
						   $PanelContainer/ScreenTwo,
						   $PanelContainer/ScreenThree,
						   $PanelContainer/ScreenFour]
@onready var activePanel = $PanelContainer/ScreenOne

# Flags tracking progression
var flags = {"chair": false,
			 "key": false,
			 "chest": false,
			 "lever": false,
			 "fire": false}

# Flags tracking pages found
var pages = [false, false, false, false, false, false,
			 false, false, false, false, false, false]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/ScreenOne/Page1.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page2.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page3.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page4.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page5.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page6.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page7.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page8.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Page9.connect("clicked", _on_clicked)
	$PanelContainer/ScreenTwo/Page10.connect("clicked", _on_clicked)
	$PanelContainer/ScreenThree/Page11.connect("clicked", _on_clicked)
	$PanelContainer/ScreenFour/Page12.connect("clicked", _on_clicked)
	$PanelContainer/ScreenFour/Door.connect("clicked", _on_clicked)
	$PanelContainer/ScreenFour/DoorOpen.connect("clicked", _on_clicked)
	$PanelContainer/ScreenThree/Fire.connect("clicked", _on_clicked)
	$PanelContainer/ScreenOne/Chair.connect("clicked", _on_clicked)
	$PanelContainer/ScreenTwo/Painting1.connect("clicked", _on_clicked)
	$PanelContainer/ScreenThree/Painting2.connect("clicked", _on_clicked)
	$PanelContainer/ScreenFour/Painting3.connect("clicked", _on_clicked)
	
	$Sym1.connect("clicked", _on_symbol_click)
	$Sym2.connect("clicked", _on_symbol_click)
	$Sym3.connect("clicked", _on_symbol_click)
	$Sym4.connect("clicked", _on_symbol_click)
	$Sym5.connect("clicked", _on_symbol_click)
	$Sym6.connect("clicked", _on_symbol_click)
	$Sym7.connect("clicked", _on_symbol_click)
	$Sym8.connect("clicked", _on_symbol_click)
	$Sym9.connect("clicked", _on_symbol_click)
	$Sym10.connect("clicked", _on_symbol_click)
	$Sym11.connect("clicked", _on_symbol_click)
	$Sym12.connect("clicked", _on_symbol_click)
	$Sym13.connect("clicked", _on_symbol_click)
	$Sym14.connect("clicked", _on_symbol_click)
	$Sym15.connect("clicked", _on_symbol_click)
	$Sym16.connect("clicked", _on_symbol_click)
	$Sym17.connect("clicked", _on_symbol_click)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Button.visible = false
	$Label2.visible = false
	$PanelContainer3/TitleScreen.visible = false
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


func _on_clicked(message, active) -> void:
	$Label.text = ""
	if not active:
		$Label.text = message
		return
	
	match message:
		"page1", "page2", "page3", "page4", "page5", "page6", "page7", "page8", "page9", "page10", "page11", "page12", "pt1", "pt2", "pt3":
			if message[1] == 'a':
				pages[int(message.substr(4,5)) - 1] = true
				if not false in pages:
					flags["chair"] = true
			var pathTemplate = "res://assets/%s.png"
			var window = preload("res://imageWindow.tscn").instantiate()
			window.imagePath = pathTemplate % message
			add_child.call_deferred(window)
		"lever":
			if not flags["chest"]:
				$Label.text = "It resists your pull."
			else:
				$Label.text = "You pull the level"
				flags["lever"] = true
				flags["chest"] = false
		"box":
			if not flags["key"]:
				$Label.text = "It's locked tight."
			else:
				$Label.text = "Inside the chest, you find a note."
				flags["chest"] = true
				flags["key"] = false
		"chair":
			if not flags["chair"]:
				$Label.text = "There's no time to sit now."
			else:
				$Label.text = "You found a key under the chair."
				flags["key"] = true
				flags["chair"] = false
		"fire":
			if not pages[11]:
				$Label.text = "The fire rages."
			else:
				flags["fire"] = true
				$Label.text = "You burn the page and hear a click."
				$PanelContainer/ScreenFour/Door.visible = false
				$PanelContainer/ScreenFour/DoorOpen.visible = true
		"door":
			if not flags["fire"]:
				$Label.text = "It's locked."
			else:
				$PanelContainer3/EndScreen.visible = true
				$PanelContainer3.visible = true


func _on_symbol_click(message, active) -> void:
	$Label.text = ""
	
	match message:
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
		"sym1":
			pass
