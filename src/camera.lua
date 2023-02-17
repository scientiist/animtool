
local Object = require("include.Object");

local Camera = Object:subclass("Camera");

function Camera:init()
    self.ViewTransform = love.math.newTransform(); 
    self.ZoomLevel = 0;
  
end


function Camera:Update(delta)

end


function Camera:ScreenSpaceToWorldSpace(vector)

end

function Camera:WorldSpaceToScreenSpace(vector)

end

function Camera:Zoom(meters)

end


function Camera:Draw()

end



return Camera;