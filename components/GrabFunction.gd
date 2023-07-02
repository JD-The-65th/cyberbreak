extends StaticBody3D
class_name GrabFunction

# The Joint the Object attaches to
@onready var joint = $Generic6DOFJoint3D


var closest_object : Node3D = null
var picked_up_object : Node3D = null
var grip_pressed : bool = false

## Grip controller axis
@export var pickup_axis_action : String = "grip"

## Controller
@onready var _controller := XRHelpers.get_xr_controller(self)

## Grip threshold (from configuration)
@onready var _grip_threshold : float = XRTools.get_grip_threshold()

@onready var dblabel : Label3D = $Label3D

# Called when the node enters the scene tree for the first time.
func _ready():
	dblabel.text = "ready"


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
		picked_up_object.set_collision_layer_bit(17, true)
	
func _on_grip_release():
	if picked_up_object:
		picked_up_object.set_collision_layer_bit(17, false)
		joint.node_b = ""
		picked_up_object = null
		


func _on_area_3d_body_entered(body):
	dblabel.text = "body entered"
	if body.get_class() == "RigidBody3D":
		dblabel.text = "body entered + RigidBody"
		closest_object = body
	



func _on_area_3d_body_exited(body):
	if closest_object:
		closest_object = null
