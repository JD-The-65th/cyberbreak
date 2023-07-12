extends State
class_name BuildMode

# I'm calling it now
# A lot of this code is most likely redundant and can probably be done easier
# If an easier solution IS found, slap me.


@export var left_grab_function : GrabFunction
@export var right_grab_function : GrabFunction
@export var settings_controller : XRController3D

func enter():
	$"../../XRCamera3D/MeshInstance3D".visible = true
	left_grab_function.snappable = true
	right_grab_function.snappable = true
	await get_tree().create_timer(1).timeout

func exit():
	$"../../XRCamera3D/MeshInstance3D".visible = false
	left_grab_function.snappable = false
	right_grab_function.snappable = false
	
	
func update(delta: float):
	if settings_controller.is_button_pressed("ax_button"):
		Transitioned.emit(self, "PlayMode")
		
