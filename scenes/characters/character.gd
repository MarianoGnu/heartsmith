tool
extends Node2D

enum Facing {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

enum Anim {
	IDLE,
	WALK
}

export (Facing) var facing = Facing.UP setget _set_facing
export (Anim) var animation = Anim.IDLE setget _set_anim
export (String) var dialog = "" setget _set_dialog

export (Texture) var sprite_front = null
export (Texture) var sprite_back = null
export (Texture) var sprite_left = null
export (Resource) var portrait = null


onready var _sprite = $sprite
onready var _anim = $anim

func _ready():
	_set_facing(facing)
	if portrait != null:
		assert (portrait is PortraitSet)

func _set_facing(direction):
	facing = direction
	if !is_instance_valid(_sprite):
		return
	match direction:
		Facing.UP:
			_sprite.texture = sprite_back
			_sprite.flip_h = false
		Facing.DOWN:
			_sprite.texture = sprite_front
			_sprite.flip_h = false
		Facing.LEFT:
			_sprite.texture = sprite_left
			_sprite.flip_h = false
		Facing.RIGHT:
			_sprite.texture = sprite_left
			_sprite.flip_h = true

func _set_anim(anim):
	animation = anim
	if !is_instance_valid(_anim):
		return
	match anim:
		Anim.IDLE:
			_anim.play("idle")
		Anim.WALK:
			_anim.play("walk")

func _set_dialog(text):
	dialog = text
	if Engine.editor_hint:
		return
	if is_inside_tree():
		Dialog.show_message(tr(text), 1, portrait)
