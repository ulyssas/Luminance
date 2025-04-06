extends RefCounted
class_name MusicData

var title: String
var texture_path: String
var composer: String
var note_designer: String
var has_kuso: bool
var priority: int
var sabi_begin: int
var sabi_end: int
var velocity: float
var levels: Array[LevelData]

# コンストラクタ
func _init(
    title: String,
    texture_path: String,
    composer: String,
    note_designer: String,
    has_kuso: bool,
    priority: int,
    sabi_begin: int,
    sabi_end: int,
    velocity: float,
    levels: Array[LevelData]
):
    self.title = title
    self.texture_path = texture_path
    self.composer = composer
    self.note_designer = note_designer
    self.has_kuso = has_kuso
    self.priority = priority
    self.sabi_begin = sabi_begin
    self.sabi_end = sabi_end
    self.velocity = velocity
    self.levels = levels

# デバッグ用の情報表示
func get_info() -> String:
    return "[%s] %s - %s (Priority: %d)" % [composer, title, note_designer, priority]
