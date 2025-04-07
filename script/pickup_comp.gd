extends Node3D

@export var parent: Node3D
var following: Node3D


func _process(delta: float) -> void:
	if following:
		parent.global_position = following.global_position
