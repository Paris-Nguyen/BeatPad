extends CanvasLayer

@onready var save_file_path:String = "user://drum_pad_save_data.tres"
@onready var save_data:Dictionary
@onready var button_pad = $ButtonPad
@onready var label = $Label


var edit_menu: PackedScene = preload("res://scenes/edit_menu.tscn")
var touch_slider_instance: TouchScreenButton
var edit_mode: bool = false
var edit_menu_instance: Node2D
var current_editing_sound:int = 0
var max_db: float = 30.0
var button_pressed: int
var sound_crop_step: float = 0.005

@onready var sounds:Array = [
	$SoundSamples/Sound01,
	$SoundSamples/Sound02,
	$SoundSamples/Sound03,
	$SoundSamples/Sound04,
	$SoundSamples/Sound05,
	$SoundSamples/Sound06,
	$SoundSamples/Sound07,
	$SoundSamples/Sound08,
	$SoundSamples/Sound09,
	$SoundSamples/Sound10,
	$SoundSamples/Sound11,
	$SoundSamples/Sound12,
	$SoundSamples/Sound13,
	$SoundSamples/Sound14,
	$SoundSamples/Sound15,
	$SoundSamples/Sound16,
	]
	
@onready var sounds_start_pos:Array = []

func _ready() -> void:
	# Fill sounds_start_pos array with 0.0 to match sounds array
	sounds_start_pos.resize(sounds.size())
	for i in range(sounds.size()):
		sounds_start_pos [i] = 0.0
	

	_load_sound_data()


func get_button_pressed() -> int:
	if Input.is_action_just_pressed("button01"):
		return 0
	elif Input.is_action_just_pressed("button02"):
		return 1 
	elif Input.is_action_just_pressed("button03"):
		return 2
	elif Input.is_action_just_pressed("button04"):
		return 3
	elif Input.is_action_just_pressed("button05"):
		return 4
	elif Input.is_action_just_pressed("button06"):
		return 5
	elif Input.is_action_just_pressed("button07"):
		return 6
	elif Input.is_action_just_pressed("button08"):
		return 7
	elif Input.is_action_just_pressed("button09"):
		return 8
	elif Input.is_action_just_pressed("button10"):
		return 9
	elif Input.is_action_just_pressed("button11"):
		return 10
	elif Input.is_action_just_pressed("button12"):
		return 11
	elif Input.is_action_just_pressed("button13"):
		return 12
	elif Input.is_action_just_pressed("button14"):
		return 13
	elif Input.is_action_just_pressed("button15"):
		return 14
	elif Input.is_action_just_pressed("button16"):
		return 15
	elif Input.is_action_just_pressed("button_menu"):
		return 30
	elif Input.is_action_just_pressed("button_quit"):
		return 99
	return -1

func _unhandled_input(input_event:InputEvent) -> void:	
	if input_event is InputEventScreenTouch:
		if edit_mode == false: 
			button_pressed = get_button_pressed()  
			if button_pressed >= 0 and button_pressed <= 15:
				sounds[button_pressed].play(sounds_start_pos[button_pressed])
			elif button_pressed == 30:
				_edit_menu()
			elif button_pressed == 99:
				_save_sound_data()
				get_tree().quit()

		elif edit_mode == true:
			button_pressed = get_button_pressed()  
			if button_pressed >= 0 and button_pressed <= 15:
				set_editing_sound(button_pressed)
			elif button_pressed == 30:
				_edit_menu()
			elif button_pressed == 99:
				_save_sound_data()
				get_tree().quit()


func set_editing_sound(new_sound: int) -> void:
	# Switch Texture to new editing sound
	button_pad.set_button_play_texture(current_editing_sound)
	current_editing_sound = new_sound
	button_pad.set_button_edit_texture(current_editing_sound)
	
	# Update volue slider to current sound volume
	touch_slider_instance._update_value(_convert_sound_volume_to_slider_value(sounds[current_editing_sound].volume_db))
	

	# play current sound editing
	sounds[current_editing_sound].play(sounds_start_pos[current_editing_sound])
	label.text = str(sounds_start_pos[current_editing_sound])		


func _on_volume_slider_change(value: float) -> void:
	
	var new_sound_volume:float = _convert_slider_value_to_sound_volume(value)
	if edit_mode == true:
		sounds[current_editing_sound].volume_db = new_sound_volume


func get_audio_length_current_editing_sound() -> float:
	# TODO need to get audio stream length
	return 10.0

	if sounds[current_editing_sound].stream:
		var playback = sounds[current_editing_sound].get_stream_playback()
		if playback:
			return playback.get_length()  # Returns the length of the stream in seconds
	return 0.0


			
func sound_crop_minus() -> void:
	var new_start_pos = sounds_start_pos[current_editing_sound] - sound_crop_step
	#new_start_pos = clamp (new_start_pos, 0.0, get_audio_length_current_editing_sound())	
	sounds_start_pos[current_editing_sound] = new_start_pos
	sounds[current_editing_sound].play(sounds_start_pos[current_editing_sound])
	label.text = str(sounds_start_pos[current_editing_sound])		

func sound_crop_play() -> void:
	sounds[current_editing_sound].play(sounds_start_pos[current_editing_sound])
	label.text = str(sounds_start_pos[current_editing_sound])		

func sound_crop_plus() -> void:
	var new_start_pos = sounds_start_pos[current_editing_sound] + sound_crop_step
	#new_start_pos = clamp (new_start_pos, 0.0, get_audio_length_current_editing_sound())
	sounds_start_pos[current_editing_sound] = new_start_pos
	sounds[current_editing_sound].play(sounds_start_pos[current_editing_sound])
	label.text = str(sounds_start_pos[current_editing_sound])		


func _convert_slider_value_to_sound_volume(value: float) -> float:
	return (value - 50.0) / 50.0 * max_db

func _convert_sound_volume_to_slider_value(value: float) -> float:
	return ((value / max_db) * 50.0 + 50.0)


func _edit_menu() -> void:
	if edit_mode == false:
		edit_menu_instance = edit_menu.instantiate()
		add_child(edit_menu_instance)
		edit_menu_instance.position = Vector2(0,1300)
		
		# connect signal from edit_menu_instance to _on_volume_slider_change function
		touch_slider_instance = edit_menu_instance.get_node("TouchSlider")
		touch_slider_instance.slider_active_signal.connect(_on_volume_slider_change)
		
		# connect signal for buttons on edit menu scene
		edit_menu_instance.button_crop_minus_pressed_signal.connect(sound_crop_minus)
		edit_menu_instance.button_crop_play_pressed_signal.connect(sound_crop_play)		
		edit_menu_instance.button_crop_plus_pressed_signal.connect(sound_crop_plus)
		


		set_editing_sound(current_editing_sound)
		edit_mode = true
		label.visible = true
	elif edit_mode == true:
		_save_sound_data()
		edit_menu_instance.queue_free()
		edit_mode = false
		label.visible = false
		button_pad.set_button_play_texture(current_editing_sound)

func _save_sound_data() -> void:
	var save_beatpad_instance = SaveBeatPad.new()
	
	var temp_sound_data_array:Array[Dictionary] = []
	
	for index in range(sounds.size()):
		var temp_sound_dictionary = {
			"stream": sounds[index].stream,
			"volume_db": sounds[index].volume_db,
			"start_pos": sounds_start_pos[index]
			}
		temp_sound_data_array.append(temp_sound_dictionary)  
	
	save_beatpad_instance.sound_data_array = temp_sound_data_array
	
	ResourceSaver.save(save_beatpad_instance, save_file_path )

func _load_sound_data() -> void:
	if not FileAccess.file_exists(save_file_path):
		return
	
	# Load the custom resource with the saved audio streams and volume
	var save_beatpad_instance = ResourceLoader.load(save_file_path) as SaveBeatPad

	# Assign the loaded streams and volume back to the AudioStreamPlayer nodes
	for index in range(min(sounds.size(), save_beatpad_instance.sound_data_array.size())):
		var temp_sound_dictionary = save_beatpad_instance.sound_data_array[index]
		sounds[index].stream = temp_sound_dictionary["stream"]
		sounds[index].volume_db = temp_sound_dictionary["volume_db"]
		sounds_start_pos [index] = temp_sound_dictionary["start_pos"]
