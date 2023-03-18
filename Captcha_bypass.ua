getgenv().AutoCaptcha = true

repeat task.wait() until game:IsLoaded()
-- wait for the game be loaded

local plr = game:GetService("Players").LocalPlayer

repeat task.wait() until plr:FindFirstChildOfClass("PlayerGui")
-- wait for the platyer gui to exist
local plrgGui = plr.PlayerGui
local loadingText
plrgGui.ChildAdded:Connect(function(new)
   if not getgenv().AutoCaptcha then return end
   if new:IsA("ScreenGui")
   and new.Name == "ScreenGui" and new.DisplayOrder == 100 then
       local loaded = false
       local holder = new.Frame -- the holder
       local main = holder.Frame -- main thing
       for i,v in next, main:GetChildren() do
           task.spawn(function()
               if v.Name:find("Option") then
                   local text = v.TextLabel
                   repeat
                       task.wait()
                   until loaded
                   if text.TextColor3 == Color3.fromRGB(0, 255, 0) then -- its god
                       print("Good : " .. text.Text .."\n")

                       firesignal(v.MouseEnter) -- it require this one
                       firesignal(v.MouseButton1Up)
                       firesignal(v.MouseButton1Click)
                       firesignal(v.Activated)

                       -- idk what is the one so i added every of them xd

                   elseif text.TextColor3 == Color3.fromRGB(255, 0, 0) then -- its a bad
                       warn("Bad : " .. text.Text .."\n")
                   end


               end
           end)
       end

       for i,v in next, holder:GetChildren() do
           local text = v:FindFirstChildOfClass("TextLabel")
           if text and v:IsA("ImageLabel") then
               if text.Text == "Loading Captcha..." then
                   loadingText = text
               end
           end
       end
       repeat task.wait() until not loadingText.Visible
       loaded = true
       -- so it wait for the thing to be "loaded"

   end
end)
