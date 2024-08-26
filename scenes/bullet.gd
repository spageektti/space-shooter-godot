extends Area2D

@export var speed : float = 250
var direction = -1 # -1 up 1 down

func _process(delta):
	position.y += delta * speed * direction

func _on_body_entered(body):
	if((direction == -1 and body.name != "CharacterBody2D") or (direction == 1 and not body.name.begins_with("enemy"))):
		body.damage()
		print("destroy bullet")
		queue_free()

func _on_area_entered(area):
	if(area.get_name().begins_with("WorldBorder") or area.get_name().begins_with("b")):
		print("destroy bullet")
		area.queue_free()
		queue_free()
