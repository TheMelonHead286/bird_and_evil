extends Node2D
#todo
#blocks & backgrounds (bam)
#make lvl transitions (lovely)
#spotlight (mhm!)
#hedge blocks (done!)
#gantries
#rrrRRAAGHH YOU GOT THIS

var inc = 0
var cur_level = ""
var level_name = ""
var enable_saveload = true

func flicker():
	Global.slaughter = true
	await get_tree().create_timer(.0001).timeout
	Global.slaughter = false


func save_level(content):
	if enable_saveload == true:
		print("SAVING")
		get_node("savewindow").show()
		%LineEdit.text = ""
		enable_saveload = false
		await %LineEdit.text_submitted
		name = %LineEdit.text
		enable_saveload = true
		var file = FileAccess.open(str("user://saves/",name,".dat"), FileAccess.WRITE)
		var fileTrans = FileAccess.open(str("user://saves/",name+"+transitions",".dat"), FileAccess.WRITE)
		#print(file)
		#print(OS.get_data_dir())
		file.store_string(content)
		fileTrans.store_string(contentTrans)

var nextone := false
var Modifiers : String
var levelnameSacrificial = ""
func load_level(levelname):
	#setting up modifiers
	levelnameSacrificial = ""
	Modifiers = ""
	nextone = false
	for i in levelname:
		if i == "-":
			nextone = true
		elif nextone == true:
			nextone = false
			Modifiers += i
		else:
			levelnameSacrificial += i
	levelname = levelnameSacrificial
	if FileAccess.file_exists(str("user://saves/",levelname,".dat")) and enable_saveload == true:
		print("LOADING")
		#modifiers, if you put a -[letter] in the title of a file, itll modify it. coolio
		#used for: backgrounds, spotlight
		for i in Modifiers:
			if i == "C":
				$background/AnimatedSprite2D.play("city")
			elif i == "A":
				$background/AnimatedSprite2D.play("atrium")
			elif i == "Z":
				$background/AnimatedSprite2D.play("construction")
			elif i == "X":
				$background/AnimatedSprite2D.play("suite")
			elif i == "O":
				$background/AnimatedSprite2D.play("approach")
			elif i == "D":
				$background/AnimatedSprite2D.play("avgdeskjob")
			elif i == "N":
				$background/AnimatedSprite2D.play("night")
			elif i == "S":
				$Spotlight.enable()
			elif i == "s":
				$Spotlight.disable()
			else:
				$background/AnimatedSprite2D.play("day")
		justperish()
		$Spotlight._ready()
		var file = FileAccess.open(str("user://saves/",levelname,".dat"), FileAccess.READ)
		var content = file.get_as_text()
		var fileTrans = FileAccess.open(str("user://saves/",levelname,".dat"), FileAccess.READ)
		var contentTrans = fileTrans.get_as_text()
		return content
	else: return "user://saves/crashpad.dat"
var tile = preload("res://tile.tscn")
  
func spawnTile(pos,type,filename):
	var tileInst = tile.instantiate()
	inc += 1
	add_child(tileInst)
	tileInst.name = "tile"+str(inc)
	tileInst.increment = inc
	#print(inc)
	tileInst.position = pos
	tileInst.variant = type
	tileInst.connect("DeathTolls", justperish)
	tileInst.connect("NextLevel", goToNextLevel)
	if type == "Transition" and FileAccess.file_exists(str("user://saves/",filename+"+transitions",".dat")):
		var fileTrans = FileAccess.open(str("user://saves/",filename+"+transitions",".dat"), FileAccess.READ)
		contentTrans = fileTrans.get_as_text()
		var numtry = false
		var num : String
		var destinationtry = false
		var destination : String
		for i in contentTrans:
			if numtry == true:
				num += i
				if num == str(inc):
					print("can -> "+destination)
					tileInst.TransitionToOverride = destination
					tileInst.TransitionTo = destination
			if i == "+":
				numtry = true
				num = ""
				destinationtry = false
			elif i == "=":
				numtry = false
				destination = ""
				destinationtry = true
			elif destinationtry == true:
				destination += i
	else:
		tileInst.TransitionToOverride = ""
	tileInst.show()

func create_level(choice):
	if enable_saveload == true:
		if choice == "wawa":
			get_node("savewindow").show()
			%LineEdit.text = ""
			enable_saveload = false
			await %LineEdit.text_submitted
			choice = %LineEdit.text
			enable_saveload = true
		#fixing up the memory leak issue (you spawned tiles and never removed them???????) 
		#Like every time a level was created an entire new set of 256 tiles were created. for every level load.
		if get_node("tile"+str(255)):
			for i in range(1,257):
				get_node("tile"+str(i)).queue_free()
		inc = 0
		flicker()
		await get_tree().create_timer(.00001).timeout
		var level = load_level(choice)
		var pos = Vector2(8,8)
		var stink_value = 0
		var temp = ""
		nextone = false
		for i in choice:
			if i == "-":
				nextone = true
			elif nextone == true:
				nextone = false
			else:
				temp += i
		choice = temp
		for i in range(1,272):
			#print(i," this is i")
			#print(level.substr(i,1))
			if pos.x >= 264:
				pos.y += 16
				pos.x = 8
			if level.substr(i,1) == "B":
				#print("success")
				spawnTile(pos,"DEV","")
				pos.x += 16
				Global.current_level[i-stink_value] = "B"
			elif level.substr(i,1) == "O":
				#print("non")
				spawnTile(pos,"bg","")
				pos.x += 16
				Global.current_level[i-stink_value] = "O"
			elif level.substr(i,1) == "S":
				#print("skip")
				spawnTile(pos,"empty","")
				pos.x += 16
				Global.current_level[i-stink_value] = "S"
			elif level.substr(i,1) == "H":
				#print("skip")
				spawnTile(pos,"Hedge","")
				pos.x += 16
				Global.current_level[i-stink_value] = "H"
			elif level.substr(i,1) == "R":
				#print("skip")
				spawnTile(pos,"HedgeRoots","")
				pos.x += 16
				Global.current_level[i-stink_value] = "R"
			elif level.substr(i,1) == "C":
				#print("skip")
				spawnTile(pos,"CityTrans","")
				pos.x += 16
				Global.current_level[i-stink_value] = "C"
			elif level.substr(i,1) == "D":
				#print("skip")
				spawnTile(pos,"City","")
				pos.x += 16
				Global.current_level[i-stink_value] = "D"
			elif level.substr(i,1) == "E":
				#print("skip")
				spawnTile(pos,"DeathCity","")
				pos.x += 16
				Global.current_level[i-stink_value] = "E"
			elif level.substr(i,1) == "F":
				#print("skip")
				spawnTile(pos,"Atrium","")
				pos.x += 16
				Global.current_level[i-stink_value] = "F"
			elif level.substr(i,1) == "G":
				#print("skip")
				spawnTile(pos,"DeathAtrium","")
				pos.x += 16
				Global.current_level[i-stink_value] = "G"
			elif level.substr(i,1) == "I":
				#print("skip")
				spawnTile(pos,"Glass","")
				pos.x += 16
				Global.current_level[i-stink_value] = "I"
			elif level.substr(i,1) == "J":
				#print("skip")
				spawnTile(pos,"Construction","")
				pos.x += 16
				Global.current_level[i-stink_value] = "J"
			elif level.substr(i,1) == "K":
				#print("skip")
				spawnTile(pos,"ConstructionTrans","")
				pos.x += 16
				Global.current_level[i-stink_value] = "K"
			elif level.substr(i,1) == "L":
				#print("skip")
				spawnTile(pos,"Luxury","")
				pos.x += 16
				Global.current_level[i-stink_value] = "L"
			elif level.substr(i,1) == "M":
				#print("skip")
				spawnTile(pos,"DeathLuxury","")
				pos.x += 16
				Global.current_level[i-stink_value] = "M"
			elif level.substr(i,1) == "N":
				#print("skip")
				spawnTile(pos,"LuxuryTrans","")
				pos.x += 16
				Global.current_level[i-stink_value] = "N"
			elif level.substr(i,1) == "A":
				#print("skip")
				spawnTile(pos,"Evil","")
				pos.x += 16
				Global.current_level[i-stink_value] = "A"
			elif level.substr(i,1) == "Q":
				#print("skip")
				spawnTile(pos,"DeathEvil","")
				pos.x += 16
				Global.current_level[i-stink_value] = "Q"
			elif level.substr(i,1) == "T":
				#print("skip")
				spawnTile(pos,"DeathDEV","")
				pos.x += 16
				Global.current_level[i-stink_value] = "T"
			elif level.substr(i,1) == "U":
				#print("skip")
				spawnTile(pos,"Transition",choice)
				pos.x += 16
				Global.current_level[i-stink_value] = "U"
			else: stink_value += 1
		Global.updater = true
		await get_tree().create_timer(.1).timeout
		Global.updater = false
			#print(i)

#hijacked the complier code to get dynamic level transitions. its a mess, but you didnt do it so <3
var contentTrans = ""
func compile():
	cur_level = " "
	contentTrans = ""
	for i in range(256):
		#if i % 16 == 0 and i > 1: cur_level = cur_level + """ """
		cur_level += Global.current_level[i+1]
		if Global.current_level[i+1] == "U":
			contentTrans += "="+get_node("tile"+str(i+1)).TransitionTo +"+"+str(i+1)
	contentTrans += "="
	#print(cur_level)
	return cur_level
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	#$Spotlight.connect("cryagain", justperish) #only in the longest of nights (wait its day...)
	$Player.connect("DeathTolls", justperish)
	$Player.connect("NextLevel", goToNextLevel)
	add_user_signal("KILL")
	create_level("base")
	await get_tree().create_timer(.5).timeout
	Global.updater = true
	await get_tree().create_timer(.0001).timeout
	Global.updater = false
	#print(current_level)

#only to say. THE DEATH LIKE, fade in, WAS HELL
@onready var FastPlayerLoad = $Player
@onready var FastDeathLoad = $DeathWipe
func justperish():
	if Global.LockControls == false:
		Global.LockControls = true
		for i in range(1,21):
			FastDeathLoad.modulate = Color(0,0,0,(i/20.0))
			await get_tree().create_timer(0.0001).timeout
		FastPlayerLoad._ready()
		await get_tree().create_timer(0.1).timeout
		for ii in range(21,1,-1):
			FastDeathLoad.modulate = Color(0,0,0,(ii/20.0))
			await get_tree().create_timer(0.0001).timeout
		FastDeathLoad.modulate = Color(0,0,0,0)
		Global.LockControls = false
#the global boolean helped

	
func goToNextLevel(LevelToTransition): 
	print("-> "+LevelToTransition)
	create_level(LevelToTransition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#variant switcheroo during editing
	if Input.is_action_just_pressed("mouse_middle") and Input.is_action_pressed("key_ctrl"):
		if Global.TileType > 0:
			Global.TileType -= 1
		else:
			Global.TileType = 18
	elif Input.is_action_just_pressed("mouse_middle") and not Input.is_action_pressed("key_ctrl"):
		if Global.TileType < 18:
			Global.TileType += 1
		else:
			Global.TileType = 0
	
	if Input.is_action_just_pressed("key_O"):
		#create_level("wawa")
		pass
	if Input.is_action_just_pressed("key_L"):
		save_level(compile())
	if Input.is_action_just_pressed("key_R"):
		Global.updater = true
		await get_tree().create_timer(.0001).timeout
		Global.updater = false
		#save_level(cur_level, "quicksave")

func _on_line_edit_text_submitted(new_text: String) -> void:
	get_node("savewindow").hide()
