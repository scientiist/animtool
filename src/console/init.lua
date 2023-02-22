require("include.ikkuna.ikkuna");

local console = {};
console.__index = console;

console.Canvas = ikkuna.Display:new();
console.Window = ikkuna.Window:new({
    id = 'Window',
    title = 'Console',
    size = {width = 300, height = 300},
    position = {x=200, y = 50},
});


function console:Update(delta)
    self.Canvas:update();
end

function console:Draw()
    self.Canvas:draw();
end


return console;