extends Node

export (NodePath) var english_button = ""
export (NodePath) var spanish_button = ""

func get_english_button():
	return get_node(english_button)
	
func get_spanish_button():
	return get_node(spanish_button)
