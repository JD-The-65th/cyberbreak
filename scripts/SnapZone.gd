extends Area3D

var closest_module: RigidBody3D
var snapped_module: RigidBody3D



func snap_module(module: RigidBody3D):
	if get_parent() == Joint3D:
		get_parent().node_b = get_path_to(module)
		snapped_module = module


func _on_body_entered(body: RigidBody3D):
	closest_module = body
	body.connect("snapped", snap_module)



func _on_body_exited(body: RigidBody3D):
	if body == snapped_module:
		return # I'll handle this later
	elif body == closest_module:
		closest_module = null
	return
