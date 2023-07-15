extends State
class_name PlayMode


@export var settings_controller : XRController3D

func _ready() -> void:
	settings_controller.connect("button_pressed", hand_button_pressed)


func hand_button_pressed(name: String) -> void:
	if name == "ax_button":
		Transitioned.emit(self, "BuildMode")
