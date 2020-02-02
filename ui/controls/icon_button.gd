tool
extends Button
class_name HeartButton

const dummy_icon = preload("res://ui/icons/dummy.png")
const color_focus = Color("fdff34")
const color_unfocus = Color("cc5318")

export (Texture) var unfocus_icon = null
export (Texture) var focus_icon = null
export (Texture) var disabled_icon = null

var _icon = null

func _ready():
	icon = dummy_icon
	if !is_instance_valid(unfocus_icon):
		icon = null
	_icon = TextureRect.new()
	add_child(_icon)
	_icon.set_anchor_and_margin(MARGIN_LEFT, 0, 12, false)
	_icon.set_anchor_and_margin(MARGIN_RIGHT, 0, 48, false)
	_icon.set_anchor_and_margin(MARGIN_TOP, 0, 6, false)
	_icon.set_anchor_and_margin(MARGIN_BOTTOM, 0, 6, false)
	_input(null)

func _input(event:InputEvent):
	
	var hover = false
	if event is InputEventMouse:
		var rect = Rect2(rect_global_position, rect_size)
		hover = rect.has_point(event.global_position)
	
	var next_icon = null
	add_color_override("font_color", color_unfocus)
	if disabled:
		next_icon = disabled_icon
	elif has_focus() or hover or pressed:
		next_icon = focus_icon
		add_color_override("font_color", color_focus)
	else:
		next_icon = unfocus_icon
	
	if _icon.texture != next_icon:
		_icon.texture = next_icon

 
