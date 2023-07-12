extends Area3D

var closest_module: RigidBody3D
var snapped_module: RigidBody3D

var joint : Joint3D

func snap_module(module: RigidBody3D):
	#No sanity checking yet, jus gonna assume parent is a Module cuz why wouldn't it be
	joint = get_parent().spawn_joint()
	$RemoteTransform3D.remote_path = joint.get_path() 
	joint.node_a = get_parent().get_path()
	joint.node_b = module.get_path()
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
		joint.queue_free()
		joint = null
		$RemoteTransform3D.remote_path = null
		snapped_module = null
		
	elif body == closest_module:
		closest_module = null
		body.disconnect("snapped", snap_module)
	return
