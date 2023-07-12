extends RigidBody3D
class_name Module

signal snapped(module: RigidBody3D)
signal unsnapped

signal scaled(new_scale: Vector3)

signal grabbed
signal ungrabbed

## Signifies if the module is held or not
var held : bool = false

var original_collision_layer
var original_collision_mask
var picked_up_layers = pow(2, 17-1) 
var picked_up_mask = pow(2, 1-1) + pow(2, 2-1) + pow(2, 3-1) + pow(2, 17-1)

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

## Remotely registers a grab
func register_grab():
	original_collision_layer = collision_layer
	original_collision_mask = collision_mask
	collision_layer = picked_up_layers
	collision_mask = picked_up_mask
	
## Remotely unregisters a grab
func unregister_grab():
	collision_layer = original_collision_layer
	collision_mask = original_collision_mask
	
	
