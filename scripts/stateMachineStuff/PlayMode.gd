extends State
class_name PlayMode


@export var settings_controller : XRController3D

var is_current_state : bool = false
func enter():
	is_current_state = true
	
func exit():
	is_current_state = true

func _ready() -> void:
	settings_controller.connect("button_pressed", hand_button_pressed)


func hand_button_pressed(name: String) -> void:
	if name == "ax_button":
		if is_current_state:
			Transitioned.emit(self, "BuildMode")
