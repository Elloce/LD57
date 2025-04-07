extends RayCast3D

@export var player: CharacterBody3D

var obj


func _physics_process(_delta: float) -> void:
	var collider = self.get_collider()
	if collider:
		#print(collider)
		if collider as ResourcePile:
			obj = collider
			if Input.is_action_pressed("m1"):
				(collider as ResourcePile).do_action()
			else:
				obj.do_action(false)
		if collider as Item:
			if Input.is_action_just_pressed("m1"):
				player.pickup(collider)
		if collider as Lever:
			if Input.is_action_just_pressed("m1"):
				collider.interact()
	else:
		if obj:
			obj.do_action(false)
