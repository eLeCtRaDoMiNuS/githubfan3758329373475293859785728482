local colorbox
local function makeRainbowText(text)
    spawn(function()
        colorbox = Color3.fromRGB(170,0,170)
        local x = 0
        while wait() do
            colorbox = Color3.fromHSV(x,1,1)
            x = x + 4.5/255
            if x >= 1 then
                x = 0
            end
        end
    end)
    spawn(function()
        repeat
            wait()
            text.TextColor3 = colorbox
        until true == false
    end)
end

local array = Instance.new("ScreenGui", game:GetService("CoreGui"))
local arrayFrame = Instance.new("Frame", array)
arrayFrame.Size = UDim2.new(0.13, 0, 1, 0)
arrayFrame.Position = UDim2.new(0.87, 0, 0, 0)
arrayFrame.BackgroundTransparency = 1
local Grid = Instance.new("UIGridLayout",arrayFrame)
Grid.CellPadding = UDim2.new(0, 0, 0.0001, 0)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.CellSize = UDim2.new(1, 0, 0.0275, 0)
Grid.HorizontalAlignment = "Left"

task.spawn(function()
    while task.wait(1) do
        array.Enabled = shared["CometConfigs"].Enabled
     end
end)

Arraylist = {
    Add = function(Name,Suffix)
        local Text = Instance.new("TextLabel",arrayFrame)
        local newName
        if Suffix then
			newName = Name.." | "..Suffix
        else
            newName = Name
        end
        Text.Name = Name
        Text.BackgroundTransparency = 1
        Text.Size = UDim2.new(0,0,1,0)
        Text.Font = Enum.Font.Gotham
        local TextScale = Text.AbsoluteSize.Y * 0.7
        Text.TextSize = TextScale
        Text.Text = newName.." "
        local size = game:GetService("TextService"):GetTextSize(newName, TextScale, Enum.Font.Gotham, Vector2.new(1000000, 1000000))
        Text.TextXAlignment = "Right"
        Text.LayoutOrder = -size.X
	Text.TextColor3 = makeRainbowText(Text)
	Text.TextStrokeTransparency = 0
	Text.TextStrokeColor = Color3FromRGB(0,0,0)
	Text.TextStroke = 1
        task.spawn(function()
            repeat
                task.wait()
                Text.TextColor3 = makeRainbowText(Text)
            until not Text
        end)
    end,
    Remove = function(Name)
        if arrayFrame:FindFirstChild(Name) then
            arrayFrame:FindFirstChild(Name):Destroy()
        end
    end,
}


return Arraylist
