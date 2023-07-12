extends RigidBody3D
class_name Module

signal snapped(module: RigidBody3D)
signal unsnapped

signal scaled(new_scale: Vector3)

var held : bool = false


func spawn_joint(type: String = "Generic") -> Joint3D: ## Spawns a Physics Joint as a sibling and returns it.
	var joint = Joint3D
	if type == "Socket":
		joint = ConeTwistJoint3D.new()
	else:
		joint = Generic6DOFJoint3D.new()
	
	add_sibling(joint)
	return joint
	
