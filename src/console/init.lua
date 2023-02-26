require("include.ikkuna.ikkuna");

local console = {};
console.__index = console;

local console_width = 600;
local console_height = 300;


console.display = ikkuna.Display:new();
console.window = ikkuna.Window:new({
    id = 'Window',
    title = 'Console',
    size = {width = console_width, height = console_height},
    position = {x=300, y = 200},
});
local content = ikkuna.Widget:new({
	layout = {
		type = 'vertical',
		args = {
			resizeParent = true,
		},
	}
});

local message_history_box = ikkuna.Widget:new({
	parent = content,
	layout = {type='vertical'},
	size = {width = console_width, height = console_height-48},
});

local command_bar = ikkuna.Widget:new({
	parent = content,
	size = {width = console_width, height = 32},
	layout = {type = 'horizontal', args = {resizeParent=false}}, 
	children = {
		{type = 'TextInput'},
		{type = 'Button', args = {text = 'Run Command'}}
	}
});

--content:addChild(tab_bar);
--content:addChild(message_history_box);
--content:addChild(command_bar);

console.window:setContentWidget(content);

console.window:showCentered();
console.display.root:addChild(console.window);

console.Commands = {};

function console:addCommand(command, desc)

end

function console.log(...)
	
end

function console:textinput(t)

end

function console:keypressed(key, code, repeated)
	if self.display:onKeyPressed(key, code, repeated) then
		return
	end
end

function console:keyreleased(key, code)
	if self.display:onKeyReleased(key, code, repeated) then
		return
	end
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
	if self.display:onWheelMoved(x, y) then return end
end

function console:resize(width, height)
	if self.display:onResize(width, height) then return end;
end

function console:Update(delta)
    self.display:update();
end

function console:Draw()
    self.display:draw();
end


return console;
