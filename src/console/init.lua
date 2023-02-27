require("include.ikkuna.ikkuna");

local console = {};
console.__index = console;



console.open = false;
console.display = ikkuna.Display:new();
console.window = ikkuna.Window:new({
    id = 'Window',
    title = 'Console',
	resizeToContentWidget = true,
    size = {width=500, height = 400},
    
	draggable = true,
	
});
local content = ikkuna.Widget:new({
	layout = {
		type = 'vertical',
		args = {
			resizeParent = true
		}
	},
	
});

local message_history_box = ikkuna.ScrollArea:new({
	parent = content,
	layout = {type='vertical', args = {
        resizeParent = true,
    },},
    children = {
        {type = 'Label', args = {text = "TEST 1234444444444444444444444"}},
        {type = 'Label', args = {text = "TEST 123"}},
        {type = 'Label', args = {text = "TEST 123"}},
        {type = 'Label', args = {text = "TEST 123"}},
    },
});

local command_bar = ikkuna.Widget:new({
	parent = content,
	size = {width = 0, height = 30},
	layout = {type = 'horizontal', args = {
		
	}}, 

});

local input_box = ikkuna.TextInput:new({
	parent = command_bar,
	editable = true,
	size = {width = 300, height = 0}
})
local send_cmd_button = ikkuna.Button:new({
	parent = command_bar,
	text = 'Run Command',
	events = {
		onClick = function()
			local cmd_str = input_box.buffer;
			input_box:setBuffer("");
			console:parseCommandString(cmd_str);
		end,
	}
})



--content:addChild(tab_bar);
--content:addChild(message_history_box);
--content:addChild(command_bar);

console.window:setContentWidget(content);

console.window:showCentered();
console.display.root:addChild(console.window);

console.Commands = {};

function console:addCommand(command_args)
	
end

function console:parseCommandString(command_full)
	console.log(">"..command_full);

	local tokens = command_full:split(' ');

	local command_keyword = tokens[1];
	print(command_keyword);
end

function console.log(t)

	local label = ikkuna.Label:new({
		text = t
	})
	message_history_box:addChild(label);
end

function console:textinput(t)

end

function console:keypressed(key, code, repeated)
	
	--self.display:onKeyPressed(key, code, repeated)
end

function console:keyreleased(key, code)
	--self.display:onKeyReleased(key, code)

end

function console:mousepressed(x, y, button, touch, presses)
	if self.display:onMousePressed(x, y, button, touch, presses) then
		return
	end
end

function console:mousereleased(x, y, button, touch, presses)
	if self.display:onMouseReleased(x, y, button, touch, presses) then
		return
	end
end

function console:mousemoved(x, y, dx, dy, touch)
	if self.display:onMouseMoved(x, y, dx, dy, touch) then
		return
	end
end

function console:wheelmoved(x, y)
	self.display:onWheelMoved(x, y)
end

function console:resize(width, height)
	self.display:onResize(width, height)
end

function console:Update(delta)
    if self.open then
        self.display:update(delta);
    end
end

function console:Draw()
    if self.open then
        self.display:draw();
    end
end


return console;
