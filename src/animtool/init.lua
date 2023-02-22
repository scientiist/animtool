-- YO 

local animtool = {};
animtool.__index = animtool;

function animtool.new()
    local self = setmetatable({}, animtool);



    return self;
end

function animtool:Update(delta)

end

function animtool:Draw()

end

return animtool;