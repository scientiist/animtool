--- animtool Main Script
--- 2D Skeletal Animation Editor.
--- @auth: Joshua O'Leary
--- @name main.lua
--- @copyright Conarium Software 2023
--- @


-- Enable Local Debugging
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end


-- Disables Texture Blurring
love.graphics.setDefaultFilter("nearest", "nearest");

_G.editor = {};


_G.console = require("src.console");

console:addCommand({
    keyword = "quit",
    description = {},
    callback = function(args)

    end
});
console:addCommand({
    keyword = "load_anim",
    args = {"filename"},
    description = {},
    callback = function(args)

    end
});
console:addCommand({
    keyword = "load_anim",
    aliases = {},
    description = {},
    callback = function(args)

    end
})

-- Declare Objects
local Vector2 = require("include.Vector2");
_G.Vector2 = Vector2;


-- animtool Editor variables
local bonelib = require("include.lovebone");
editor.Skeleton = require("src.TestSkeleton");
editor.Actor = bonelib.newActor(editor.Skeleton);

editor.settings = {};

editor.settings.skeleton = {};
editor.settings.skeleton.boneLineColor = {255, 0, 0, 255};
editor.settings.skeleton.boneTextColor = {0, 255, 0, 255};
editor.settings.skeleton.attachmentLineColor = {0, 0, 255, 255};
editor.settings.skeleton.attachmentTextColor = {255, 0, 255, 255};
editor.Actor:SetDebug({
    "Neck", "UpperTorso", "LowerTorso",
    "UpperLeftArm", "LowerLeftArm", "LeftWrist",
    "UpperRightArm", "LowerRightArm", "RightWrist",
    "UpperLeftLeg", "LowerLeftLeg", "LeftAnkle",
    "UpperRightLeg", "LowerRightLeg", "RightAnkle"
}, true, editor.settings.skeleton);

editor.Animations = {}; -- Can have several anims loaded at once
-- Each anim gets its own timeline editor.
editor.Animations[1] = bonelib.newAnimation(editor.Skeleton);

editor.Animations[1]:AddKeyFrame("UpperRightArm", 1, math.rad(85), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 1.5, math.rad(85), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 2, math.rad(45), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 2.5, math.rad(85), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 3, math.rad(45), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 3.5, math.rad(85), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 4, math.rad(45), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 4.5, math.rad(85), nil, nil);
editor.Animations[1]:AddKeyFrame("LowerRightArm", 5, math.rad(45), nil, nil);

editor.Actor:GetTransformer():SetTransform("anim_curl", editor.Animations[1]);


local filedialog = require("src.filedialog");

require("include.ikkuna.ikkuna");

editor.ui = ikkuna.Display:new();

local widgets = ikkuna.Widget:new({
    size = {width = 1000, height = 24},
    layout = {type = 'horizontal', args = {resizeParent = true}}, children = {
    {type = 'Button', args = {
        text = 'File',
        events = {
            onClick = function()
                local contextMenu = ikkuna.ContextMenu:new()
                contextMenu:addOption("Import Skeleton",function()
                    if filedialog then
                        local handle = filedialog.open("Import Skeleton Script");
                        print(handle);
                        -- editor.Skeleton = require(handle);
                        -- tbh we proly need editor:loadSkeleton(script);
                    end
                end);
                contextMenu:addOption("Play Animation",function()
                    editor.Actor:GetTransformer():SetPower("anim_curl", 1);
                end);
                contextMenu:addOption("New Animation",function()
                    editor.Actor:GetTransformer():SetPower("anim_curl", 1);
                end);
                contextMenu:addOption("Open Animation",function()
                    if filedialog then
                    	local handle =  filedialog.open("Open Animation");
                        print(handle);
                    end    
                end);
                contextMenu:addOption("Save Animation",function()

                    if filedialog then
                        local filename = filedialog.save("Save Animation");
                        print(filename);
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
                contextMenu:addOption("Copy? (Ctrl+C)")
                contextMenu:addOption("Cut? (Ctrl+X)")
                contextMenu:addOption("Paste? (Ctrl+V)")
                contextMenu:addSeparator();
                contextMenu:addOption("Undo (Ctrl+Z)",function()
                    
                end);
                contextMenu:addOption("Redo (Ctrl+Y)",function()
                    
                end);
                contextMenu:addOption("Cut Selection",function()
                    editor.Actor:GetTransformer():SetPower("anim_curl", 1);
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
        text = 'Tools',
        events = {
            onClick = function()
                local contextMenu = ikkuna.ContextMenu:new()
                contextMenu:addOption("Console",function()
                    console.open = not console.open;
                end);
                contextMenu:addOption("Skeleton Inspector", function()
                
                end);
                contextMenu:addOption("Keyframe Timeline", function()
                
                end)
                contextMenu:addSeparator();
                contextMenu:show()
            end,
        },
    }}
}})

editor.ui.root:addChild(widgets);




-- Create the visual elements for the actor
local boneVisual = {};
-- Add attachments to the actor using the visual elements.

for i, name in pairs(editor.Skeleton:GetBoneList()) do
    local bonedata = editor.Skeleton:GetBone(name);

    
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
	boneVisual = bonelib.newVisual(imageData);
	local vw, vh = boneVisual:GetDimensions();
	boneVisual:SetOrigin(vw/2, 0);


	local myAttachment = bonelib.newAttachment(boneVisual);
	editor.Actor:SetAttachment(name, "skin", myAttachment);
end
--myActor:GetTransformer():GetRoot().rotation = math.rad(-90);
editor.Actor:GetTransformer():GetRoot().translation = {love.graphics.getWidth() / 2, love.graphics.getHeight() / 2};


function love.load()
    love.window.setTitle("animtool v1.00 - Conarium Software");
	love.window.setMode(1200, 700, {msaa=0});
end



local function get_engine_data()
    local graphics = love.graphics.getStats();
    local lua_mem_mb = math.floor(collectgarbage('count')/1000);
    local gpu_mem_kb = math.floor(graphics.texturememory/1000);

    local os = love.system.getOS();
    local cores = love.system.getProcessorCount();

    return 
    ("fps: %s"):format(love.timer.getFPS()) ..
    (" lua: %smb"):format(lua_mem_mb) ..
    (" gpu: %skb"):format(gpu_mem_kb) ..
    (" os: %s"):format(os)..
    (" cores: %s"):format(cores);
end


function love.update(delta)
	console:Update(delta);
    editor.Actor:Update(delta);
    editor.ui:update(delta);

    if (editor.Actor:GetTransformer():GetPower("anim_curl") > 0) then
		local vars = editor.Actor:GetTransformer():GetVariables("anim_curl");
		vars.time = vars.time + delta;
	end

   


end

function love.draw()
	console:Draw();
    editor.Actor:Draw();
    editor.ui:draw();

    love.graphics.print(get_engine_data(), 0, love.graphics.getHeight()-16);
end

function love.textinput(text)
	if console:textinput(text) then return end
	if editor.ui:onTextInput(text) then
		return
	end

end

function love.keypressed(key, code, repeated)
	-- Event Priority
	if console:keypressed(key, code, repeated) then return end
	if editor.ui:onKeyPressed(key, code, repeated) then
		return
	end


    if key == "escape" then
        love.event.quit()
    end

    if key == "r" then
        love.event.quit("restart")
    end
end

function love.keyreleased(key, code)
	if console:keyreleased(key, code) then return end
	if editor.ui:onKeyReleased(key, code) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.mousepressed(x, y, button, touch, presses)
	if console:mousepressed(x, y, button, touch, presses) then
		return
	end
	if editor.ui:onMousePressed(x, y, button, touch, presses) then
		return
	end

	-- The event was not handled by the UI, process it normally.
end

function love.mousereleased(x, y, button, touch, presses)
	console:mousereleased(x, y, button, touch, presses)
	editor.ui:onMouseReleased(x, y, button, touch, presses)

	-- The event was not handled by the UI, process it normally.
end

function love.mousemoved(x, y, dx, dy, touch)
	console:mousemoved(x, y, dx, dy, touch)
	editor.ui:onMouseMoved(x, y, dx, dy, touch)

	-- The event was not handled by the UI, process it normally.
end

function love.wheelmoved(x, y)
    editor.ui:onWheelMoved(x, y)
	console:wheelmoved(x, y)
	

	-- The event was not handled by the UI, process it normally.
end

function love.resize(width, height)
    editor.ui:onResize(width, height)
	console:resize(width, height)
	
end
