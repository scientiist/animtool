--------------------------------------------------
--- @name Vector2.lua
--- @descr 2D Vector Implemented as a vaguely datatype-like "Class"
--- @copyright Conarium Software 2023
--- @author Joshua O'Leary
--- @release 1
---
--- @see
-- https://encyclopediaofmath.org/index.php?title=Vector
-- https://math.libretexts.org/Bookshelves/Calculus/Calculus_3e_(Apex)/10%3A_Vectors
-- Search GitHub, Google, etc. for "Vector2D implementation"


local Vector2 = {}

Vector2.__index = Vector2
--- Constructs a new Vector2.
-- @param X number
-- @param Y number
function Vector2.new(X, Y)
    local self = setmetatable({}, Vector2)
    self.X = X
    self.Y = Y
    return self
end

--- Constructs a new Vector2 from an angle in radians.
function Vector2.fromAngle(angle)
    return Vector2.new(math.cos(angle), math.sin(angle));
end

--- Checks if two vectors are equal after flooring the coordinates of both vectors.
-- This means the equality check is not precise, but rather, if the two vectors are close enough to each other.
-- @usage vec2:equals(vec2)
-- @usage Vector2.equals(vec2, vec2)
-- @param vecA
-- @param vecB
-- @return boolean
function Vector2.equals(vecA, vecB)
    return (math.floor(vecA.X) == math.floor(vecB.X) and math.floor(vecA.Y) == math.floor(vecB.Y))
end

--- Checks if two vectors are precisely equal.
-- @usage Vector2.equalsPrecise(vec2, vec2)
-- @usage vec2:equalsPrecise(vec2)
-- @param vecA
-- @param vecB
-- @return boolean
function Vector2.equalsPrecise(vecA, vecB)
    return (vecA.X == vecB.Y and vecA.Y == vecB.Y)
end

--- asscock
-- @name vec2 + vec2
function Vector2.__add(vec1, vec2)
    return Vector2.new(vec1.X + vec2.X, vec1.Y + vec2.Y)
end

--- Scalar multiplication.
-- @name vec2 * number
-- @field vec2 * number
-- @return vec2
function Vector2.__mul(vector, scalar)
    return Vector2.new(vector.X * scalar, vector.Y * scalar)
end

function Vector2.__div(vector, scalar)
    return Vector2.new(vector.X / scalar, vector.Y / scalar);
end

--- b
-- @name vec2 - vec2
function Vector2.__sub(vec1, vec2)
    return Vector2.new(vec1.X - vec2.X, vec1.Y - vec2.Y)
end

--- Linear interpolation between two vectors.
-- @usage Vector2.lerp(vec2, vec2, alpha)
-- @usage vec2:lerp(vec2, alpha)
-- @param vecA
-- @param vecB
function Vector2.lerp(vec1, vec2, alpha)
    local X = math.lerp(vec1.X, vec2.X, alpha)
    local Y = math.lerp(vec1.Y, vec2.Y, alpha)

    return Vector2.new(X, Y)
end

--- Returns the vector's magnitude.
-- @usage Vector2.magnitude(vector)
-- @usage vec2:magnitude()
-- @param vector
function Vector2.magnitude(vector)
    return (vector.X ^ 2 + vector.Y ^ 2) ^ 0.5
end

--- Returns the distance between two vectors.
-- @usage Vector2.distance(vec1, vec2)
-- @usage vec2:distance(vec)
-- @param vec1
-- @param vec2
-- @return vec2
function Vector2.distance(vec1, vec2)
    local x1 = vec1.X
    local x2 = vec2.X
    local y1 = vec1.Y
    local y2 = vec2.Y

    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end
Vector2.Distance = Vector2.distance; -- Alias
--- Returns the unit of the vector (distance = 1).
-- @usage Vector2.unitvec(vec2)
-- @usage vec2:unitvec()
-- @param vector
-- @return vec2
function Vector2.unitvec(vector)
    local magnitude = vector:magnitude()

    return Vector2.new(vector.X / magnitude, vector.Y / magnitude)
end

--- Unimplemented
function Vector2.angle(vector)
    return math.atan2(vector.Y, vector.X);
end

--- Returns the angle between two vectors.
-- @param vec1
-- @param vec2
-- @usage Vector2.angleBetween(vec1, vec2)
-- @usage vec2:angleBetween(vec2)
-- @return number
function Vector2.angleBetween(vec1, vec2)
    return math.atan2(vec2.Y - vec1.Y, vec2.X - vec1.X) * 180 / math.pi
end

--- Unimplemented
function Vector2.dotProduct(vec1, vec2)
    return (vec1.X*vec2.X)+(vec1.Y*vec2.Y);
end


return Vector2;