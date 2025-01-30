extends KinematicBody2D

var velocity = Vector2()
var speed = 200
var gravity = 600
var jump_force = -400
onready var animation = $AnimationPlayer
onready var circle_effect = null  # Pour ajouter le cercle

func _ready():
	# Connecter le signal de détection de collision pour tous les nœuds Area2D enfants
	for child in get_children():
		if child is Area2D:
			child.connect("body_entered", self, "_on_Area2D_body_entered")

func _on_Area2D_body_entered(body):
	if body.name == "Coin":
		body.queue_free()  # Supprime la pièce
		create_circle_effect()

func create_circle_effect():
	# Créer un effet de cercle autour de la biche
	if circle_effect == null:
		circle_effect = Sprite.new()
		circle_effect.texture = load("res://Assets/Extra/glowCircle_0.png")
		circle_effect.scale = Vector2(0.25, 0.25) # Réduire la taille 
		add_child(circle_effect)
		circle_effect.position = Vector2(0, -$Sprite.texture.get_size().y / 2)
		#circle_effect.position = Vector2($Sprite.texture.get_size().x - $Sprite.texture.get_size().x/1.80, $Sprite.texture.get_size().y*3)
		#circle_effect.position = Vector2(0, 0)  # Positionner autour de la biche

func _physics_process(delta):
	# Réinitialise la vitesse horizontale et verticale à chaque frame
	velocity.x = 0
	velocity.y = 0

	# Détecter les inputs pour les mouvements horizontaux et verticaux
	if Input.is_action_pressed("ui_right"):
		animation.play("walking")
		$Sprite.flip_h = false  # Face à droite
		velocity.x = speed
		print("Droite")
	elif Input.is_action_pressed("ui_left"):
		animation.play("walking")
		$Sprite.flip_h = true  # Face à gauche
		velocity.x = -speed
		print("gauche")
	elif Input.is_action_pressed("ui_up"):
		animation.play("walking_up")  # Animation spécifique pour monter
		velocity.y = -speed
		print("Haut")
	elif Input.is_action_pressed("ui_down"):
		animation.play("walking_down")  # Animation spécifique pour descendre
		velocity.y = speed
		print("Bas")

	# Appliquer la gravité
	#if not Input.is_action_pressed("ui_up") or not Input.is_action_pressed("ui_down"): 
		#velocity.y += 10 * gravity * delta


	# Déplacer le personnage
	velocity = move_and_slide(velocity, Vector2.UP)
