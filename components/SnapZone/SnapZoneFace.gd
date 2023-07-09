extends Area3D

@export var connect_to : CollisionObject3D

var closest_object


func _ready():
	if connect_to:
		$Generic6DOFJoint3D.node_a = get_path_to(connect_to)

func _on_body_entered(body):
	body.connect("snapped", register_snap)
	closest_object = body


func _on_body_exited(body):
	# TODO: No checking cuz I'm too tired to do so rn
	body.disconnect("snapped", register_snap)
	closest_object = null

func register_snap(object):
	if object == closest_object:
		$Generic6DOFJoint3D.node_b = get_path_to(object)
	
	
