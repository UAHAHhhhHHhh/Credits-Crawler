extends Node

# Called to reset the current level
func end():
	get_tree().reload_current_scene()
