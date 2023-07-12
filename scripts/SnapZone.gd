extends Area3D
class_name ModuleSnapZone

var closest_module: RigidBody3D
var snapped_module: RigidBody3D

var joint : Joint3D

@export_enum("Generic", "Socket") var joint_type : String = "Generic"
@export_enum("Cube", "Sphere", "Bigger Sphere") var collision_type : String = "Cube"

func snap_module(module: RigidBody3D):
	if snapped_module:
		return
	if module is Module:
			for i in module.snapped_to:
				if i == get_parent():
					return
	#No sanity checking yet, jus gonna assume parent is a Module cuz why wouldn't it be
	joint = get_parent().spawn_joint(joint_type)
	$RemoteTransform3D.remote_path = joint.get_path()
	joint.node_a = get_parent().get_path()
	joint.node_b = module.get_path()
	snapped_module = module
	module.disconnect("snapped", snap_module)
	if module is Module: 
		module.snapped_to += [get_parent()]
		get_parent().snapped_to += [module]
	# Configure Settings
	if joint_type == "Generic":
		# Set Location softness to be more rigid
		joint.set_param_x(2, 2.0)
		joint.set_param_y(2, 2.0)
		joint.set_param_z(2, 2.0)
	
	


func _on_body_entered(body: RigidBody3D):
	if body == get_parent():
		return
	closest_module = body
	body.connect("snapped", snap_module)



func _on_body_exited(body: RigidBody3D):
	if body == get_parent():
		return
	
	if body == snapped_module:
		if body.held == true:
			return
		return
		joint.queue_free()
		joint = null
		$RemoteTransform3D.remote_path = ""
		snapped_module = null
		
	elif body == closest_module:
		closest_module = null
		body.disconnect("snapped", snap_module)
	return

func update_child_was_grabbed():
	if snapped_module is Module:
		snapped_module.register_grab()
		snapped_module.emit_signal("grabbed")
	
	
func update_child_was_let_go():
	if snapped_module:
		if snapped_module is Module:
			snapped_module.unregister_grab()
			snapped_module.emit_signal("ungrabbed")
		
	


func _ready():
	get_parent().connect("grabbed", update_child_was_grabbed)
	get_parent().connect("ungrabbed", update_child_was_let_go)
	if collision_type != "Cube":
		if collision_type == "Sphere":
			$Sphere.disabled = false
			$BiggerSphere.disabled = true 
			$Cube.disabled = true
		else:
			$Sphere.disabled = true
			$BiggerSphere.disabled = false
			$Cube.disabled = true
	else:
		$Sphere.disabled = true
		$BiggerSphere.disabled = true 
		$Cube.disabled = false



