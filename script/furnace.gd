extends CSGCombiner3D

@onready var mouth: Area3D = $StaticBody3D
@onready var particles: GPUParticles3D = $GPUParticles3D
@onready var lever: Lever = $Lever
@onready var heat_area: Area3D = $AreaPlacer
@onready var label_3d: Label3D = $Label3D

var items: Array
var work_time: float = 0.0
var temp: float
#var can_run:bool = work_time > 0.0


func _ready() -> void:
	mouth.body_entered.connect(_body_entered)
	mouth.body_exited.connect(_body_exited)
	lever.enabled_lever.connect(_enabled_lever)
	#place_scenes_randomly()


func _process(delta: float) -> void:
	label_3d.text = "Temp:%s Radius:%s" % [temp, heat_area.influence.shape.radius]
	if not lever.enabled or (not work_time > 0):
		particles.emitting = false
		heat_area.change_influnce(-0.002)
		temp = max(0, temp - 0.02)
		#$MeshInstance3D.mesh.radius =  max(0.5 , $MeshInstance3D.mesh.radius-0.002)
		return
	temp += 0.02
	heat_area.change_influnce(0.002)
	#$MeshInstance3D.mesh.radius += 0.002
	work_time -= delta


func _enabled_lever(state: bool) -> void:
	if state:
		particles.emitting = true
		work_time = _calc_burn_time()
		for it in items:
			it.queue_free()
		#print(work_time > 0)
	heat_area.can_place = state


func _body_entered(body: Node3D) -> void:
	if body as Item:
		var item: Item = body
		if work_time > 0:
			work_time += item.item_burn_time
			item.queue_free()
		items.append(item)


func _body_exited(body: Node3D) -> void:
	if body as Item:
		var item: Item = body
		_remove_item(item)


#func _add_item(item: Item) -> void:
#if not (item.item_name in items.keys()):
#items[item.item_name] = 0
#items[item.item_name] += 1


func _remove_item(item: Item) -> void:
	items.erase(item)


func _calc_burn_time() -> float:
	var total: float
	for it in items:
		total += it.item_burn_time
	return total
