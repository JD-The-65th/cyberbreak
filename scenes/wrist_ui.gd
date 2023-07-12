extends Control


func _on_home_button_pressed() -> void:
	$"Quick Access Menu".visible = !$"Quick Access Menu".visible
