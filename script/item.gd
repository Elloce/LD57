class_name Item extends RigidBody3D

var item_name: String = "item"
var following: Node3D

@onready var csg_box_3d: CSGBox3D = $CSGBox3D
var data: Dictionary


func _process(delta: float) -> void:
	if following:
		global_position = following.global_position


func setup(_data: Dictionary, position: Vector3) -> void:
	data = _data
	var mat: StandardMaterial3D = StandardMaterial3D.new()
	mat.albedo_color = data.color
	csg_box_3d.material = mat.duplicate()
	global_position = position


func _to_string() -> String:
	return "%s" % [data]
