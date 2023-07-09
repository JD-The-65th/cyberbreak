extends StaticBody3D
class_name GrabFunction

@onready var joint = $Generic6DOFJoint3D

var closest_object : Node3D = null
var picked_up_object : Node3D = null
var grip_pressed : bool = false
var snappable : bool = false

## Grip controller axis
@export var pickup_axis_action : String = "grip"

## Controller
@onready var _controller := XRHelpers.get_xr_controller(self)

## Grip threshold (from configuration)
@onready var _grip_threshold : float = XRTools.get_grip_threshold()


# Collision Layer and Mask for picked up objects
@export_flags_3d_physics var picked_up_layers = pow(2, 17-1) 

@export_flags_3d_physics var picked_up_mask = pow(2, 1-1) + pow(2, 2-1) + pow(2, 3-1) + pow(2, 17-1)




#Remember previous collision mask and layer
@onready var original_collision_layer : int
@onready var original_collision_mask : int



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var grip_value = _controller.get_float(pickup_axis_action)
	if (grip_pressed and grip_value < (_grip_threshold - 0.1)):
		grip_pressed = false
		_on_grip_release()
	elif (!grip_pressed and grip_value > (_grip_threshold + 0.1)):
		grip_pressed = true
		_on_grip_pressed()



func _on_grip_pressed():
	if closest_object:
		joint.node_b = closest_object.get_path()
		picked_up_object = closest_object
		original_collision_layer = picked_up_object.collision_layer
		original_collision_mask = picked_up_object.collision_mask
		picked_up_object.set_collision_layer(picked_up_layers)
		if snappable:
			picked_up_object.physics_layer += pow(2, 12-1)
		picked_up_object.set_collision_mask(picked_up_mask)
		
		
		
	
func _on_grip_release():
	if picked_up_object:
		joint.node_b = ""
		picked_up_object.set_collision_layer(original_collision_layer)
		picked_up_object.set_collision_mask(original_collision_mask)
		if snappable:
			picked_up_object.emit_signal("snapped", picked_up_object)
		
		picked_up_object = null


func _on_area_3d_body_entered(body):
	if body == picked_up_object:
		pass
	elif body.get_class() == "RigidBody3D":
		closest_object = body
	



func _on_area_3d_body_exited(body):
	if body == picked_up_object:
		pass
	elif closest_object:
		closest_object = null
