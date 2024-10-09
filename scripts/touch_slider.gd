extends TouchScreenButton

var slider_value: float
signal slider_active_signal (value:float)


@onready var slider_knob = $SliderKnob
@onready var slider_max_x_position: float = self.texture_normal.get_size().x
@onready var slider_min_x_position: float = 0.0
@onready var knob_center_offset: float = (slider_knob.texture.get_size().x)/2



var pressing:bool =	false



func _unhandled_input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if pressing:
			var event_x_pos = event.position.x - global_position.x
			event_x_pos = clamp(event_x_pos,slider_min_x_position,slider_max_x_position)
			slider_value = (event_x_pos / (slider_max_x_position-slider_min_x_position)) * 100
			slider_knob.position.x = event_x_pos - knob_center_offset
			emit_signal("slider_active_signal",slider_value)

func _update_value(value: float) -> void:
	value = clamp(value, 0 , 100)
	var new_x_pos = (((slider_max_x_position-slider_min_x_position)/100) * value) - knob_center_offset
	slider_knob.position.x = slider_min_x_position + new_x_pos 

func _on_pressed():
	pressing = true

func _on_released():
	pressing = false
