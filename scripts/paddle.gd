extends CharacterBody2D

@export var speed = 300.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 0
	if Input.is_action_pressed("up"):
		direction = -1
	if Input.is_action_pressed("down"):
		direction = 1
	if direction:
		velocity.y = direction * speed
	else:
		# deceleration, move from velocity.y toward position 0 at speed (no move in this case)
		velocity.y = move_toward(velocity.y, 0, speed)  

	move_and_slide()
