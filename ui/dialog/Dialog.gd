extends CanvasLayer

onready var _panel = $panel
onready var _anim = $anim
onready var _sound = $sound
onready var _text = $panel/text
onready var _tween = $tween
onready var frame_idle: ProxyTexture = load("res://ui/dialog/frames/idle.tres")
onready var frame_1: ProxyTexture = load("res://ui/dialog/frames/frame1.tres")
onready var frame_2: ProxyTexture = load("res://ui/dialog/frames/frame2.tres")

onready var _pitch_effect: AudioEffectPitchShift = AudioServer.get_bus_effect(AudioServer.get_bus_index("Character"), 0)
const CHAR_PER_SECONDS = 10.0

func _ready():
	set_process_input(false)
	_tween.connect("tween_all_completed", self, "_on_text_displayed")

func set_portraitset(portrait: PortraitSet):
	if !is_instance_valid(portrait):
		_anim.play("faceless")
		_anim.seek(0)
		_pitch_effect.pitch_scale = 1
	else:
		_anim.play("faceful")
		_anim.seek(0)
		frame_idle.base = portrait.idle
		frame_1.base = portrait.frame1
		frame_2.base = portrait.frame2
		_pitch_effect.pitch_scale = portrait.voice_pitch

func show_message(message: String, speed: float = 1.0, portrait: PortraitSet = null):
	get_tree().paused = true
	set_portraitset(portrait)
	_text.percent_visible = 0
	_text.text = tr(message)
	var time = float(len(_text.text)) / CHAR_PER_SECONDS
	_tween.interpolate_property(_text, "percent_visible", 0, 1, time,Tween.TRANS_LINEAR,Tween.EASE_IN, 0.2)
	get_tree().create_timer(0.2).connect("timeout", _sound, "play")
	get_tree().create_timer(0.2 + time).connect("timeout", _sound, "stop")
	_tween.interpolate_property(_panel, "visible", false, true, 0.2,Tween.TRANS_LINEAR,Tween.EASE_IN)
	_anim.queue("talking")
	_tween.start()

func _on_text_displayed():
	_anim.play("stop")
	yield(get_tree().create_timer(0.3), "timeout")
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().paused = false
		_panel.hide()
		set_process_input(false)
