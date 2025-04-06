class_name Item extends RigidBody3D

var item_name: String = "item"
var item_burn_time: float #= 20.0
var item_heat_rate: float #= 0.002
var item_max_heat: float #= 0.002

@onready var csg_box_3d: CSGBox3D = $CSGBox3D
var data:Dictionary
func setup(_data:Dictionary)->void:
	data = _data
	item_burn_time = data.burn_time
	item_max_heat = data.max_heat
	csg_box_3d.material.set("Albedo",data.color)

func _to_string() -> String:
	return "%s" % [data]
