extends MeshInstance3D

@onready var root_node : Node3D = self.get_parent().get_parent()



func _ready():
	for i in self.get_children():
		if i.get_class() == "RigidBody3D":
			i.freeze = true
			i.set_gravity_scale(0.0)
			var attachmentPoint : Generic6DOFJoint3D = Generic6DOFJoint3D.new()
			attachmentPoint.set_transform(i.transform)
			attachmentPoint.node_a = get_path_to($StaticBody3D)
			attachmentPoint.node_b = get_path_to(i)
			i.set_meta("attachmentPoint", attachmentPoint)
			i.set_meta("attachedToSpawner", true)
			i.freeze = false
			




func _on_area_3d_body_exited(body: Node3D):
	if body.get_meta("attachedToSpawner"):
		var attachmentPoint = body.get_meta("attachmentPoint")
		attachmentPoint.queue_free()
		body.set_meta("attachedToSpawner", false)
		body.set_gravity_scale(1.0)
		body.set_collision_layer(pow(2, 3-1))
		body.reparent(root_node)
