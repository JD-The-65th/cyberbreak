extends Control


func _on_home_button_pressed() -> void:
	$MainMenu.visible = !$MainMenu.visible
