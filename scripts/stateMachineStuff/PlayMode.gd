extends State
class_name PlayMode


@export var settings_controller : XRController3D


func enter():
	await get_tree().create_timer(1).timeout

func update(delta: float):
	if settings_controller.is_button_pressed("ax_button"):
		build_mode_entered()


func build_mode_entered():
	Transitioned.emit(self, "BuildMode")
	
