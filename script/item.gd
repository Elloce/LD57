class_name Item extends RigidBody3D

@export var colored: CSGShape3D

@onready var pickup_comp: Node3D = $PickupComp

var data: Dictionary


func pickup(node: Node3D) -> void:
	pickup_comp.following = node
	global_rotation = node.global_rotation
	freeze = true


func drop() -> void:
	pickup_comp.following = null
	freeze = false
	sleeping = false


func setup(_data: Dictionary, position: Vector3) -> void:
	data = _data
	var mat: StandardMaterial3D = StandardMaterial3D.new()
	mat.albedo_color = data.color
	colored.material = mat.duplicate()
	global_position = position


func _to_string() -> String:
	return "%s" % [data]
