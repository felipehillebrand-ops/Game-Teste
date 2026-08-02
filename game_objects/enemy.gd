extends RigidBody2D

@onready var game_manager: Node = %GameManager

@export var speed: float = -250.0
var direction: int = -1

@onready var wall_detector: RayCast2D = $WallDetector
@onready var ledge_detector: RayCast2D = $LedgeDetector

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	linear_velocity.x = direction * speed
	
	if (wall_detector and wall_detector.is_colliding()) or (ledge_detector and not ledge_detector.is_colliding()):
		flip_direction()

func flip_direction() -> void:
	direction *= -1
	
	wall_detector.target_position.x *= -1
	ledge_detector.position.x *= -1
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		# var x_delta = body.position.x - position.x
		if (y_delta > 30):
			print ("Destroy enemy")
			queue_free()
			body.jump()
		else:
			print("Decrase player health")
			game_manager.decrease_health()
			# if (x_delta > 0):
			#	body.jump_side(500)
			# else:
			#	body.jump_side(-500)
 
