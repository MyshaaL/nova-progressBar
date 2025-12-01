local isProgressActive = false

--- Show a progress bar
--- @param duration number Duration in milliseconds
--- @param label string Text to display on the progress bar
--- @param options table? Optional settings: { canCancel = boolean, animation = table, disableControls = table }
--- @return boolean success Returns true if completed, false if cancelled
local function ShowProgress(duration, label, options)
    if isProgressActive then
        return false
    end

    options = options or {}
    local canCancel = options.canCancel or false
    local animation = options.animation or nil
    local disableControls = options.disableControls or {}

    isProgressActive = true

    SendNUIMessage({
        action = 'showProgress',
        duration = duration,
        label = label,
        canCancel = canCancel
    })

    -- Play animation if specified
    if animation and animation.dict and animation.anim then
        RequestAnimDict(animation.dict)
        while not HasAnimDictLoaded(animation.dict) do
            Wait(10)
        end
        TaskPlayAnim(PlayerPedId(), animation.dict, animation.anim, 8.0, -8.0, -1, animation.flags or 49, 0, false, false, false)
    end

    local cancelled = false
    local startTime = GetGameTimer()

    while isProgressActive do
        Wait(0)

        -- Disable controls
        for _, control in ipairs(disableControls) do
            DisableControlAction(0, control, true)
        end

        -- Check for cancellation
        if canCancel and IsControlJustPressed(0, 73) then -- X key
            cancelled = true
            break
        end

        -- Auto complete when duration is reached
        if GetGameTimer() - startTime >= duration then
            break
        end
    end

    -- Cleanup
    if animation and animation.dict and animation.anim then
        ClearPedTasks(PlayerPedId())
    end

    SendNUIMessage({
        action = 'hideProgress'
    })

    isProgressActive = false

    return not cancelled
end

--- Cancel the current progress bar
local function CancelProgress()
    if isProgressActive then
        isProgressActive = false
        SendNUIMessage({
            action = 'hideProgress'
        })
        ClearPedTasks(PlayerPedId())
    end
end

-- Export functions
exports('ShowProgress', ShowProgress)
exports('CancelProgress', CancelProgress)
