require 'ruby2d'

set title: 'Inventory - Game', background: 'blue', width: 740, height: 550

@points = 0

# Create a points array
@itens = []
12.times do | number |
    @itens << {item: number, x: rand(740), y: rand(550), color: 'random'}
end

# Check the colision with points
def check_colision(player, object)

    player_x_range = ((player.x - player.radius)...(player.x + player.radius))
    player_y_range = ((player.y - player.radius)...(player.y + player.radius))

    if player_x_range.include?(object.x) && player_y_range.include?(object.y)
        return true
    else
        return false
    end
end

# Add point to hotbar
@x = 55
def get_item(color)
    point = Square.new(
        x: @x, y: 435, size: 40, z: 2
    )
    point.color = color
    @x += 50
end

# --- Objects ---

# add points in the ground
for item in @itens
    object = Square.new(
        x: item[:x], y: item[:y], size: 40,
        color: 'random', z: 2
    )
    item[:object] = object

end

# hotbar
Rectangle.new(
    x: 45, y: 430,
    width: 640, height: 50,
    color: 'teal', z: 2
)

# player
@player = Circle.new(
    x: 200, y: 200,
    color: 'red', radius: 25
)
@player_pos = {x: @player.x, y: @player.y}


# ---- Events ----
# wait for keybork interaction
on :key do |event|
    if event.key == 'w' #frente
        @player_pos[:y] -= 5
    elsif event.key == 's' #trás
        @player_pos[:y] += 5
    elsif event.key == 'a' #esquerda
        @player_pos[:x] -= 5
    elsif event.key == 'd' #direita
        @player_pos[:x] += 5
    end
end

# Runs every frame
update do
    # define the playable area
    if @player_pos[:x] < 740
        @player.x = @player_pos[:x]
        @player.y = @player_pos[:y]
    else
        @player_pos[:x] = 740
    end

    if @player_pos[:x] > 0
        @player.x = @player_pos[:x]
        @player.y = @player_pos[:y]
    else
        @player_pos[:x] = 0
    end

    if @player_pos[:y] < 550
        @player.x = @player_pos[:x]
        @player.y = @player_pos[:y]
    else
        @player_pos[:y] = 550
    end

    if @player_pos[:y] > 0
        @player.x = @player_pos[:x]
        @player.y = @player_pos[:y]
    else
        @player_pos[:y] = 0
    end

    # check colision
    for item in @itens
        if check_colision(@player, item[:object])
            item[:object].remove
            @itens.delete(item)
            get_item(item[:object].color)
            @points += 1
        end
    end

    # stop game when win
    if @points >= 12
        break
    end
end

# show the game
show
