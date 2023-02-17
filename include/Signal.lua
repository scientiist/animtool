local Signal = {};
Signal.__index = Signal;
function Signal.new()
    local self = setmetatable({}, Signal);
    self.callbacks = {};
    return self;
end

function Signal:Connect(callback)
    local id = #self.calbacks+1;
    self.callbacks[id] = callback;
    --table.insert(self.callbacks, callback);
    return id;
end

function Signal:Disconnect(callback_id)
    self.callbacks[id] = nil;;
end

function Signal:Call(...)
    for id, callback in pairs(self.callbacks) do
        -- TODO: Async;
        callback(...);
    end
end

function Signal.__call(siggy, ...)
    siggy:Call(...);
end


return Signal;