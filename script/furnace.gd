extends CSGCombiner3D

const MAX_FUEL: int = 5

@onready var mouth: Area3D = $StaticBody3D
@onready var heat_area: Area3D = $AreaPlacer
@onready var label_3d: Label3D = $Label3D
@onready var fire: GPUParticles3D = $Fire
@onready var smoke: GPUParticles3D = $Smoke
@onready var deco: Node3D = $Deco

var items: Array
var work_time: float = 0
var temp: float
var current_fuel:Item


func _ready() -> void:
	mouth.body_entered.connect(_body_entered)


func _process(delta: float) -> void:
	label_3d.text = (
		"Fuel:%d Temp:%d Radius:%d" % [work_time, temp, heat_area.influence.shape.radius]
	)
	if not work_time > 0:
		if not items.is_empty():
			var it: Item = items.pop_back()
			current_fuel = it
			current_fuel.data = it.data
			print(current_fuel)
			work_time += current_fuel.item_burn_time
			#print("remove_fuel")
			add_deco(false)
			heat_area.can_place = true
		else:
			particles(false)
			heat_area.change_influnce(-0.002)
			temp = max(0, temp - 0.002)
			heat_area.can_place = false
			return
	temp = clamp( temp+0.02,0,current_fuel.item_max_heat )#0.02
	heat_area.change_influnce(0.2)
	work_time -= delta


func particles(state: bool) -> void:
	fire.emitting = state
	await get_tree().create_timer(1.2).timeout
	smoke.emitting = state


func _body_entered(body: Node3D) -> void:
	if body as Item:
		var item: Item = body
		if items.size() < MAX_FUEL:
			item.setup(body.data)
			items.append(item.duplicate())
			item.queue_free()
			particles(true)
			add_deco()


func add_deco(state: bool = true) -> void:
	var ch: Array = deco.get_children().filter(func(ch) -> bool: return ch.visible)
	var start = ch.size()  #if not ch.is_empty() else 0
	#print("%s %s %s" % [state, start, ch.size()])
	if state:
		deco.get_child(start).show()
	else:
		deco.get_child(start - 1).hide()
