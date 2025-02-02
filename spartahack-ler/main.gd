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
			 false, false, false, false, false, false, false]

var symbols = ["sym1",
			   "sym2",
			   "sym3",
			   "sym4",
			   "sym5",
			   "sym6",
			   "sym7",
			   "sym8",
			   "sym9",
			   "sym10",
			   "sym11",
			   "sym12",
			   "sym13",
			   "sym14",
			   "sym15",
			   "sym16",
			   "sym17"]

var symbolPos = 241

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sym1.connect("clicked", _on_clicked)
	$Sym2.connect("clicked", _on_clicked)
	$Sym3.connect("clicked", _on_clicked)
	$Sym4.connect("clicked", _on_clicked)
	$Sym5.connect("clicked", _on_clicked)
	$Sym6.connect("clicked", _on_clicked)
	$Sym7.connect("clicked", _on_clicked)
	$Sym8.connect("clicked", _on_clicked)
	$Sym9.connect("clicked", _on_clicked)
	$Sym10.connect("clicked", _on_clicked)
	$Sym11.connect("clicked", _on_clicked)
	$Sym12.connect("clicked", _on_clicked)
	$Sym13.connect("clicked", _on_clicked)
	$Sym14.connect("clicked", _on_clicked)
	$Sym15.connect("clicked", _on_clicked)
	$Sym16.connect("clicked", _on_clicked)
	$Sym17.connect("clicked", _on_clicked)
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
	$PanelContainer/ScreenTwo/Box.connect("clicked", _on_clicked)
	$PanelContainer/ScreenTwo/BoxOpen.connect("clicked", _on_clicked)
	$PanelContainer/ScreenTwo/BoxClosed.connect("clicked", _on_clicked)
	$PanelContainer/ScreenTwo/ButtonOff.connect("clicked", _on_clicked)
	$PanelContainer/ScreenTwo/ButtonOn.connect("clicked", _on_clicked)
	$PanelContainer/ScreenTwo/ButtonPressed.connect("clicked", _on_clicked)


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
	if message in symbols:
		_on_symbol_click(message, active)
		return
	
	$Label.text = ""
	for char in get_tree().get_nodes_in_group("chars"):
		char.queue_free()
	symbolPos = 241
	if not active:
		$Label.text = message
		return
	
	match message:
		"page1", "page2", "page3", "page4", "page5", "page6", "page7", "page8", "page9", "page10", "page11", "page12", "pt1", "pt2", "pt3":
			if message[1] == 'a':
				pages[int(message.substr(4,5)) - 1] = true
				if not false in pages.slice(0,11):
					flags["chair"] = true
			var pathTemplate = "res://assets/%s.png"
			var window = preload("res://imageWindow.tscn").instantiate()
			window.imagePath = pathTemplate % message
			add_child.call_deferred(window)
		"lever":
			if not flags["chest"]:
				$Label.text = "It does nothing when pressed."
			else:
				$Label.text = "A new page falls."
				flags["lever"] = true
				flags["chest"] = false
				var window = preload("res://imageWindow.tscn").instantiate()
				window.imagePath = "res://assets/winmessage.png"
				add_child.call_deferred(window)
				pages[12] = true
				$PanelContainer/ScreenTwo/ButtonOn.visible = false
				$PanelContainer/ScreenTwo/ButtonPressed.visible = true
		"box":
			if not flags["key"]:
				$Label.text = "It's locked tight."
			elif $PanelContainer/ScreenTwo/BoxOpen.visible == true:
				$Label.text = "It's empty"
			else:
				$Label.text = "Inside the chest, you find a note."
				$PanelContainer/ScreenTwo/BoxClosed.visible = false
				$PanelContainer/ScreenTwo/BoxOpen.visible = true
				flags["chest"] = true
				flags["key"] = false
				$PanelContainer/ScreenTwo/ButtonOff.visible = false
				$PanelContainer/ScreenTwo/ButtonOn.visible = true
		"chair":
			if not flags["chair"]:
				$Label.text = "There's no time to sit now."
			else:
				$Label.text = "You found a key under the chair."
				flags["key"] = true
				flags["chair"] = false
		"fire":
			if not pages[12]:
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
				$Label2.text = "Congratulations!"
				$Label2.visible = true


func _on_symbol_click(message, active) -> void:
	if not active:
		return
	
	$Label.text = ""
	var char = preload("res://clickable.tscn").instantiate()
	char.add_to_group("chars")
	
	match message:
		"sym1":
			char.imagePath = "res://assets/bookc.png"
		"sym2":
			char.imagePath = "res://assets/buttonc.png"
		"sym3":
			char.imagePath = "res://assets/chairc.png"
		"sym4":
			char.imagePath = "res://assets/doc.png"
		"sym5":
			char.imagePath = "res://assets/firec.png"
		"sym6":
			char.imagePath = "res://assets/helpc.png"
		"sym7":
			char.imagePath = "res://assets/highc.png"
		"sym8":
			char.imagePath = "res://assets/Ic.png"
		"sym9":
			char.imagePath = "res://assets/keyc.png"
		"sym10":
			char.imagePath = "res://assets/notc.png"
		"sym11":
			char.imagePath = "res://assets/personc.png"
		"sym12":
			char.imagePath = "res://assets/thisc.png"
		"sym13":
			char.imagePath = "res://assets/wantc.png"
		"sym14":
			char.imagePath = "res://assets/whatc.png"
		"sym15":
			char.imagePath = "res://assets/wherec.png"
		"sym16":
			char.imagePath = "res://assets/Youc.png"
		"sym17":
			char.imagePath = "res://assets/doorc.png"
	
	
	char.apply_scale(Vector2(.5, .5))
	char.position = Vector2(symbolPos, 625)
	add_child.call_deferred(char)
	symbolPos += 60
