--[[
	Author : Kuntal Majumder
	Description : Lua script to create an animation sequence with pictures,
	similar to Marvel's old intro.
--]]

--[[ Getting the List of Loaders, if there are multiple of them,
     select the specific loaders and replace false with true --]]
loaderList = comp:GetToolList(false,"Loader")

--[[ Deselecting everything --]]
flow = comp.CurrentFrame.FlowView
flow:Select()

numberOfPictures = 0

for i,loader in ipairs(loaderList) do
	transform = comp:AddTool("Transform")
	
	--[[ Adding high quality motion blur --]]
	transform.MotionBlur = 1
	transform.Quality = 10	
	
	--[[ Adding the animation to the pictures --]]
	transform:AddModifier("Center","XYPath")
	transform.Center[0] = {0.5,1.5}
	transform.Center[3] = {0.5,0.5}
	
	--[[ Offsetting every picture by 4 frames compared to last picture --]]
	timespeed = comp:AddTool("TimeSpeed")
	timespeed.Delay = (i-1) * 4
	
	--[[ Connecting respective inputs and outputs --]]
	timespeed.Input = transform.Output
	transform.Input = loader.Output
	
	--[[ Arranging the merges properly --]]
	if i > 2 then
		--[[ One merge node is already there in the node graph which was
                     selected in the last iteration, so we connect its output
                     with the background of the current --]]
		table = comp:GetToolList(true,"Merge")
		prevMerge = table[1]
		flow:Select()
		merge = comp:AddTool("Merge")
		merge.Foreground = timespeed.Output
		merge.Background = prevMerge.Output
		flow:Select(merge, true)
	elseif i > 1 then
		--[[ Required nodes are added to the second picture so make new
                     merge node and connect the first picture's timespeed to it
                     which was selected last time --]]
		merge = comp:AddTool("Merge")
		table = comp:GetToolList(true,"TimeSpeed")
		prevTimeSpeed = table[1]
		merge.Foreground = timespeed.Output
		merge.Background = prevTimeSpeed.Output
		flow:Select(merge, true)
	else
		--[[ Required nodes added to the first picture, so no merges
                     are created, instead the timespeed node is selected --]]
		flow:Select()
		flow:Select(timespeed, true)
	end
	numberOfPictures = numberOfPictures + 1
end

--[[ Getting the last Merge node --]]
table = comp:GetToolList(true,"Merge")
toSaveMerge = table[1]

--[[ Adding a Saver node --]]
comp:Lock()
saver = comp:AddTool("Saver")
comp:Unlock()
saver.Input = toSaveMerge.Output

--[[ If the file location is predetermined we can enter the file location
     into the saver and render the whole comp instantly --]]

--[[
saver.Clip = '<file location>'
comp:Render(false,0,numberOfPictures * 4, 1,1)
--]]
