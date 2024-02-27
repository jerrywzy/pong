extends Control

@onready var main = $"../"

func _on_resume_pressed():
	main.paused = false
	main.pause_game()


func _on_menu_pressed():
	main.paused = false
	main.pause_game()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
