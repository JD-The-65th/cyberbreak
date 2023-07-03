extends MeshInstance3D

@onready var root_node : Node3D = self.get_parent().get_parent()




func _on_area_3d_body_exited(body: Node3D):
	body.set_collision_layer(pow(2, 1-3))
	body.reparent(root_node)
