extends Node3D

@onready var player: Player = $Player
@onready var items: Node3D = $Items


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player.dropped_item.connect(_dropped_item)
	Game.item_created.connect(_item_created)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#if Input.is_action_just_pressed("ui_cancel"):
#		get_tree().quit()


func _item_created(item_type: Dictionary, position: Vector3) -> void:
	var item: Item = preload("res://item.tscn").instantiate()
	items.add_child(item)
	item.setup(item_type, position)


func _dropped_item(item: Item) -> void:
	var it: Item = item
	items.add_child(it)
	#it.sleeping=false
	it.global_position = player.hands.global_position
	it.freeze = false
