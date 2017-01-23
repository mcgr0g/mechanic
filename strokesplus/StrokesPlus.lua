--Enter any Lua script that you'd like always executed when StrokesPlus loads, 
--or when you click Reload Config and Lua Engine.

function sp_init()
	-- code in this function is fired once when the Lua engine is reloaded
    -- which occurs when S+ is started, Ok/Apply is clicked in the settings window
    -- or when Reload Config and Lua Engine is clicked from the tray menu
end

function sp_before_action(gnm, gsx, gsy, gex, gey, gwd, gapp, gact, gbl, gbt, gbr, gbb)
	-- this code is fired before each action (excluding hotkey actions)
end

function sp_after_action(gnm, gsx, gsy, gex, gey, gwd, gapp, gact, gbl, gbt, gbr, gbb)
	-- this code is executed after each action (excluding hotkey actions)
    -- this function is not enabled by default, you must check the following setting
    -- in the Preferences tab: Allow After Action Script*
end

function sp_right_mouse_up()
	-- this code is executed whenever you press the right mouse button down
	-- this function is not enabled by default, you must check the following setting
    -- in the Preferences tab: Allow Right Click Script*
end

function sp_middle_mouse_up()
	-- this code is executed whenever you press the middle mouse button down
	-- this function is not enabled by default, you must check the following setting
    -- in the Preferences tab: Allow Middle Click Script*
end

function sp_left_mouse_up()
	-- this code is executed whenever you press the left mouse button down
	-- this function is not enabled by default, you must check the following setting
    -- in the Preferences tab: Allow Left Click Script*
end

function sp_x1_mouse_up()
	-- this code is executed whenever you press the X1 mouse button down
	-- this function is not enabled by default, you must check the following setting
    -- in the Preferences tab: Allow X1 Click Script*
end

function sp_x2_mouse_up()
	-- this code is executed whenever you press the X2 mouse button down
	-- this function is not enabled by default, you must check the following setting
    -- in the Preferences tab: Allow X2 Click Script*
end

function sp_after_release()
	-- this code is executed whenever you release the stroke button
	-- this function is not enabled by default, you must check the following setting
    -- in the Preferences tab: Allow After Release Script*
end

bTaskMode = 0 

 

function sp_after_release() 
    if bTaskMode == 1 then 
        acSendAltUp() 
    end 
    bTaskMode = 0 
end

 