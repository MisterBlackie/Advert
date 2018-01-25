--[[
	cl_advert.lua
]]--

net.Receive("EnvoyerMessageJoueurAdvert",function ()

	local Nom = net.ReadString()
	local Str = net.ReadString()
	local JobColor = net.ReadColor()
	chat.AddText(Color(47, 237, 9), "[Advert] ", JobColor, Nom, ":", Color(255, 255, 255), Str)
end)

net.Receive("EnvoyerMessageErreurAdvert", function()

	notification.AddLegacy("Argument invalide !", NOTIFY_ERROR, 3)
	chat.PlaySound()
end)