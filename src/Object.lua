-- Object class Prototype
local obj = {};
obj.__index = obj;
obj.types = {"Object"};

-- 
function obj:init(...)

end