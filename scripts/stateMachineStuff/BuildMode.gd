extends State
class_name BuildMode

# I'm calling it now
# A lot of this code is most likely redundant and can probably be done easier
# If an easier solution IS found, slap me.


@export var left_grab_function : GrabFunction
@export var right_grab_function : GrabFunction
@export var settings_controller : XRController3D

var button_pressed : bool = true

func enter():
	$"../../XRCamera3D/MeshInstance3D".visible = true
	left_grab_function.snappable = true
	right_grab_function.snappable = true
	button_pressed = true

func exit():
	$"../../XRCamera3D/MeshInstance3D".visible = false
	left_grab_function.snappable = false
	right_grab_function.snappable = false
	
	
func update(delta: float):
	if button_pressed:
		if !settings_controller.is_button_pressed("ax_button"):
			button_pressed = false
	if settings_controller.is_button_pressed("ax_button"):
		Transitioned.emit(self, "PlayMode")
		
