class_name Item extends RigidBody3D

var item_name: String = "item"
var item_burn_time: float = 20.0
var item_heat_rate: float = 0.002


func _to_string() -> String:
	return "%s" % [item_name]
