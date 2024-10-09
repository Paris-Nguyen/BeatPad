extends Node2D

const BUTTONTEXTURE01NORMAL = preload("res://button_textures/Button001.svg")
const BUTTONTEXTURE01NORMALPRESSED = preload("res://button_textures/Button001_Pressed.svg")
const BUTTONTEXTURE02NORMAL = preload("res://button_textures/Button002.svg")
const BUTTONTEXTURE02NORMALPRESSED = preload("res://button_textures/Button002_Pressed.svg")
const BUTTONTEXTURE03NORMAL = preload("res://button_textures/Button003.svg")
const BUTTONTEXTURE03NORMALPRESSED = preload("res://button_textures/Button003_Pressed.svg")

@onready var buttons:Array = [
	$Button01,
	$Button02,
	$Button03,
	$Button04,
	$Button05,
	$Button06,
	$Button07,
	$Button08,
	$Button09,
	$Button10,
	$Button11,
	$Button12,
	$Button13,
	$Button14,
	$Button15,
	$Button16,
	]



func set_button_play_texture(index:int) -> void:
	buttons[index].set_texture_normal(BUTTONTEXTURE01NORMAL)
	buttons[index].set_texture_pressed(BUTTONTEXTURE01NORMALPRESSED)

func set_button_edit_texture(index:int) -> void:
	buttons[index].set_texture_normal(BUTTONTEXTURE02NORMAL)
	buttons[index].set_texture_pressed(BUTTONTEXTURE02NORMALPRESSED)	



func _on_button_01_pressed() -> void:
	Input.action_press("button01")

func _on_button_01_released() -> void:
	Input.action_release("button01")


func _on_button_02_pressed() -> void:
	Input.action_press("button02")


func _on_button_02_released() -> void:
	Input.action_release("button02")


func _on_button_03_pressed() -> void:
	Input.action_press("button03")


func _on_button_03_released() -> void:
	Input.action_release("button03")


func _on_button_04_pressed() -> void:
	Input.action_press("button04")


func _on_button_04_released() -> void:
	Input.action_release("button04")


func _on_button_05_pressed() -> void:
	Input.action_press("button05")


func _on_button_05_released() -> void:
	Input.action_release("button05")


func _on_button_06_pressed() -> void:
	Input.action_press("button06")


func _on_button_06_released() -> void:
	Input.action_release("button06")


func _on_button_07_pressed() -> void:
	Input.action_press("button07")


func _on_button_07_released() -> void:
	Input.action_release("button07")


func _on_button_08_pressed() -> void:
	Input.action_press("button08")


func _on_button_08_released() -> void:
	Input.action_release("button08")


func _on_button_09_pressed() -> void:
	Input.action_press("button09")


func _on_button_09_released() -> void:
	Input.action_release("button09")

func _on_button_10_pressed() -> void:
	Input.action_press("button10")


func _on_button_10_released() -> void:
	Input.action_release("button10")


func _on_button_11_pressed() -> void:
	Input.action_press("button11")


func _on_button_11_released() -> void:
	Input.action_release("button11")


func _on_button_12_pressed() -> void:
	Input.action_press("button12")


func _on_button_12_released() -> void:
	Input.action_release("button12")


func _on_button_13_pressed() -> void:
	Input.action_press("button13")


func _on_button_13_released() -> void:
	Input.action_release("button13")


func _on_button_14_pressed() -> void:
	Input.action_press("button14")


func _on_button_14_released() -> void:
	Input.action_release("button14")


func _on_button_15_pressed() -> void:
	Input.action_press("button15")


func _on_button_15_released() -> void:
	Input.action_release("button15")


func _on_button_16_pressed() -> void:
	Input.action_press("button16")


func _on_button_16_released() -> void:
	Input.action_release("button16")


func _on_button_menu_pressed() -> void:
	Input.action_press("button_menu")
	
func _on_button_menu_released() -> void:
	Input.action_release("button_menu")


func _on_button_quit_pressed() -> void:
	Input.action_press("button_quit")

func _on_button_quit_released() -> void:
	Input.action_release("button_quit")
