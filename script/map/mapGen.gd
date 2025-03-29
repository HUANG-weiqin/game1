extends TileMapLayer


func _getLeftTiles(lu : Vector2, rd : Vector2) -> Array:
    var L = []
    for i in range(lu.y + 1, rd.y):
        L.append(Vector2(lu.x,i))
    return L

func _getRightTiles(lu : Vector2, rd : Vector2) -> Array:
    var R = []
    for i in range(lu.y + 1, rd.y):
        R.append(Vector2(rd.x,i))
    return R

func _getUpTiles(lu : Vector2, rd : Vector2) -> Array:
    var U = []
    for i in range(lu.x + 1, rd.x):
        U.append(Vector2(i,lu.y))
    return U
    
func _getDownTiles(lu : Vector2, rd : Vector2) -> Array:
    var D = []
    for i in range(lu.x + 1, rd.x):
        D.append(Vector2(i,rd.y))
    return D
    
func _getRU(lu : Vector2, rd : Vector2) -> Vector2:
    return Vector2(rd.x,lu.y)
    
func _getLD(lu : Vector2, rd : Vector2) -> Vector2:
    return Vector2(lu.x,rd.y) 
    
func _getGround(lu : Vector2, rd : Vector2) -> Array:
    var GROUND = []
    for i in range(lu.x , rd.x + 1):
        for j in range(lu.y , rd.y + 1):
            GROUND.append(Vector2(i,j));
    return GROUND


func _generateWall(luTiles : Vector2, rdTiles : Vector2, TileSetID = 0 , alternative_tile = 0 ) -> void:
    var LU = luTiles
    var RU = _getRU(luTiles, rdTiles)
    var LD = _getLD(luTiles, rdTiles)
    var RD = rdTiles
    var L = _getLeftTiles(luTiles, rdTiles)
    var U = _getUpTiles(luTiles, rdTiles)
    var R = _getRightTiles(luTiles, rdTiles)
    var D = _getDownTiles(luTiles, rdTiles)
    
    #for x in w:
        #set_cell(Vector2(pos.x + x, pos.y), TileSetID, U.pick_random(), alternative_tile);
        #set_cell(Vector2(pos.x + x, pos.y+h-1), TileSetID, D.pick_random(),alternative_tile);
    #
    #for y in h:
        #set_cell(Vector2(pos.x, pos.y+y), TileSetID, L.pick_random(),alternative_tile);
        #set_cell(Vector2(pos.x + w-1, pos.y+y), TileSetID, R.pick_random(),alternative_tile);
        #
    #set_cell(Vector2(pos.x, pos.y), TileSetID, LU,alternative_tile);
    #set_cell(Vector2(pos.x, pos.y + h-1), TileSetID, LD,alternative_tile);
    #set_cell(Vector2(pos.x + w-1, pos.y), TileSetID, RU,alternative_tile);
    #set_cell(Vector2(pos.x + w-1, pos.y + h-1), TileSetID, RD,alternative_tile);

func _generateGround(luTiles : Vector2, rdTiles : Vector2, TileSetID = 0 , alternative_tile = 0 ) -> void:
    var GROUND = _getGround(luTiles, rdTiles)
    

# 定义墙壁方向的枚举
enum WallDirection {
    UP,
    DOWN,
    LEFT,
    RIGHT,
    UP_LEFT,
    UP_RIGHT,
    DOWN_LEFT,
    DOWN_RIGHT,
    INNER_UP_RIGHT,
    INNER_UP_LEFT
}

# 判断坐标 (x, y) 是否在二维数组 grid 内且其值属于地面范围 [0, 99]
func is_ground(grid: Array, pos: Vector2) -> bool:
    if pos.y < 0 or pos.y >= grid.size():
        return false
    if pos.x < 0 or pos.x >= grid[pos.y].size():
        return false
        
    var value = grid[pos.y][pos.x]
    return value >= 0 and value < 99

# 参数：
#   grid：二维数组（每行是一个数组，按 grid[row][col] 访问）
#   pos：Vector2，其中 pos.x 为列索引，pos.y 为行索引
# 返回值：WallDirection 枚举，表示该墙壁朝向哪一侧
func get_wall_direction(grid: Array, pos: Vector2) -> int:
    var r = Vector2(1,0);
    var l = Vector2(-1,0);
    var u = Vector2(0,-1);
    var d = Vector2(0,1);
    
    if is_ground(grid, pos + r) and is_ground(grid, pos + u) and is_ground(grid, pos + r + u):
        return WallDirection.INNER_UP_RIGHT
    if is_ground(grid, pos + l) and is_ground(grid, pos + u) and is_ground(grid, pos + l + u):
        return WallDirection.INNER_UP_LEFT
    
    if is_ground(grid, pos + d):
        return WallDirection.UP
    if is_ground(grid, pos + u):
        return WallDirection.DOWN
        
    if !is_ground(grid, pos + r) and !is_ground(grid, pos + d) and is_ground(grid, pos + r + d):
        return WallDirection.UP_LEFT
    if !is_ground(grid, pos + l) and !is_ground(grid, pos + d) and is_ground(grid, pos + l + d):
        return WallDirection.UP_RIGHT
    if !is_ground(grid, pos + r) and !is_ground(grid, pos + u) and is_ground(grid, pos + r + u):
        return WallDirection.DOWN_LEFT
    if !is_ground(grid, pos + l) and !is_ground(grid, pos + u) and is_ground(grid, pos + l + u):
        return WallDirection.DOWN_RIGHT
    if is_ground(grid, pos + l):
        return WallDirection.RIGHT
    if is_ground(grid, pos + r):
        return WallDirection.LEFT
    
    return -1
            

func generateMap(world) -> void:
    var groundLU = Vector2(6,0)
    var groundRD = Vector2(9,2)
    var wallLU = Vector2(0,0)
    var wallRD = Vector2(5,4)
    var LU = wallLU
    var RD = wallRD
    var INNER_LU = Vector2(4,5)
    var INNER_RU = Vector2(5,5)
    var GROUND = _getGround(groundLU, groundRD)
    var RU = _getRU(wallLU, wallRD)
    var LD = _getLD(wallLU, wallRD)
    var L = _getLeftTiles(wallLU, wallRD)
    var U = _getUpTiles(wallLU, wallRD)
    var R = _getRightTiles(wallLU, wallRD)
    var D = _getDownTiles(wallLU, wallRD)
    
    var y = 0
    for raw in world:
        print(raw)
        var x = 0
        for block_id in raw:
            if (block_id == 99):
                var dir = get_wall_direction(world,Vector2(x, y))
                match dir:
                    WallDirection.DOWN_RIGHT:
                        set_cell(Vector2(x, y), 0, RD, 0);
                    WallDirection.DOWN_LEFT:
                        set_cell(Vector2(x, y), 0, LD, 0);
                    WallDirection.UP_RIGHT:
                        set_cell(Vector2(x, y), 0, RU, 0);
                    WallDirection.UP_LEFT:
                        set_cell(Vector2(x, y), 0, LU, 0);
                    WallDirection.DOWN:
                        set_cell(Vector2(x, y), 0, D.pick_random(), 0);
                    WallDirection.UP:
                        set_cell(Vector2(x, y), 0, U.pick_random(), 0);
                    WallDirection.RIGHT:
                        set_cell(Vector2(x, y), 0, R.pick_random(), 0);
                    WallDirection.LEFT:
                        set_cell(Vector2(x, y), 0, L.pick_random(), 0);
                    WallDirection.INNER_UP_RIGHT:
                        set_cell(Vector2(x, y), 0, INNER_RU, 0);
                    WallDirection.INNER_UP_LEFT:
                        set_cell(Vector2(x, y), 0, INNER_LU, 0);
            elif block_id >= 0:
                set_cell(Vector2(x, y), 0, GROUND.pick_random(), 0);
            x += 1
        y += 1
