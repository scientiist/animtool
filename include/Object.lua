local function deep_copy(orig)
    local orig_type = type(orig);
    local copy;
    if orig_type == 'table' then
        copy = {};
        for orig_key, orig_value in next, orig, nil do
            copy[deep_copy(orig_key)] = deep_copy(orig_value);
        end
        setmetatable(copy, deep_copy(getmetatable(orig)));
    else -- Non-Reference objects are copied trivially
        copy = orig
    end
end


local class = {};
class.__index = class;

function class:member()

end


function class.new()
    local self = setmetatable({}, class);

    self:member();
    

    return self;
end



-- Object class Prototype
-- So here's the deal:
-- The subclass must define 'init' method;
-- The instance calls :new()
-- :new() calls 'init(self)' internally
local obj = {};
obj.__index = obj;
obj.types = {"Object"};

function obj:new(...)

    if not self then

        -- Must call constructor as a 'method'
        error(
            ("Must call :new()! on constructor!"), 2);
    end

    local inst = setmetatable({}, {__index = self});
    if not inst.init then
        error(("Missing init definition for %s constructor."):format(inst.classname), 2);
    end
    inst:init(...);
    return inst;
end



function obj:subclass(classname)
    local t = setmetatable({}, {__index = self});
    t.__index = t;
    t.classname = classname;
    --t.types = deep_copy(self.types);
    table.insert(t.types, classname);
    t.super = self;
    return t;
end



return obj;