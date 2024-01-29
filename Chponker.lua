print ("Чпонькер активирован, вбейте /chponker или /cp для настройки.")

-- Создание объекта для хранения состояний звуковых уведомлений
local chponker_checker = {
    say = true,
    yell = true,
    emote = true,
    party = true,
    raid = true,
    whisper = true,
    background = true,
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


-- Создаем окно настроек звуковых уведомлений
local ChponkerFrame = CreateFrame("Frame", "ChponkerFrame", UIParent, "BasicFrameTemplate")
ChponkerFrame:SetSize(200, 200)
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
ChponkerFrame.Checkbox1 = CreateFrame("CheckButton", "ChponkerFrame_Checkbox1", ChponkerFrame, "UICheckButtonTemplate")
ChponkerFrame.Checkbox1:SetPoint("TOPLEFT", 10, -50)
ChponkerFrame.Checkbox1:SetChecked(ChponkerFrame.Checkbox1)
ChponkerFrame.Checkbox1:SetScript("OnClick", function(self)
    chponker_checker.say = not chponker_checker.say
    print("Статус переменной say:", chponker_checker.say)
end)
ChponkerFrame.Checkbox1.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.Checkbox1.label:SetPoint("LEFT", ChponkerFrame.Checkbox1, "RIGHT", 5, 0)
ChponkerFrame.Checkbox1.label:SetText("Речь")

-- Создаем чекбокс для Эмоутов
ChponkerFrame.Checkbox2 = CreateFrame("CheckButton", "ChponkerFrame_Checkbox2", ChponkerFrame, "UICheckButtonTemplate")
ChponkerFrame.Checkbox2:SetPoint("TOPLEFT", ChponkerFrame.Checkbox1, "BOTTOMLEFT", 0, 0)
ChponkerFrame.Checkbox2:SetChecked(chponker_checker.emote)
ChponkerFrame.Checkbox2:SetScript("OnClick", function(self)
    chponker_checker.emote = not chponker_checker.emote
    print("Статус переменной emote:", chponker_checker.emote)
end)
ChponkerFrame.Checkbox2.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.Checkbox2.label:SetPoint("LEFT", ChponkerFrame.Checkbox2, "RIGHT", 5, 0)
ChponkerFrame.Checkbox2.label:SetText("Эмоуты")

-- Создаем чекбокс для Криков
ChponkerFrame.Checkbox3 = CreateFrame("CheckButton", "ChponkerFrame_Checkbox3", ChponkerFrame, "UICheckButtonTemplate")
ChponkerFrame.Checkbox3:SetPoint("TOPLEFT", ChponkerFrame.Checkbox2, "BOTTOMLEFT", 0, 0)
ChponkerFrame.Checkbox3:SetChecked(chponker_checker.yell)
ChponkerFrame.Checkbox3:SetScript("OnClick", function(self)
    chponker_checker.yell = not chponker_checker.yell
    print("Статус переменной yell:", chponker_checker.yell)
end)
ChponkerFrame.Checkbox3.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.Checkbox3.label:SetPoint("LEFT", ChponkerFrame.Checkbox3, "RIGHT", 5, 0)
ChponkerFrame.Checkbox3.label:SetText("Крики")

-- Создаем чекбокс для Группы
ChponkerFrame.Checkbox4 = CreateFrame("CheckButton", "ChponkerFrame_Checkbox4", ChponkerFrame, "UICheckButtonTemplate")
ChponkerFrame.Checkbox4:SetPoint("LEFT", ChponkerFrame.Checkbox1.label, "RIGHT", 30, 0)
ChponkerFrame.Checkbox4:SetChecked(chponker_checker.party)
ChponkerFrame.Checkbox4:SetScript("OnClick", function(self)
    chponker_checker.party = not chponker_checker.party
    print("Статус переменной party:", chponker_checker.party)
end)
ChponkerFrame.Checkbox4.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.Checkbox4.label:SetPoint("LEFT", ChponkerFrame.Checkbox4, "RIGHT", 5, 0)
ChponkerFrame.Checkbox4.label:SetText("Группа")

-- Создаем чекбокс для Рейда
ChponkerFrame.Checkbox5 = CreateFrame("CheckButton", "ChponkerFrame_Checkbox5", ChponkerFrame, "UICheckButtonTemplate")
ChponkerFrame.Checkbox5:SetPoint("TOPLEFT", ChponkerFrame.Checkbox4, "BOTTOMLEFT", 0, 0)
ChponkerFrame.Checkbox5:SetChecked(chponker_checker.raid)
ChponkerFrame.Checkbox5:SetScript("OnClick", function(self)
    chponker_checker.raid = not chponker_checker.raid
    print("Статус переменной raid:", chponker_checker.raid)
end)
ChponkerFrame.Checkbox5.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.Checkbox5.label:SetPoint("LEFT", ChponkerFrame.Checkbox5, "RIGHT", 5, 0)
ChponkerFrame.Checkbox5.label:SetText("Рейд")

-- Создаем чекбокс для Лички
ChponkerFrame.Checkbox6 = CreateFrame("CheckButton", "ChponkerFrame_Checkbox6", ChponkerFrame, "UICheckButtonTemplate")
ChponkerFrame.Checkbox6:SetPoint("TOPLEFT", ChponkerFrame.Checkbox5, "BOTTOMLEFT", 0, 0)
ChponkerFrame.Checkbox6:SetChecked(chponker_checker.whisper)
ChponkerFrame.Checkbox6:SetScript("OnClick", function(self)
    chponker_checker.whisper = not chponker_checker.whisper
    print("Статус переменной whisper:", chponker_checker.whisper)
end)
ChponkerFrame.Checkbox6.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.Checkbox6.label:SetPoint("LEFT", ChponkerFrame.Checkbox6, "RIGHT", 5, 0)
ChponkerFrame.Checkbox6.label:SetText("Личка")

-- Создаем чекбокс для Фона
ChponkerFrame.Checkbox7 = CreateFrame("CheckButton", "ChponkerFrame_Checkbox6", ChponkerFrame, "UICheckButtonTemplate")
ChponkerFrame.Checkbox7:SetPoint("TOPLEFT", ChponkerFrame.Checkbox3, "BOTTOMLEFT", 0, -10)
ChponkerFrame.Checkbox7:SetChecked(chponker_checker.background)
ChponkerFrame.Checkbox7:SetScript("OnClick", function(self)
    chponker_checker.background = not chponker_checker.background
    print("Статус переменной background:", chponker_checker.background)
end)
ChponkerFrame.Checkbox7.label = ChponkerFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
ChponkerFrame.Checkbox7.label:SetPoint("LEFT", ChponkerFrame.Checkbox7, "RIGHT", 5, 0)
ChponkerFrame.Checkbox7.label:SetText("Фоновые звуки")