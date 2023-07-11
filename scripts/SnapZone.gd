extends Area3D

var closest_module: RigidBody3D
var snapped_module: RigidBody3D

func _ready():
	# Disable Location Tracking
	get_parent().set_flag_x(0, false)
	get_parent().set_flag_y(0, false)
	get_parent().set_flag_z(0, false)
	# Disable Rotation Tracking
	get_parent().set_flag_x(1, false)
	get_parent().set_flag_y(1, false)
	get_parent().set_flag_z(1, false)

func snap_module(module: RigidBody3D):
	#No sanity checking yet, jus gonna assume parent is a Joint
	get_parent().node_a = get_path_to(module)
	# Location Tracking
	get_parent().set_flag_x(0, true)
	get_parent().set_flag_y(0, true)
	get_parent().set_flag_z(0, true)
	# Rotation Tracking
	get_parent().set_flag_x(1, true)
	get_parent().set_flag_y(1, true)
	get_parent().set_flag_z(1, true)
	
	snapped_module = module


func _on_body_entered(body: RigidBody3D):
	if body == get_parent().get_parent(): #Janky as hell, but hey, it works
		return
	closest_module = body
	body.connect("snapped", snap_module)



func _on_body_exited(body: RigidBody3D):
	if body == get_parent().get_parent(): #Janky as hell, but hey, it works
		return
		
	if body == snapped_module:
		return # I'll handle this later
	elif body == closest_module:
		closest_module = null
		body.disconnect("snapped", snap_module)
	return
