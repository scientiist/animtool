local GameScene = {};
GameScene.__index = GameScene;
function GameScene.new()
    local self = setmetatable({}, GameScene);

    self.Entities = {};

    return self;
end

function GameScene:Update()
    for _, entity in pairs(self.Entities) do

    end
end

function GameScene:Destroy()

end


return GameScene;