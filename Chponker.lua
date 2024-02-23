print(
    "Чпонькер (10.02.2023) активирован, вбейте /chponker или /cp для настройки.")

local addonName = "Chponker"
local chponker_checker = {
    say = true,
    yell = true,
    emote = true,
    party = true,
    raid = true,
    raid_leader = true,
    raid_warning = true,
    whisper = true,
    background = true
}

-- Функция для заглушения игры

local function SoundOff()
    -- Отключаем музыку
    -- SetCVar("Sound_EnableMusic", 0)

    -- Отключаем звуки
    SetCVar("Sound_EnableSFX", 0)
    SetCVar("Sound_EnableAmbience", 0)
    SetCVar("Sound_EnableDialog", 0)
    SetCVar("Sound_EnableErrorSpeech", 0)
end

local function SoundOn()
    -- Включаем музыку
    -- SetCVar("Sound_EnableMusic", 1)

    -- Включаем звуки
    SetCVar("Sound_EnableSFX", 1)
    SetCVar("Sound_EnableAmbience", 1)
    SetCVar("Sound_EnableDialog", 1)
    SetCVar("Sound_EnableErrorSpeech", 1)
end

-- Функция для обработки событий чата
local function handleChatEvent(self, event, ...)
    -- Получаем отправителя и сообщение из списка аргументов
    local _, _, _, _, sender, _, _, _, _, _, _, guid = ...
    local message = select(1, ...)
    
    -- Проверяем, если отправитель не равен nil (т.е. если сообщение отправлено другим игроком)
    if sender then
        -- Определение типа события и выбор соответствующего звука
        if (event == "CHAT_MSG_SAY" or event == "CHAT_MSG_MONSTER_SAY") and chponker_checker.say then
            PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\say.ogg", "Master")
        elseif (event == "CHAT_MSG_YELL" or event == "CHAT_MSG_MONSTER_YELL") and chponker_checker.yell then
            PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\yell.ogg", "Master")
        elseif (event == "CHAT_MSG_EMOTE" or event == "CHAT_MSG_TEXT_EMOTE" or event == "CHAT_MSG_MONSTER_EMOTE") and
            chponker_checker.emote then
            PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\emote.ogg", "Master")
        elseif (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER") and chponker_checker.raid then
            PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\beat.ogg", "Master")
        elseif event == "CHAT_MSG_RAID_WARNING" and chponker_checker.raid_warning then
            PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\rw.ogg", "Master")
        elseif (event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER") and chponker_checker.party then
            PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\moan.ogg", "Master")
        elseif event == "CHAT_MSG_WHISPER" and chponker_checker.whisper then
            PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\kiss.ogg", "Master")
        end

        -- Получаем имена таргета и фокуса отправителя
        local targetName = UnitName("target")
        local focusName = UnitName("focus")

        -- Проверяем совпадение имен отправителя с именами таргета и фокуса
        if targetName and targetName == sender then
            -- Если тип сообщения "сказал", проигрываем звук "kiss.ogg"
            if event == "CHAT_MSG_SAY" then
                PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\kiss.ogg", "Master")
            -- Если тип сообщения "эмоция", проигрываем звук "moan.ogg"
            elseif event == "CHAT_MSG_EMOTE" then
                PlaySoundFile("Interface\\AddOns\\Chponker\\Sounds\\moan.ogg", "Master")
            end
        end
    end
end





-- Регистрация фрейма для событий чата
local chatFrame = CreateFrame("FRAME")

-- Регистрация всех типов событий чата
chatFrame:RegisterEvent("CHAT_MSG_SAY")
chatFrame:RegisterEvent("CHAT_MSG_YELL")
chatFrame:RegisterEvent("CHAT_MSG_MONSTER_SAY") -- Добавлено для NPC say
chatFrame:RegisterEvent("CHAT_MSG_MONSTER_YELL") -- Добавлено для NPC yell
chatFrame:RegisterEvent("CHAT_MSG_EMOTE")
chatFrame:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
chatFrame:RegisterEvent("CHAT_MSG_MONSTER_EMOTE") -- Добавлено для NPC emote
chatFrame:RegisterEvent("CHAT_MSG_RAID_WARNING")
chatFrame:RegisterEvent("CHAT_MSG_RAID")
chatFrame:RegisterEvent("CHAT_MSG_RAID_LEADER")
chatFrame:RegisterEvent("CHAT_MSG_PARTY")
chatFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
chatFrame:RegisterEvent("CHAT_MSG_WHISPER")

-- Установка обработчика событий для фрейма
chatFrame:SetScript("OnEvent", handleChatEvent)

-- Теперь chponker_checker содержит параметры для каждого типа сообщений, и они все инициализированы значением true
-- Вы можете использовать chponker_checker.say, chponker_checker.yell и т. д., чтобы проверить, включен ли звук для конкретного типа сообщения

-- Создаем окно настроек звуковых уведомлений
local ChponkerFrame = CreateFrame("Frame", "ChponkerFrame", UIParent, "BasicFrameTemplate")
ChponkerFrame:SetSize(275, 250)
ChponkerFrame:SetPoint("CENTER")
ChponkerFrame:SetMovable(true)
ChponkerFrame:EnableMouse(true)
ChponkerFrame:RegisterForDrag("LeftButton")
ChponkerFrame:SetScript("OnDragStart", ChponkerFrame.StartMoving)
ChponkerFrame:SetScript("OnDragStop", ChponkerFrame.StopMovingOrSizing)

-- Регистрация слэш-команды для открытия/скрытия окна
SLASH_CHPONKER1, SLASH_CHPONKER2 = '/chponker', '/cp'; -- Вы можете добавить дополнительные алиасы, если нужно
function SlashCmdList.CHPONKER(msg, editBox)
    if ChponkerFrame:IsShown() then
        ChponkerFrame:Hide()
    else
        ChponkerFrame:Show()
    end
end
-- Добавляем заголовок
ChponkerFrame.title = ChponkerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
ChponkerFrame.title:SetPoint("TOP", 0, -5)
ChponkerFrame.title:SetText("Chponker")
-- Подзаголовок
ChponkerFrame.subtitle = ChponkerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
ChponkerFrame.subtitle:SetPoint("TOP", ChponkerFrame.title, "BOTTOM", 0, -20)
ChponkerFrame.subtitle:SetText("Звуковые уведомления для чата")

-- Создаем чекбокс для Речи
ChponkerFrame.CheckboxSay = CreateFrame("CheckButton", "ChponkerFrame_CheckboxSay", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxSay:SetPoint("TOPLEFT", 10, -55)
ChponkerFrame.CheckboxSay:SetChecked(ChponkerFrame.CheckboxSay)
ChponkerFrame.CheckboxSay:SetScript("OnClick", function(self)
    chponker_checker.say = not chponker_checker.say
    print("say:", chponker_checker.say)
end)
ChponkerFrame.CheckboxSay.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxSay.label:SetPoint("LEFT", ChponkerFrame.CheckboxSay, "RIGHT", 5, 0)
ChponkerFrame.CheckboxSay.label:SetText("Речь")

-- Создаем чекбокс для Криков
ChponkerFrame.CheckboxYell = CreateFrame("CheckButton", "ChponkerFrame_CheckboxYell", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxYell:SetPoint("TOPLEFT", ChponkerFrame.CheckboxSay, "BOTTOMLEFT", 0, 0)
ChponkerFrame.CheckboxYell:SetChecked(chponker_checker.yell)
ChponkerFrame.CheckboxYell:SetScript("OnClick", function(self)
    chponker_checker.yell = not chponker_checker.yell
    print("yell:", chponker_checker.yell)
end)
ChponkerFrame.CheckboxYell.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxYell.label:SetPoint("LEFT", ChponkerFrame.CheckboxYell, "RIGHT", 5, 0)
ChponkerFrame.CheckboxYell.label:SetText("Крики")

-- Создаем чекбокс для Эмоутов
ChponkerFrame.CheckboxEmote = CreateFrame("CheckButton", "ChponkerFrame_CheckboxEmote", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxEmote:SetPoint("TOPLEFT", ChponkerFrame.CheckboxYell, "BOTTOMLEFT", 0, 0)
ChponkerFrame.CheckboxEmote:SetChecked(chponker_checker.emote)
ChponkerFrame.CheckboxEmote:SetScript("OnClick", function(self)
    chponker_checker.emote = not chponker_checker.emote
    print("emote:", chponker_checker.emote)
end)
ChponkerFrame.CheckboxEmote.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxEmote.label:SetPoint("LEFT", ChponkerFrame.CheckboxEmote, "RIGHT", 5, 0)
ChponkerFrame.CheckboxEmote.label:SetText("Эмоуты")

-- Создаем чекбокс для Группы
ChponkerFrame.CheckboxGroup = CreateFrame("CheckButton", "ChponkerFrame_CheckboxGroup", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxGroup:SetPoint("LEFT", ChponkerFrame.CheckboxSay.label, "RIGHT", 30, 0)
ChponkerFrame.CheckboxGroup:SetChecked(chponker_checker.party == true)
ChponkerFrame.CheckboxGroup:SetScript("OnClick", function(self)
    chponker_checker.party = not chponker_checker.party
    print("party:", chponker_checker.party)
end)
ChponkerFrame.CheckboxGroup.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxGroup.label:SetPoint("LEFT", ChponkerFrame.CheckboxGroup, "RIGHT", 5, 0)
ChponkerFrame.CheckboxGroup.label:SetText("Группа")

-- Создаем чекбокс для Рейда
ChponkerFrame.CheckboxRaid = CreateFrame("CheckButton", "ChponkerFrame_CheckboxRaid", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxRaid:SetPoint("TOPLEFT", ChponkerFrame.CheckboxGroup, "BOTTOMLEFT", 0, 0)
ChponkerFrame.CheckboxRaid:SetChecked(chponker_checker.raid)
ChponkerFrame.CheckboxRaid:SetScript("OnClick", function(self)
    chponker_checker.raid = not chponker_checker.raid
    print("raid:", chponker_checker.raid)
end)
ChponkerFrame.CheckboxRaid.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxRaid.label:SetPoint("LEFT", ChponkerFrame.CheckboxRaid, "RIGHT", 5, 0)
ChponkerFrame.CheckboxRaid.label:SetText("Рейд")

-- Создаем чекбокс для Лидера Рейда
ChponkerFrame.CheckboxRaidLeader = CreateFrame("CheckButton", "ChponkerFrame_CheckboxRaid", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxRaidLeader:SetPoint("TOPLEFT", ChponkerFrame.CheckboxRaid, "BOTTOMLEFT", 0, 0)
ChponkerFrame.CheckboxRaidLeader:SetChecked(chponker_checker.raid_leader)
ChponkerFrame.CheckboxRaidLeader:SetScript("OnClick", function(self)
    chponker_checker.raid_leader = not chponker_checker.raid_leader
    print("raid:", chponker_checker.raid_leader)
end)
ChponkerFrame.CheckboxRaidLeader.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxRaidLeader.label:SetPoint("LEFT", ChponkerFrame.CheckboxRaidLeader, "RIGHT", 5, 0)
ChponkerFrame.CheckboxRaidLeader.label:SetText("Рейд-лидер")

-- Создаем чекбокс для Объявлений Рейда
ChponkerFrame.CheckboxRaidWarning = CreateFrame("CheckButton", "ChponkerFrame_CheckboxRaid", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxRaidWarning:SetPoint("TOPLEFT", ChponkerFrame.CheckboxRaidLeader, "BOTTOMLEFT", 0, 0)
ChponkerFrame.CheckboxRaidWarning:SetChecked(chponker_checker.raid_warning)
ChponkerFrame.CheckboxRaidWarning:SetScript("OnClick", function(self)
    chponker_checker.raid_warning = not chponker_checker.raid_warning
    print("raid:", chponker_checker.raid_warning)
end)
ChponkerFrame.CheckboxRaidWarning.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxRaidWarning.label:SetPoint("LEFT", ChponkerFrame.CheckboxRaidWarning, "RIGHT", 5, 0)
ChponkerFrame.CheckboxRaidWarning.label:SetText("Рейд-объявления")

-- Создаем чекбокс для Лички
ChponkerFrame.CheckboxWhisper = CreateFrame("CheckButton", "ChponkerFrame_CheckboxWhisper", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxWhisper:SetPoint("TOPLEFT", ChponkerFrame.CheckboxEmote, "BOTTOMLEFT", 0, 0)
ChponkerFrame.CheckboxWhisper:SetChecked(chponker_checker.whisper)
ChponkerFrame.CheckboxWhisper:SetScript("OnClick", function(self)
    chponker_checker.whisper = not chponker_checker.whisper
    print("whisper:", chponker_checker.whisper)
end)
ChponkerFrame.CheckboxWhisper.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxWhisper.label:SetPoint("LEFT", ChponkerFrame.CheckboxWhisper, "RIGHT", 5, 0)
ChponkerFrame.CheckboxWhisper.label:SetText("Личка")

-- Создаем чекбокс для Фона
ChponkerFrame.CheckboxBack = CreateFrame("CheckButton", "ChponkerFrame_CheckboxWhisper", ChponkerFrame,
    "UICheckButtonTemplate")
ChponkerFrame.CheckboxBack:SetPoint("TOPLEFT", ChponkerFrame.CheckboxWhisper, "BOTTOMLEFT", 0, -10)
ChponkerFrame.CheckboxBack:SetChecked(chponker_checker.background)
ChponkerFrame.CheckboxBack:SetScript("OnClick", function(self)
    chponker_checker.background = not chponker_checker.background
    print("background:", chponker_checker.background)
end)
ChponkerFrame.CheckboxBack.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.CheckboxBack.label:SetPoint("LEFT", ChponkerFrame.CheckboxBack, "RIGHT", 5, 0)
ChponkerFrame.CheckboxBack.label:SetText("Фоновые звуки")
ChponkerFrame.CheckboxBack:SetScript("OnClick", function(self)
    chponker_checker.background = not chponker_checker.background
    print("background:", chponker_checker.background)
    -- В зависимости от значения background вызываем нужную функцию
    if chponker_checker.background then
        SoundOn()
    else
        SoundOff()
    end
end)

-- Апдейт чекбоксов

local function chponker_checkbox_update()
    if chponker_checker.say == true then
        ChponkerFrame.CheckboxSay:SetChecked(true)
    else
        ChponkerFrame.CheckboxSay:SetChecked(false)
    end

    if chponker_checker.yell == true then
        ChponkerFrame.CheckboxYell:SetChecked(true)
    else
        ChponkerFrame.CheckboxYell:SetChecked(false)
    end

    if chponker_checker.emote == true then
        ChponkerFrame.CheckboxEmote:SetChecked(true)
    else
        ChponkerFrame.CheckboxEmote:SetChecked(false)
    end

    if chponker_checker.party == true then
        ChponkerFrame.CheckboxGroup:SetChecked(true)
    else
        ChponkerFrame.CheckboxGroup:SetChecked(false)
    end

    if chponker_checker.raid == true then
        ChponkerFrame.CheckboxRaid:SetChecked(true)
    else
        ChponkerFrame.CheckboxRaid:SetChecked(false)
    end

    if chponker_checker.whisper == true then
        ChponkerFrame.CheckboxWhisper:SetChecked(true)
    else
        ChponkerFrame.CheckboxWhisper:SetChecked(false)
    end

    if chponker_checker.background == true then
        ChponkerFrame.CheckboxBack:SetChecked(true)
    else
        ChponkerFrame.CheckboxBack:SetChecked(false)
    end
end

-- Дебаг

-- Функция для вывода переменных в print
local function PrintVariables()
    for key, value in pairs(chponker_checker) do
        print(key, "=", value)
    end
end

-- Обработчик события для ПКМ на фрейме
ChponkerFrame:SetScript("OnMouseUp", function(self, button)
    if button == "RightButton" then
        PrintVariables()
        chponker_checkbox_update()

    end
end)

-- Функция для загрузки переменных
local function LoadVariables()
    if ChponkerAddonDB == nil then
        ChponkerAddonDB = {}
    end

    if ChponkerAddonDB.chponker_checker == nil then
        ChponkerAddonDB.chponker_checker = {
            say = true,
            yell = true,
            emote = true,
            party = true,
            raid = true,
            whisper = true,
            background = true
        }
    else
        chponker_checker = ChponkerAddonDB.chponker_checker
    end
    chponker_checkbox_update()
    ChponkerFrame:Hide()
end

-- Функция для сохранения переменных
local function SaveVariables()
    ChponkerAddonDB.chponker_checker = chponker_checker
end

-- Регистрация событий для загрузки и сохранения переменных
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "Chponker" then
        LoadVariables()
    elseif event == "PLAYER_LOGOUT" then
        SaveVariables()
    end
end)
