function mod(a, b)
    return a - (math.floor(a/b)*b)
end

function mineUpUntilAir ()
    local blocksMovedUp = 0

   --mine up till air is reached
   while turtle.detectUp() == true do
    turtle.digUp()
    turtle.up()
    blocksMovedUp = blocksMovedUp + 1
   end 
   
   --move back down until land is reached
   for i = 1,blocksMovedUp do turtle.down() end
end

function moveForward()
    --Remove the blocks in front
    while turtle.detect() == true do turtle.dig() end --loop in case of falling blocks

    --move forward
    turtle.forward()
end

function flattenStrip(length)
    for i = 1, length do
        moveForward()
        mineUpUntilAir()
    end
end

function corner(direction)
    --determine which way to turn
    if direction == 'right' then turtle.turnRight() end
    if direction == 'left' then turtle.turnLeft() end

    --mine and move into block
    moveForward()
    mineUpUntilAir()

    --determine which way to turn
    if direction == 'right' then turtle.turnRight() end
    if direction == 'left' then turtle.turnLeft() end
end

function flattenSquare(length) --place turtle on the bottom left block of desired flattened square
    --flatten the first strip
    flattenStrip(length)
    corner("right")

    --flatten all the other strips with -1 length as the turner flattens one from each strip
    for i = 1, length-1 do
        flattenStrip(length-1)
        if i % 2 ~= 0 then corner("left") end
        if i % 2 == 0 then corner("right") end
    end
end
