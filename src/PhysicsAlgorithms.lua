local Vector2 = require("src.Vector2");
local function GetOverlapsAABB(posA, sizeA, posB, sizeB)
    local absDistX = math.abs(posA.X - posB.X);
    local absDistY = math.abs(posA.Y - posB.Y);

    local sumW = sizeA.X + sizeB.X;
    local sumH = sizeA.Y + sizeB.Y;

    if (absDistY >= sumH or absDistX >= sumW) then
        return false;
    end
    return true;
end

local function GetSeparationAABB(posA, sizeA, posB, sizeB)
    local distX = posA.X - posB.X;
    local distY = posA.Y - posB.Y;

    local absDistX = math.abs(distX);
    local absDistY = math.abs(distY);

    local sumW = sizeA.X + sizeB.X;
    local sumH = sizeA.Y + sizeB.Y;
    
    local sx = sumW - absDistX;
    local sy = sumH - absDistY;

    if (sx > sy) then
        if (sy > 0) then
            sx = 0;
        end
    else
        if (sx > 0) then
            sy = 0;
        end
    end

    if (distX < 0) then
        sx = -sx;
    end

    if (distY < 0) then
        sy = -sy;
    end

    return Vector2.new(sx, sy);
end

local function GetNormalAABB(separation, velocity)
    local d = math.sqrt(separation.X * separation.X + separation.Y * separation.Y);

    local nx = separation.X / d;
    local ny = separation.Y / d;

    local ps = velocity.X * nx + velocity.Y * ny;

    if (ps <= 0) then
        return Vector2.new(nx, ny);
    end
    return Vector2.new(0,0);
end

local Face = {
    Top = 0;
    Left = 1;
    Bottom = 2;
    Right = 3;
};

local function GetLineIntersects(a1, a2, b1, b2)
    local intersection = Vector2.new(0,0);

    local b = a2 - a1;
    local d = b2 - b1;
    local bDotDPerp = b.X * d.Y - b.Y * d.X;

    -- if b dot d == 0 it means the lines are parallel
    if bDotDPerp == 0 then
        return false;
    end

    local c = b1 - a1;
    local t = (c.X * d.Y - c.Y * d.X) / bDotDPerp;
    if (t < 0 or t > 1) then
        return false;
    end

    local u = (c.X * b.Y - c.Y * b.X) / bDotDPerp;
    if (u < 0 or u > 1) then
        return false;
    end

    intersection = (a1 + t * b);
    return intersection;
end

local function GetLineRectIntersects(linesegA, linesegB, rectPos, rectRadius)
    local intersection = Vector2.new(0,0);

    local collidingFace = 0;

    local rect_topleft = rectPos - rectRadius;
    local rect_bottomright = rectPos + rectRadius;
    local rect_bottomleft = rectPos + Vector2.new(-rectRadius.X, rectRadius.Y);
    local rect_topright = rectPos + Vector2.new(rectRadius.X, -rectRadius.Y);
    
    local top_hits = GetLineIntersects(linesegA, linesegB, rect_topleft, rect_topright);
    local bottom_hits = GetLineIntersects(linesegA, linesegB, rect_bottomleft, rect_bottomright);
    local left_hits = GetLineIntersects(linesegA, linesegB, rect_topleft, rect_bottomleft);
    local right_hits = GetLineIntersects(linesegA, linesegB, rect_topright, rect_bottomright);

    if top_hits or bottom_hits or left_hits or right_hits then
        intersection = linesegB;

        if (top_hits and linesegA:Distance(top_hits) < linesegA:Distance(intersection)) then
            intersection = top_hits;
            collidingFace = Face.Top;
        end

        if (bottom_hits and linesegA:Distance(bottom_hits) < linesegA:Distance(intersection)) then
            intersection = bottom_hits;
            collidingFace = Face.Bottom;
        end

        if (left_hits and linesegA:Distance(left_hits) < linesegA:Distance(intersection)) then
            intersection = left_hits;
            collidingFace = Face.Left;
        end

        if (right_hits and linesegA:Distance(right_hits) < linesegA:Distance(intersection)) then
            intersection = right_hits;
            collidingFace = Face.Right;
        end
        return intersection, collidingFace;
    end
    return false;
end


local PhysicsAlgorithms = {
    GetOverlapsAABB = GetOverlapsAABB,
    GetSeparationAABB = GetSeparationAABB,
    GetNormalAABB = GetNormalAABB,
    GetLineIntersects = GetLineIntersects,
    GetLineRectIntersects = GetLineRectIntersects,
};
PhysicsAlgorithms.__index = PhysicsAlgorithms;
return PhysicsAlgorithms;