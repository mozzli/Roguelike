extends Control

class_name StatusWindow

onready var pic_nodes = get_tree().get_nodes_in_group("status_picture_group")
onready var item_box_node = $Popup/Panel/ItemBox
onready var unit_box = $Popup/Panel/PlayerUnitsBox
onready var unit_container = $Popup/Panel/PlayerUnitsBox/UnitContainer
onready var equipement_node = $Popup/Panel/EquipementBox

func _ready():
	$Popup/Panel.rect_size.x = 1200
	$Popup/Panel.rect_size.y = 600

func load_box(unit: MapUnit):
	GameVariables.gui_is_on = true
	reset_box()
	item_box_node.load_item_box(unit.get_item_box())
	unit_container.load_unit_texture(unit.get_party())
	equipement_node.load_equipement(unit.get_equipement_box())
	$Popup.popup()

func reset_box():
	item_box_node.refresh_item_box()
	unit_container.refresh_party()
	equipement_node.refresh_equipement()

func _on_Button_pressed():
	GameVariables.gui_is_on = false
	$Popup.hide()
