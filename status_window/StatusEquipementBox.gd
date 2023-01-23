extends Control

var equipement_boxes: Dictionary = {}

func _ready():
	equipement_boxes[GlobalItems.equipement_type.HEAD] = $Panel/Head/TextureButton
	equipement_boxes[GlobalItems.equipement_type.BODY] = $Panel/Body/TextureButton
	equipement_boxes[GlobalItems.equipement_type.RIGHT_HAND] = $Panel/RightHand/TextureButton
	equipement_boxes[GlobalItems.equipement_type.LEFT_HAND] = $Panel/LeftHand/TextureButton
	equipement_boxes[GlobalItems.equipement_type.LEGS] = $Panel/Legs/TextureButton
	equipement_boxes[GlobalItems.equipement_type.ACCESSORY] = $Panel/Accessory/TextureButton

func load_equipement(equipement: Dictionary):
	for eq in equipement:
		equipement_boxes.get(eq).current_equipement = equipement
		if equipement.get(eq) != null:
			equipement_boxes.get(eq).load_item(equipement.get(eq))

func refresh_equipement():
	for eq in equipement_boxes:
		equipement_boxes.get(eq).refresh_equipement()
