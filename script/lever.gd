class_name Lever extends StaticBody3D

signal enabled_lever(state: bool)

@onready var animation_player: AnimationPlayer = $Body/AnimationPlayer

var enabled: bool = false:
	set = _set_enabled


func _set_enabled(state: bool) -> void:
	enabled = state
	var animation = "new_animation"
	if enabled:
		animation_player.play(animation)
	else:
		animation_player.play_backwards(animation)


func interact() -> void:
	enabled = not enabled
	enabled_lever.emit(enabled)
