--- Blacktop Saga Main Script
--- @auth: Joshua O'Leary
--- @name main.lua
--- @copyright Conarium Software 2023
--- @

-- Disables Texture Blurring
love.graphics.setDefaultFilter("nearest", "nearest");

-- Preload Game Assets
_G.Assets = require("src.assets");

local Object = require("include.Object");

-- Declare Objects
local Vector2 = require("include.Vector2");
_G.Vector2 = Vector2;


local bone = require("include.lovebone");

local mySkeleton = bone.newSkeleton();
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

local UpperSpine = bone.newBone(nil, 1, {0,0}, 0, {0,0}, {1.5, 1.5});

UpperSpine.Width = 20;
UpperSpine.Height = 20;
mySkeleton:SetBone("UpperSpine", UpperSpine);



local Neck = bone.newBone("UpperSpine", 2, {0,-20}, 0, {0,0}, {1, 1});
Neck.Width = 20;
Neck.Height = 30;
mySkeleton:SetBone("Neck", Neck);
local Skull = bone.newBone("Neck", 3, {0,-40}, 0, {0,0}, {1, 1});
mySkeleton:SetBone("Skull", Skull);
Skull.Width = 50;
Skull.Height = 50;


local UpperLeftArm = bone.newBone("UpperSpine", 2,  {25,10}, math.rad(-25), {0,0}, {1, 1});
UpperLeftArm.Width = 20;
UpperLeftArm.Height = 40;
mySkeleton:SetBone("UpperLeftArm", UpperLeftArm);
local LowerLeftArm = bone.newBone("UpperLeftArm", 3,  {0,40}, math.rad(20), {0,0}, {1, 1});
LowerLeftArm.Width = 15;
LowerLeftArm.Height = 40;
mySkeleton:SetBone("LowerLeftArm", LowerLeftArm);
local LeftWrist = bone.newBone("LowerLeftArm", 4,  {0,40}, math.rad(-10), {0,0}, {1, 1});
LeftWrist.Width = 20;
LeftWrist.Height = 20;
mySkeleton:SetBone("LeftWrist", LeftWrist);

local UpperRightArm = bone.newBone("UpperSpine", 2, {-25,10}, 0, {0,0}, {1, 1});
UpperRightArm.Width = 20;
UpperRightArm.Height = 40;
--UpperRightArm:SetDefaultRotation(-math.rad(45));
mySkeleton:SetBone("UpperRightArm", UpperRightArm);
local LowerRightArm = bone.newBone("UpperRightArm", 3, {0,40}, 0, {0,0}, {1, 1});
LowerRightArm.Width = 15;
LowerRightArm.Height = 40;
mySkeleton:SetBone("LowerRightArm", LowerRightArm);
local RightWrist = bone.newBone("LowerRightArm", 4, {0,40}, 0, {0,0}, {1, 1});
RightWrist.Width = 20;
RightWrist.Height = 20;
mySkeleton:SetBone("RightWrist", RightWrist);

local LowerSpine = bone.newBone("UpperSpine", 2, {0,100}, 0, {0,0}, {1, 1});
mySkeleton:SetBone("LowerSpine", LowerSpine);

local UpperLeftLeg = bone.newBone("LowerSpine", 2, {-15,20}, 0, {0,0}, {1, 1});
UpperLeftLeg.Width = 20;
UpperLeftLeg.Height = 50;
mySkeleton:SetBone("UpperLeftLeg", UpperLeftLeg);
local LowerLeftLeg = bone.newBone("UpperLeftLeg", 3, {0,50}, 0, {0,0}, {1, 1});
LowerLeftLeg.Width = 15;
LowerLeftLeg.Height = 50;
mySkeleton:SetBone("LowerLeftLeg", LowerLeftLeg);
local LeftAnkle = bone.newBone("LowerLeftLeg", 4, {0,35}, 0, {0,0}, {1, 1}); -- Rename to Foot?
LeftAnkle.Width = 20;
LeftAnkle.Height = 20;
mySkeleton:SetBone("LeftAnkle", LeftAnkle);

local UpperRightLeg = bone.newBone("LowerSpine", 2, {15,20}, 0, {0,0}, {1, 1});
UpperRightLeg.Width = 20;
UpperRightLeg.Height = 50;

mySkeleton:SetBone("UpperRightLeg", UpperRightLeg);
local LowerRightLeg = bone.newBone("UpperRightLeg", 3, {0,50}, 0, {0,0}, {1, 1});
LowerRightLeg.Width = 15;
LowerRightLeg.Height = 50;
mySkeleton:SetBone("LowerRightLeg", LowerRightLeg);
local RightAnkle = bone.newBone("LowerRightLeg", 4, {0,35}, 0, {0,0}, {1, 1});
RightAnkle.Width = 20;
RightAnkle.Height = 20;
mySkeleton:SetBone("RightAnkle", RightAnkle);

--mySkeleton:GetBone("LowerRightLeg").rotation = math.rad(50);

mySkeleton:Validate();
print(mySkeleton:IsValid());


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
                    
                    local handle =  filedialog.open("Open Animation");
                        
                end);
                contextMenu:addOption("Save Animation",function()
                    local filename = filedialog.save("Save Animation");
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
                --window:hide()
                --gameRoot:show()
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
