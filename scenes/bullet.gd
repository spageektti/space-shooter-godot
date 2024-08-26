extends Area2D

@export var speed : float = 250
var direction = -1 # -1 up 1 down

func _process(delta):
	position.y += delta * speed * direction

func _on_body_entered(body):
	if(body.name != "CharacterBody2D"): # the bullet was sent by player
		body.damage()
		print("destroy bullet")
		queue_free()

func _on_area_entered(area):
	print("destroy bullet")
	queue_free()
