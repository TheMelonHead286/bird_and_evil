extends CharacterBody2D

var coyote = 0
var evil_coyote = 0
var dash_ready = true
var dash_active = false
var dashdirection = 1
var dash_y : float
var dashTimeRemaining := 0.0 #changed its name because just "time_remaining" is really ominous
const SPEED = 50
const JUMP_VELOCITY = -200
signal DeathTolls

#func slaughter(target):
	#remove_child(target)
	#target.queue_free()

func spawn_feathers():
	if Global.LockControls == false:
		var new_particle = get_node("feathers").duplicate()
		add_child(new_particle)
		new_particle.restart()
		new_particle.evil = true
		new_particle.emitting = true
		new_particle.finished.connect(func():
			new_particle.queue_free())
		

func _ready() -> void:
	get_node("AnimatedSprite2D").play("raven_idle")
	#position = Vector2(80,29.98)
	position = Vector2(32,218)
	velocity.x = 0
	velocity.y = 0
	dash_active = false
	dash_ready = false
	dashTimeRemaining = 0.0

func check_jump():
	#if coyote <= 15 and Input.is_action_pressed("key_S"): return true
	if coyote <= 7: return true
	else: return false

func _physics_process(delta: float) -> void:
	# Screen ~~Looping~~. DEATH. SCREEN DEATH. IT KILL YOU.
	if position.x >= 264:
		#position.x = 8
		emit_signal("DeathTolls")
	if position.x <= -8:
		#position.x = 256
		emit_signal("DeathTolls")
	if position.y >= 264:
		#position.y = -8
		emit_signal("DeathTolls")
	if position.y <= -64:
		#position.y = 248
		emit_signal("DeathTolls")
	
	#Terminal Velocity babeyy
	if velocity.y > 100 and not Input.is_action_pressed("key_S"):
		velocity.y = 100
	elif velocity.y > 300 and Input.is_action_pressed("key_S"):
		velocity.y = 300
	
	#"Coyote" frames to help people who dont have a 0.00s reaction time 
	#(yes i am writing comments for fun, everything else is painful <3)
	if is_on_floor():
		coyote = 0
		evil_coyote += 1
		dash_ready = true
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote += 1
		evil_coyote = 0
	
	#Spotlight taking over (this needs to be changed to every individual control, but i respect myself too much to do that so, here we go, scuffed city)
	if not Input.is_action_pressed("key_ctrl") and Global.LockControls == false:
		
		# Handle jump.
		if Input.is_action_just_pressed("key_spacebar") and check_jump():
			velocity.y = JUMP_VELOCITY
			coyote = 60
		if Input.is_action_just_pressed("key_W") and check_jump():
			velocity.y = JUMP_VELOCITY
			coyote = 60

		if dash_active == false:
			var direction := Input.get_axis("key_A", "key_D")
			if direction < 0:
				get_node("AnimatedSprite2D").flip_h = true
			if direction > 0:
				get_node("AnimatedSprite2D").flip_h = false
			if direction and not Input.is_action_pressed("key_S"):
				#if velocity.x > 0 and direction == 1 and evil_coyote > 7:
					#velocity.x = direction * SPEED
				#if velocity.x < 0 and direction == 1 and evil_coyote > 7:
					#velocity.x = direction * SPEED
				if direction != 0:
					if evil_coyote > 14:
						velocity.x = direction * SPEED
					if evil_coyote <= 14:
						if abs(velocity.x) <= 50:
							velocity.x = direction * SPEED
						else:
							velocity.x = abs(velocity.x) * direction
				#if get_node("AnimatedSprite2D").animation != "raven_run":
			elif is_on_floor():
				velocity.x = move_toward(velocity.x, 0, 20)
			else:
				velocity.x = move_toward(velocity.x, 0, 5)
			if not is_on_floor():
				#print(velocity.y)
				if Input.is_action_pressed("key_S") == true:
					if get_node("AnimatedSprite2D").animation != "raven_fastfall":
						get_node("AnimatedSprite2D").play("raven_fastfall")
						spawn_feathers()
						velocity.y = 100
						#velocity.x *= 1.5
						velocity.x = 0
						#print(velocity.x)
				elif velocity.y < 0:
					if get_node("AnimatedSprite2D").animation != "raven_jump":
						get_node("AnimatedSprite2D").play("raven_jump")
				elif velocity.y > 0:
					get_node("AnimatedSprite2D").play("raven_fall")
			elif Input.is_action_pressed("key_S") == true:
				if get_node("AnimatedSprite2D").animation != "raven_crouch":
					get_node("AnimatedSprite2D").play("raven_crouch")
				velocity.x = 0
			elif direction:
				get_node("AnimatedSprite2D").play("raven_run")
			else:
				get_node("AnimatedSprite2D").play("raven_idle")
				
		if Input.is_action_just_pressed("key_shift") and dash_ready == true:
			get_node("AnimatedSprite2D").play("raven_dive")
			dash_active = true
			dash_ready = false
			dashdirection = 1
			spawn_feathers()
			if get_node("AnimatedSprite2D").flip_h == true:
				dashdirection = -1
			dash_y = position.y
			dashTimeRemaining = 0.33
		if dashTimeRemaining > 0:
		#if dash_active == true:
			if Input.is_action_just_pressed("key_spacebar"):
				dashTimeRemaining = 0
			else:
				velocity.x = 200 * dashdirection
				velocity.y = 0
				dashTimeRemaining -= delta
				if is_on_wall():
					dashTimeRemaining = 0
		if dashTimeRemaining <= 0: dash_active = false
			
		
		#get_node("AnimatedSprite2D").play("raven_idle")
	if Global.LockControls == false:
		move_and_slide()
#also your fix to the birds hitbox wasnt like, changing the birds hitbox, you changed all the tiles' hitboxes
#yuvok.jpg
#i messed around with it, i dont think its too horrible
