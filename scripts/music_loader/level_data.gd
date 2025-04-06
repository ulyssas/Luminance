extends RefCounted
class_name LevelData

var title: String
var composer: String
var note_designer: String
var bpm: float
var level_name: String # easy, medium...
var level_value: String # 3
var measure_count: int
var offset: float
var measures: Array[MeasureData]

# コンストラクタ
func _init(
    title: String,
    composer: String,
    note_designer: String,
    bpm: float,
    level_name: String, # easy, medium... ファイル名
    level_value: String, # 3
    measure_count: int,
    offset: float,
    measures: Array[MeasureData],
):
    self.title = title
    self.composer = composer
    self.note_designer = note_designer
    self.bpm = bpm
    self.level_name = level_name
    self.level_value = level_value
    self.measure_count = measure_count
    self.offset = offset
    self.measures = measures

# デバッグ用の情報表示
func get_info() -> String:
    return "[%s] %s - %s (%s %s)" % [composer, title, note_designer, level_name, level_value]
