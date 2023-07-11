extends Area3D

var closest_module: RigidBody3D
var snapped_module: RigidBody3D



func snap_module(module: RigidBody3D):
	#No sanity checking yet, jus gonna assume parent is a Joint
	get_parent().node_b = get_path_to(module)
	# We need to set Node A here since it dies funky stuff if we don't
	get_parent().node_a = get_path_to(get_parent().get_parent()) # I know this path is insecure, just ignore it for now.
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
