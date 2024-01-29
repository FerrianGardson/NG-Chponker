-- Создание объекта для хранения состояний звуковых уведомлений
local chponker_checker = {
    say = true,
    yell = true,
    emote = true,
    party = true,
    monsterSay = true,
    npcSay = true,
    npcYell = true,
    raid = true,
    raidLeader = true,
    groupLeader = true,
    whisper = true,
}

-- Функция для проигрывания звука
local function playSound(soundFile)
    PlaySoundFile(soundFile, "Master")
end

-- Функция для обработки событий чата
local function handleChatEvent(self, event, ...)
    -- Определение типа события и выбор соответствующего звука
    local soundFile
    if event == "CHAT_MSG_SAY" and chponker_checker.say then
        soundFile = "Interface\\AddOns\\Chponker\\Sounds\\say.wav"
    elseif event == "CHAT_MSG_YELL" and chponker_checker.yell then
        soundFile = "Interface\\AddOns\\Chponker\\Sounds\\yell.wav"
    elseif (event == "CHAT_MSG_EMOTE" or event == "CHAT_MSG_TEXT_EMOTE") and chponker_checker.emote then
        soundFile = "Interface\\AddOns\\Chponker\\Sounds\\emote.wav"
    -- Добавьте остальные типы событий с аналогичной логикой
    end

    -- Если есть звук, проиграйте его
    if soundFile then
        playSound(soundFile)
    end
end



-- Регистрация фрейма для событий чата
local chatFrame = CreateFrame("FRAME")
chatFrame:RegisterEvent("CHAT_MSG_SAY")
chatFrame:RegisterEvent("CHAT_MSG_YELL")
chatFrame:RegisterEvent("CHAT_MSG_EMOTE")
chatFrame:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
-- Регистрируйте остальные типы событий

chatFrame:SetScript("OnEvent", handleChatEvent)

-- Теперь chponker_checker содержит параметры для каждого типа сообщений, и они все инициализированы значением true
-- Вы можете использовать chponker_checker.say, chponker_checker.yell и т. д., чтобы проверить, включен ли звук для конкретного типа сообщения


