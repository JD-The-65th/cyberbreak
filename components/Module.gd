extends RigidBody3D
class_name Module

signal snapped(module: RigidBody3D)
signal unsnapped

signal scaled(new_scale: Vector3)


## Signifies if the module is held or not
var held : bool = false



## Spawns a Physics Joint as a sibling and returns it.
## Possible types are Generic and Socket (ConeTwistJoint3D.)
## If the type is incorrect, it just returns a generic joint.
func spawn_joint(type: String = "Generic") -> Joint3D: 
	var joint = Joint3D
	if type == "Socket":
		joint = ConeTwistJoint3D.new()
	else:
		joint = Generic6DOFJoint3D.new()
	
	add_sibling(joint)
	return joint
	

