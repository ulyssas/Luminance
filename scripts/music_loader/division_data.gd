extends RefCounted
class_name DivisionData

var air_left: int
var lane_1: int
var lane_2: int
var lane_3: int
var lane_4: int
var air_right: int

# コンストラクタ
func _init(
    air_left: int,
    lane_1: int,
    lane_2: int,
    lane_3: int,
    lane_4: int,
    air_right: int,
):
    self.air_left = air_left
    self.lane_1 = lane_1
    self.lane_2 = lane_2
    self.lane_3 = lane_3
    self.lane_4 = lane_4
    self.air_right = air_right
