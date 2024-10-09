extends Node2D

signal button_crop_minus_pressed_signal ()
signal button_crop_play_pressed_signal ()
signal button_crop_plus_pressed_signal ()



func _on_button_crop_minus_pressed() -> void:
	#Input.action_press("button_crop_minus")
	emit_signal("button_crop_minus_pressed_signal")

func _on_button_crop_minus_released() -> void:
	Input.action_release("button_crop_minus")

func _on_button_crop_play_pressed() -> void:
	#Input.action_press("button_crop_play")
	emit_signal("button_crop_play_pressed_signal")

func _on_button_crop_play_released() -> void:
	Input.action_release("button_crop_play")

func _on_button_crop_plus_pressed() -> void:
	#Input.action_press("button_crop_plus")
	emit_signal("button_crop_plus_pressed_signal")

func _on_button_crop_plus_released() -> void:
	Input.action_release("button_crop_plus")
