extends Node2D
var variant : String
var trying = true
var mouse_on : bool
var increment : int
var TransitionToOverride : String
var nightmare = false
#thankfully quiv has turned the nightmares off, or else this would be a lot easier to sleep to

signal DeathTolls
signal NextLevel(LevelToTransition)
var TransitionTo = "base"
var VariantRemember = "DEV"
var SolidList = ["Atrium","City","Construction","Luxury","Evil","DEV","Hedge"]
var BackgroundList = ["Transition","empty","bg","Glass","AtriumTrans","CityTrans","ConstructionTrans","LuxuryTrans","HedgeRoots","DeathAtrium","DeathCity","DeathConstruction","DeathLuxury","DeathEvil","DeathDEV"]
var frame = 0

var patternFull = ""
var TL = ""
var TR = ""
var BL = ""
var BR = ""
var patternSides = ""
var locale = {"tl" : "","t":"","tr":"","l":"","r":"","bl":"","b":"","br":""}
var names = {0 : "tl",1 : "t",2 : "tr",3:"l",4:"r",5:"bl",6:"b",7:"br"}
var figures = {0:-17,1:-16,2:-15,3:-1,4:1,5:15,6:16,7:17}
var iterator = 0

func update():
	if not variant == "empty":
		patternFull = ""
		#locale = {"tl" : "","t":"","tr":"","l":"","r":"","bl":"","b":"","br":""}
		for i in range(0,8):
			if (increment + figures[i]) > 0 and (increment + figures[i]) < 257:
				#if Global.current_level[2] == Global.current_level[2]:
				if Global.current_level[increment + figures[i]] == Global.current_level[increment]:
					locale[names[i]] = "S"
					#print(locale["l"])
				else: locale[names[i]] = "O"
				patternFull += str(locale[names[i]])
			
	#i wont admit you're right, but also you're wrong anyway, so lets just be happy it works. :)
		patternSides = ""
		TL = ""
		TR = ""
		BL = ""
		BR = ""
		iterator = 0
		for i in patternFull:
			iterator += 1
			if iterator == 2 or iterator == 4 or iterator == 5 or iterator == 7:
				patternSides += i
			if iterator == 1:
				TL += i
			if iterator == 3:
				TR += i
			if iterator == 6:
				BL += i
			if iterator == 8:
				BR += i
	
	#tilestilestilestiles ugghhhhhhhhhh <3
	%tiletex.frame = 0
	frame = 0
	if patternFull == "SSSSSSSS":
		%tiletex.frame = 0
		frame = 0
	if patternSides == "OOOO":
		%tiletex.frame = 1
		frame = 1
	if patternSides == "SOOO":
		%tiletex.frame = 2
		frame = 2
	if patternSides == "OOOS":
		%tiletex.frame = 3
		frame = 3
	if patternSides == "SOOS":
			%tiletex.frame = 4
			frame = 4
	if patternSides == "OSOO":
		%tiletex.frame = 5
		frame = 5
	if patternSides == "SSOO":
		if TL == "O":
			%tiletex.frame = 6
			frame = 6
	if patternSides == "OSOS":
		if BL == "O":
			%tiletex.frame = 7
			frame = 7
	if patternSides == "SSOS":
		if TL == "O" and BL == "O":
			%tiletex.frame = 8
			frame = 8
	if patternSides == "SSOO":
		if TL == "S":
			%tiletex.frame = 9
			frame = 9
	if patternSides == "OSOS":
		if BL == "S":
			%tiletex.frame = 10
			frame = 10
	if patternSides == "OOSO":
		%tiletex.frame = 11
		frame = 11
	if patternSides == "SOSO":
		if TR == "O":
			%tiletex.frame = 12
			frame = 12
	if patternSides == "OOSS":
		if BR == "O":
			%tiletex.frame = 13
			frame = 13
	if patternSides == "SOSS":
		if TR == "O" and BR == "O":
			%tiletex.frame = 14
			frame = 14
	if patternSides == "SOSO":
		if TR == "S":
			%tiletex.frame = 15
			frame = 15
	if patternSides == "OOSS":
		if BR == "S":
			%tiletex.frame = 16
			frame = 16
	if patternSides == "OSSO":
			%tiletex.frame = 17
			frame = 17
	if patternSides == "SSSO":
		if TL == "O" and TR == "O":
			%tiletex.frame = 18
			frame = 18
	if patternSides == "OSSS":
		if BL == "O" and BR == "O":
			%tiletex.frame = 19
			frame = 19
	if patternFull == "OSOSSOSO":
		%tiletex.frame = 20
		frame = 20
	if patternFull == "OSSSSOSO":
		%tiletex.frame = 21
		frame = 21
	if patternFull == "SSOSSOSO":
		%tiletex.frame = 22
		frame = 22
	if patternFull == "SSSSSOSO":
		%tiletex.frame = 23
		frame = 23
	if patternSides == "SSOS":
		if TL == "O" and BL == "S":
			%tiletex.frame = 24
			frame = 24
	if patternSides == "SSOS":
		if TL == "S" and BL == "O":
			%tiletex.frame = 25
			frame = 25
	if patternSides == "SSOS":
		if TL == "S" and BL == "S":
			%tiletex.frame = 26
			frame = 26
	if patternFull == "OSOSSSSO":
		%tiletex.frame = 27
		frame = 27
	if patternFull == "OSSSSSSO":
		%tiletex.frame = 28
		frame = 28
	if patternFull == "SSOSSSSO":
		%tiletex.frame = 29
		frame = 29
	if patternFull == "SSSSSSSO":
		%tiletex.frame = 30
		frame = 30
	if patternSides == "SOSS":
		if TR == "O" and BR == "S":
			%tiletex.frame = 31
			frame = 31
	if patternSides == "SOSS":
		if TR == "S" and BR == "O":
			%tiletex.frame = 32
			frame = 32
	if patternSides == "SOSS":
		if TR == "S" and BR == "S":
			%tiletex.frame = 33
			frame = 33
	if patternFull == "OSOSSOSS":
		%tiletex.frame = 34
		frame = 34
	if patternFull == "OSSSSOSS":
		%tiletex.frame = 35
		frame = 35
	if patternFull == "SSOSSOSS":
		%tiletex.frame = 36
		frame = 36
	if patternFull == "SSSSSOSS":
		%tiletex.frame = 37
		frame = 37
	if patternSides == "SSSO":
		if TL == "S" and TR == "O":
			%tiletex.frame = 38
			frame = 38
	if patternSides == "SSSO":
		if TL == "O" and TR == "S":
			%tiletex.frame = 39
			frame = 39
	if patternSides == "SSSO":
		if TL == "S" and TR == "S":
			%tiletex.frame = 40
			frame = 40
	if patternFull == "OSOSSSSS":
		%tiletex.frame = 41
		frame = 41
	if patternFull == "OSSSSSSS":
		%tiletex.frame = 42
		frame = 42
	if patternFull == "SSOSSSSS":
		%tiletex.frame = 43
		frame = 43
	if patternSides == "OSSS":
		if BL == "S" and BR == "O":
			%tiletex.frame = 44
			frame = 44
	if patternSides == "OSSS":
		if BL == "O" and BR == "S":
			%tiletex.frame = 45
			frame = 45
	if patternSides == "OSSS":
		if BL == "S" and BR == "S":
			%tiletex.frame = 46
			frame = 46
#never ready
func _ready() -> void:
	if not TransitionToOverride == "":
		TransitionTo = TransitionToOverride
		print(TransitionTo)
	else:
		TransitionTo = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("key_O"):
	if Global.slaughter == true:
		queue_free()
	if Global.updater == true:
		update()
	%tiletex.play(variant)
	VariantRemember = variant
	%tiletex.show()
	if variant in BackgroundList:
		get_node("body").set_collision_layer(2)
		if variant == "empty":
			%tiletex.hide()
		#get_node("body/collision").disabled = true
		#get_node("body/collision").z_index = 2
	if variant in SolidList:
		get_node("body").set_collision_layer(1)
		#get_node("body/collision").disabled = false
		#get_node("body/collision").z_index = 2
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse_on == true and nightmare == false:
		nightmare = true
		if Global.TileType == 0:
			variant = "DEV"
			Global.current_level[increment] = "B"
		elif Global.TileType == 8:
			variant = "Hedge"
			Global.current_level[increment] = "H"
		elif Global.TileType == 7:
			variant = "HedgeRoots"
			Global.current_level[increment] = "R"
		elif Global.TileType == 4:
			variant = "CityTrans"
			Global.current_level[increment] = "C"
		elif Global.TileType == 2:
			variant = "bg"
			Global.current_level[increment] = "S"
		elif Global.TileType == 3:
			variant = "City"
			Global.current_level[increment] = "D"
		elif Global.TileType == 5:
			variant = "DeathCity"
			Global.current_level[increment] = "E"
		elif Global.TileType == 6:
			variant = "Atrium"
			Global.current_level[increment] = "F"
		elif Global.TileType == 10:
			variant = "DeathAtrium"
			Global.current_level[increment] = "G"
		elif Global.TileType == 9:
			variant = "Glass"
			Global.current_level[increment] = "I"
		elif Global.TileType == 11:
			variant = "Construction"
			Global.current_level[increment] = "J"
		elif Global.TileType == 12:
			variant = "ConstructionTrans"
			Global.current_level[increment] = "K"
		elif Global.TileType == 13:
			variant = "Luxury"
			Global.current_level[increment] = "L"
		elif Global.TileType == 15:
			variant = "DeathLuxury"
			Global.current_level[increment] = "M"
		elif Global.TileType == 14:
			variant = "LuxuryTrans"
			Global.current_level[increment] = "N"
		elif Global.TileType == 16:
			variant = "Evil"
			Global.current_level[increment] = "A"
		elif Global.TileType == 17:
			variant = "DeathEvil"
			Global.current_level[increment] = "Q"
		elif Global.TileType == 1:
			variant = "DeathDEV"
			Global.current_level[increment] = "T"
		elif Global.TileType == 18:
			variant = "Transition"
			Global.current_level[increment] = "U"
			#you have to type it for every transition tile placed. womp womp
			getTheFriggenUhHmmTransitionToNameThingyOrSomethingOfTheLikeIReallyDontKnowLMAOButItllWorkIKnowItISwearIKnowIt()
		#elif variant == "empty":
		#	variant = "DEV"
		#	Global.current_level[increment] = "B"
	elif Input.is_action_just_pressed("mouse_right") and mouse_on == true and Input.is_action_pressed("key_ctrl") and not VariantRemember == "empty":
		print(VariantRemember)
		if VariantRemember == "DEV":
			Global.TileType = 0
		elif VariantRemember == "Hedge":
			Global.TileType = 8
		elif VariantRemember == "HedgeRoots":
			Global.TileType = 7
		elif VariantRemember == "CityTrans":
			Global.TileType = 4
		elif VariantRemember == "bg":
			Global.TileType = 2
		elif VariantRemember == "City":
			Global.TileType = 3
		elif VariantRemember == "DeathCity":
			Global.TileType = 5
		elif VariantRemember == "Atrium":
			Global.TileType = 6
		elif VariantRemember == "DeathAtrium":
			Global.TileType = 10
		elif VariantRemember == "Glass":
			Global.TileType = 9
		elif VariantRemember == "Construction":
			Global.TileType = 11
		elif VariantRemember == "ConstructionTrans":
			Global.TileType = 12
		elif VariantRemember == "Luxury":
			Global.TileType = 13
		elif VariantRemember == "DeathLuxury":
			Global.TileType = 15
		elif VariantRemember == "LuxuryTrans":
			Global.TileType = 14
		elif VariantRemember == "Evil":
			Global.TileType = 16
		elif VariantRemember == "DeathEvil":
			Global.TileType = 17
		elif VariantRemember == "DeathDEV":
			Global.TileType = 1
		elif VariantRemember == "Transition":
			Global.TileType = 18
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and mouse_on == true and nightmare == false:
		if not Input.is_action_pressed("key_ctrl"):
			variant = "empty" 
			nightmare = true
			Global.current_level[increment] = "S"
			update()
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		nightmare = false
	Global.updater = true
	await get_tree().create_timer(.0001).timeout
	Global.updater = false
	#if mouse_on == true:
		#print("nine moillion")
	#if variant == "DEV":
		#position.x += randi_range(-1,1)


func _on_body_mouse_entered() -> void:
	mouse_on = true
func _on_body_mouse_exited() -> void: mouse_on = false

func _on_KILL() -> void:
	queue_free()

#Hedge/Root Stuff and Death Coliders (why was it so hard to learn signals, wth)
#more time wasted with signals, geniunely this is infuriorating
#okay so i think because tiles are dynamically created, its messing with it... what do i do?????
#AHAHHA I GOT IT! instantiate this, t h e  d e a t h  s h a l l  t o l l ehehehehe
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == get_parent().get_node("Spotlight") and variant == "HedgeRoots":
		variant = "Hedge"
		%tiletex.play(variant)
		VariantRemember = variant
		%tiletex.frame = frame
	if body == get_parent().get_node("Player"):
		if variant == "DeathCity" or variant == "DeathAtrium" or variant == "DeathDEV" or variant == "DeathLuxury" or variant == "DeathEvil":
			emit_signal("DeathTolls")
		elif variant == "Transition":
			emit_signal("NextLevel",TransitionTo)
func _on_area_2d_body_exited(body: Node2D) -> void:
	if Global.LockControls == false:
		if body == get_parent().get_node("Spotlight") and variant == "Hedge":
			variant = "HedgeRoots"
			if is_editable_instance(%tiletex) == true:
				%tiletex.play(variant)
				VariantRemember = variant
				%tiletex.frame = frame

#Transition Block Stuffs
func getTheFriggenUhHmmTransitionToNameThingyOrSomethingOfTheLikeIReallyDontKnowLMAOButItllWorkIKnowItISwearIKnowIt():
	var TextToTell = LineEdit.new()
	TextToTell.name = "TextToTell"
	add_child(TextToTell)
	await get_tree().create_timer(.1).timeout
	TextToTell.connect("text_submitted", ToldToText)
	await get_tree().create_timer(.1).timeout

func ToldToText(LeText):
	TransitionTo = LeText
	print(TransitionTo)
	$TextToTell.queue_free() #would this be considered an ATD transition? (Alive to Dead)
