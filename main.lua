--- Blacktop Saga Main Script
--- @auth: Joshua O'Leary
--- @name main.lua
--- @copyright Conarium Software 2023
--- @

-- Disables Texture Blurring
love.graphics.setDefaultFilter("nearest", "nearest");

-- Preload Game Assets
_G.Assets = require("src.assets");

_G.console = require("src.console");

console:addCommand("quit", "Exits the program");
console:addCommand("import_skeleton", "Imports a skeleton file");

-- Declare Objects
local Vector2 = require("include.Vector2");
_G.Vector2 = Vector2;


-- animtool Editor variables
local bone = require("include.lovebone");
local mySkeleton = require("src.TestSkeleton");
local myActor = bone.newActor(mySkeleton);

local settings = {};
settings.boneLineColor = {255, 0, 0, 255};
settings.boneTextColor = {0, 255, 0, 255};
settings.attachmentLineColor = {0, 0, 255, 255};
settings.attachmentTextColor = {255, 0, 255, 255};
myActor:SetDebug({
    "Neck", "UpperTorso", "LowerTorso",
    "UpperLeftArm", "LowerLeftArm", "LeftWrist",
    "UpperRightArm", "LowerRightArm", "RightWrist",
    "UpperLeftLeg", "LowerLeftLeg", "LeftAnkle",
    "UpperRightLeg", "LowerRightLeg", "RightAnkle"
}, true, settings);

local testAnim = bone.newAnimation(mySkeleton);

testAnim:AddKeyFrame("UpperRightArm", 1, math.rad(85), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 1.5, math.rad(85), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 2, math.rad(45), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 2.5, math.rad(85), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 3, math.rad(45), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 3.5, math.rad(85), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 4, math.rad(45), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 4.5, math.rad(85), nil, nil);
testAnim:AddKeyFrame("LowerRightArm", 5, math.rad(45), nil, nil);

myActor:GetTransformer():SetTransform("anim_curl", testAnim);


local filedialog = require("src.filedialog");

require("include.ikkuna.ikkuna");

local EditorDisplay = ikkuna.Display:new();
local widgets = ikkuna.Widget:new({
    size = {width = 20, height = 24},
    layout = {type = 'horizontal', args = {resizeParent = true}}, children = {
    {type = 'Button', args = {
        text = 'File',
        events = {
            onClick = function()
                local contextMenu = ikkuna.ContextMenu:new()
                contextMenu:addOption("Import Skeleton",function()
                    print("REEEEEEEEE");
                end);
                contextMenu:addOption("Play Animation",function()
                    myActor:GetTransformer():SetPower("anim_curl", 1);
                end);
                contextMenu:addOption("New Animation",function()
                    myActor:GetTransformer():SetPower("anim_curl", 1);
                end);
                contextMenu:addOption("Open Animation",function()
                    if filedialog then
                    	local handle =  filedialog.open("Open Animation");
                    end    
                end);
                contextMenu:addOption("Save Animation",function()

                    if filedialog then
			local filename = filedialog.save("Save Animation");
		    end
                end);

                contextMenu:addSeparator();
                contextMenu:show()
            end,
        }
    }},
    {type = 'Button', args = {
        text = 'Edit',
        events = {
            onClick = function()
                local contextMenu = ikkuna.ContextMenu:new()
                contextMenu:addOption("Undo (Ctrl+Z)",function()
                    
                end);
                contextMenu:addOption("Redo (Ctrl+Y)",function()
                    
                end);
                contextMenu:addOption("Cut Selection",function()
                    myActor:GetTransformer():SetPower("anim_curl", 1);
                end);
                

                contextMenu:addSeparator();
                contextMenu:show()
            end,
        },
    }},
    {type = 'Button', args = {
        text = 'View',
        events = {
            onClick = function()
                local contextMenu = ikkuna.ContextMenu:new()
                contextMenu:addOption("Enable Grid");
            end,
        },
    }},
    {type = 'Button', args = {
        text = 'Settings',
        events = {
            onClick = function()
                --window:hide()
                --gameRoot:show()
            end,
        },
    }},
    {type = 'Button', args = {
        text = 'Help',
        events = {
            onClick = function()
                --window:hide()
                --gameRoot:show()
            end,
        },
    }}
}})

EditorDisplay.root:addChild(widgets);


-- Create the visual elements for the actor
local boneVisual = {};
-- Add attachments to the actor using the visual elements.

for i, name in pairs(mySkeleton:GetBoneList()) do
    local bonedata = mySkeleton:GetBone(name);

    
    local x, y = 10, 10;

    if bonedata.Width then
        x = bonedata.Width;
    end

    if bonedata.Height then
        y = bonedata.Height;
    end
    local imageData = love.image.newImageData(x, y);
    
	imageData:mapPixel(function(x, y, r, g, b, a) 

        if name == "Skull" then
            return 255, 0, 0, 255;
        end

        if name == "Neck" then
            return 0, 255, 0, 255;
        end
        if name == "UpperSpine" then
            return 255, 255, 0, 255;
        end

        if name == "UpperSpine" then
            return 255, 255, 0, 255;
        end

        if name == "LowerSpine" then
            return 0, 128, 128, 255;
        end


		return 255,255,255, 255;
	end);
	boneVisual = bone.newVisual(imageData);
	local vw, vh = boneVisual:GetDimensions();
	boneVisual:SetOrigin(vw/2, 0);


	local myAttachment = bone.newAttachment(boneVisual);
	myActor:SetAttachment(name, "skin", myAttachment);
end
--myActor:GetTransformer():GetRoot().rotation = math.rad(-90);
myActor:GetTransformer():GetRoot().translation = {love.graphics.getWidth() / 2, love.graphics.getHeight() / 2};


function love.keypressed(key, isRepeat)
	if (key == 'f') then
		
	end
end

function love.load()
    love.window.setTitle("animtool v1.00 - Conarium Software");
	love.window.setMode(800, 600, {msaa=0});
end

local prevMous = Vector2.new(love.mouse.getX(), love.mouse.getY());

function love.update(delta)

    myActor:Update(delta);

    EditorDisplay:update(delta);

    if (myActor:GetTransformer():GetPower("anim_curl") > 0) then
		local vars = myActor:GetTransformer():GetVariables("anim_curl");
		vars.time = vars.time + delta;
	end

    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    if love.keyboard.isDown("r") then
        love.event.quit("restart")
    end


    local currMous = Vector2.new(love.mouse.getX(), love.mouse.getY());
    if love.mouse.isDown(1) then
        local deltaMous = currMous - prevMous;
        
    end
    prevMous = currMous;
end

function love.draw()

    myActor:Draw();
    EditorDisplay:draw();
end
function love.textinput(text)
	if EditorDisplay:onTextInput(text) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.keypressed(key, code, repeated)
	if EditorDisplay:onKeyPressed(key, code, repeated) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.keyreleased(key, code)
	if EditorDisplay:onKeyReleased(key, code) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.mousepressed(x, y, button, touch, presses)
	if EditorDisplay:onMousePressed(x, y, button, touch, presses) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.mousereleased(x, y, button, touch, presses)
	if EditorDisplay:onMouseReleased(x, y, button, touch, presses) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.mousemoved(x, y, dx, dy, touch)
	if EditorDisplay:onMouseMoved(x, y, dx, dy, touch) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.wheelmoved(x, y)
	if EditorDisplay:onWheelMoved(x, y) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.resize(width, height)
	EditorDisplay:onResize(width, height)
end
