extends Control

func _on_play_one_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1p.tscn")


func _on_play_two_pressed():
	get_tree().change_scene_to_file("res://scenes/level_2p.tscn")


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
