extends Node3D

@export var regular_note: PackedScene
@export var long_note: PackedScene
@export var light_note: PackedScene
@export var dark_note: PackedScene

var note_count: int = 1000

func _ready():
    if regular_note == null:
        push_warning("シーンが設定されていません")
    #pass
    $light.visible = false
    $note1.visible = false
    $long.visible = false
    $note2.visible = false
    $note3.visible = false
    $dark.visible = false

    instantiate_notes($light, light_note)
    instantiate_notes($note1, regular_note)
    instantiate_notes($long, long_note)
    instantiate_notes($note2, regular_note)
    instantiate_notes($note3, regular_note)
    instantiate_notes($dark, dark_note)

func instantiate_notes(origin: Node3D, notes: PackedScene, space: float = 1):
    var origin1: Vector3 = origin.position
    for i in range(note_count):
        var child_note = notes.instantiate()
        child_note.position = origin1 + Vector3(0, 0, i*space)
        add_child(child_note)
