local frame = CreateFrame("FRAME")
frame:RegisterEvent("CHAT_MSG_SAY")
frame:SetScript("OnEvent", function(self, event, ...)
local soundFile = "Interface\\AddOns\\Chponker\\Sounds\\say.wav"
PlaySoundFile(soundFile, "Master")
--[[ print("Реплика!") ]]
end)

local frame = CreateFrame("FRAME")
frame:RegisterEvent("CHAT_MSG_YELL")
frame:SetScript("OnEvent", function(self, event, ...)
local soundFile = "Interface\\AddOns\\Chponker\\Sounds\\yell.wav"
PlaySoundFile(soundFile, "Master")
--[[ print("Крик!") ]]
end)


local frame = CreateFrame("FRAME")
frame:RegisterEvent("CHAT_MSG_EMOTE")
frame:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
frame:SetScript("OnEvent", function(self, event, ...)
    local soundFile = "Interface\\AddOns\\Chponker\\Sounds\\emote.wav"
    PlaySoundFile(soundFile, "Master")
    --[[ print("Эмоут!") ]]
end)

local frame = CreateFrame("FRAME")
frame:RegisterEvent("CHAT_MSG_PARTY")
frame:SetScript("OnEvent", function(self, event, ...)
    local soundFile = "Interface\\AddOns\\Chponker\\Sounds\\say.wav"
    PlaySoundFile(soundFile, "Master")
    --[[ print("Сообщение в группе!") ]]
end)

local soundFile = "Interface\\AddOns\\Chponker\\Sounds\\say.wav"

local frameSay = CreateFrame("FRAME")
frameSay:RegisterEvent("CHAT_MSG_MONSTER_SAY")
frameSay:SetScript("OnEvent", function(self, event, ...)
    PlaySoundFile(soundFile, "Master")
    --[[ print("NPC говорит!") ]]
end)

local frameNPCSay = CreateFrame("FRAME")
frameNPCSay:RegisterEvent("CHAT_MSG_MONSTER_SAY")
frameNPCSay:SetScript("OnEvent", function(self, event, ...)
    PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\say.wav", "Master")
    --[[ print("NPC говорит!") ]]
end)

local frameNPCYell = CreateFrame("FRAME")
frameNPCYell:RegisterEvent("CHAT_MSG_MONSTER_YELL")
frameNPCYell:SetScript("OnEvent", function(self, event, ...)
    PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\say.wav", "Master")
    --[[ print("NPC кричит!") ]]
end)

local frameRaid = CreateFrame("FRAME")
frameRaid:RegisterEvent("CHAT_MSG_RAID")
frameRaid:SetScript("OnEvent", function(self, event, ...)
    PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\say.wav", "Master")
    print("Сообщение в рейд!")
end)



local frameRaidLeader = CreateFrame("FRAME")
frameRaidLeader:RegisterEvent("CHAT_MSG_RAID_LEADER")
frameRaidLeader:SetScript("OnEvent", function(self, event, ...)
    PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\say.wav", "Master")
    --[[ print("Лидер рейда говорит!") ]]
end)

local frameGroupLeader = CreateFrame("FRAME")
frameGroupLeader:RegisterEvent("CHAT_MSG_PARTY_LEADER")
frameGroupLeader:SetScript("OnEvent", function(self, event, ...)
    PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\say.wav", "Master")
    --[[ print("Лидер группы говорит!") ]]
end)

local frameWhisper = CreateFrame("FRAME")
frameWhisper:RegisterEvent("CHAT_MSG_WHISPER")
frameWhisper:SetScript("OnEvent", function(self, event, ...)
    PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\whisper.ogg", "Master")
    --[[ print("Получено личное сообщение!") ]]
end)
