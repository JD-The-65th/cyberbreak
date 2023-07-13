extends State
class_name PlayMode


@export var settings_controller : XRController3D


var button_pressed : bool = true

func enter():
	button_pressed = true

func update(delta: float):
	if button_pressed:
		if !settings_controller.is_button_pressed("ax_button"):
			button_pressed = false
	
	if settings_controller.is_button_pressed("ax_button"):
		build_mode_entered()


func build_mode_entered():
	Transitioned.emit(self, "BuildMode")
	
