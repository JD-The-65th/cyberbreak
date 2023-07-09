extends Area3D


var closest_object



func _on_body_entered(body):
	if body == get_parent():
		return
	body.connect("snapped", register_snap)
	closest_object = body


func _on_body_exited(body):
	# TODO: No checking cuz I'm too tired to do so rn
	if body == get_parent():
		return
	body.disconnect("snapped", register_snap)
	closest_object = null

func register_snap(object):
	if object == closest_object:
		$Generic6DOFJoint3D.node_b = get_path_to(object)
	
	
