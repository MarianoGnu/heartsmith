extends Control


onready var _scene_path = $scene_path
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_languages_visibility_changed():
	var english_button = _scene_path.get_english_button()
	var spanish_button = _scene_path.get_spanish_button()
	
	if !english_button.visible:
		return
	
	if TranslationServer.get_locale() == "es":
		spanish_button.grab_focus()
	else:
		english_button.grab_focus()

func _on_english_pressed():
	TranslationServer.set_locale("en")

func _on_spanish_pressed():
	TranslationServer.set_locale("es")

func _on_game_started():
	get_tree().change_scene("res://scenes/world/cabin/cabin.tscn")
