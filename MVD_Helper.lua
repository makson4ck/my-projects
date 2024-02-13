local ffi = require 'ffi'
local imgui = require 'mimgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local new = imgui.new
local faicons = require('fAwesome6')
local new, str = imgui.new, ffi.string
local sampev = require('lib.samp.events')
local sizeof = ffi.sizeof

function sampev.onSendSpawn()
    sampSendChat("/stats")
    sampAddChatMessage("[MVD Helper]: {FFFFFF}Скрипт успешно загрузился", 9109759)
    sampAddChatMessage("[MVD Helper]: {FFFFFF}Связь с разработчиком: телеграмм/дс makson4ck", 9109759)
    sampAddChatMessage("[MVD Helper]: {FFFFFF}Активация - /mh", 9109759)
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
    if id == 235 and title == '{BFBBBA}Основная статистика' then
        for line in text:gmatch("[^\r\n]+") do
            if line:find('{FFFFFF}Должность: {B83434}(.+)%((%d+)%)') then
                rank = line:match('{FFFFFF}Должность: {B83434}(.+)%((%d+)%)')
                print(rank)
                if line:find('Организация: (.*)') then
                org = line:gsub('{......}', ''):match('Организация: (.*)')
                print(org)
            end
        end
    end
end
end

local inicfg = require 'inicfg'
local iniFile = 'Styles.ini'
local ini = inicfg.load({
	cfg = {
		theme = 0,
		style = 0
	}
}, iniFile)
if not doesDirectoryExist(getWorkingDirectory()..'\\config') then print('Creating the config directory') createDirectory(getWorkingDirectory()..'\\config') end
if not doesFileExist('moonloader/config/'..iniFile) then print('Creating/updating the .ini file') inicfg.save(ini, iniFile) end

local theme = new.int(ini.cfg.theme)
local style = new.int(ini.cfg.style)

local spawncar = false

local themesList, stylesList = {}, {}

imgui.OnInitialize(function()
	imgui.GetIO().IniFilename = nil
	for i, v in ipairs(themes) do table.insert(themesList, v.name) end
	for i, v in ipairs(styles) do table.insert(stylesList, v.name) end

	themes[theme[0]+1].func()
	styles[style[0]+1].func()
end)

local sizeX, sizeY = getScreenResolution()


function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowWidth()/2-imgui.CalcTextSize(u8(text)).x/2)
    imgui.Text(u8(text))
end
--Цени текси

local ini = inicfg.load({
    cfg =
    {
mytag = "",
totag = ""
    }}, "Auto Tag MH.ini")
    
    local mytag = new.char[255](u8(ini.cfg.mytag))
local totag = new.char[255](u8(ini.cfg.totag))
local zk = "-"

local org = 0
--ОБНОВЛЕНИЕ--
local imgui = {
    update = {
        version = "1.0.2",
        needupdate = false,
        updateText = "Нажмите на \"Проверить обновление\""
    }
}
--Другое--
local sizeX, sizeY = getScreenResolution()
local sobes = {
    status = false,
    FastAction = new.bool(false)
}
--
local myID = select(2, sampGetPlayerIdByCharHandle(1))
local aidi = imgui.new.int(0)
local idsu = imgui.new.int(0)
local tab = 1
local WinState = new.bool()
local Roz = new.bool()

imgui.OnFrame(function()
    return Roz[0]
end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(500,500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- положение окна на экране
    imgui.SetNextWindowSize(imgui.ImVec2(1000, 480), imgui.Cond.Always) -- размер окна
    imgui.Begin(faicons('user_police') .. u8' Police Helper I Выдача розыска', Roz) -- Название окна

    if imgui.Button(faicons('user_police') .. u8' Розыск', imgui.ImVec2(160, 60)) then
        tab = 1
    end

imgui.SetCursorPos(imgui.ImVec2(175, 33))
if imgui.BeginChild('Name', imgui.ImVec2(-1, -1), true) then



        if tab == 1 then
            if imgui.CollapsingHeader(faicons('keyboard') .. u8' Неподчинение, оружие, наркотики') then 
		
                local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
                    if changed then
                            aidi = imgui.new.int(aidi[0])
                        end
                        
        if imgui.Button(faicons('USER_CHECK') .. u8' 9.5УК Неповиновение лицом законному требованию, приказу, распоряжению правомочного лица (сотрудника SWAT, FBI, LSPD, LSSD, SFPD; военнослужащего или сотрудника тюрьмы, находящихся на посту; судьи). * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 9.5 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' 9.6УК Отказ или уклонение от уплаты штрафа выписанного правомочным лицом. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 9.6 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 10.2 Умышленное неисполнение сотрудником органов правопорядка (SFPD, FBI, LSPD, LSSD, SWAT) приказа начальства, отданного в установленном порядке и не противоречащего закону. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 10.2 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК5.10 Ношение оружия в открытом виде. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 5.10 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 5.11 Хранение/перевозка/использование/сбыт материалов. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 5.11 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 5.12 Храние/перевозка/использования оружие без должной лицензии. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 5.12 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 5.14 Нелегальная продажа/покупка огнестрельного оружия. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 5.14 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 6.1 Сбыт/перевозка/хранение/употребление наркотических веществ. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.1 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 6.2 Выращивание наркотиков. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.2 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 6.3 Скупка или попытка покупки наркотических веществ. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.3 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 6.4 Продажа/покупка/хранения/перевозка семян наркотиков. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.4 УК')
            end)
        end
    end

    if imgui.CollapsingHeader(faicons('keyboard') .. u8' Преступления против жизни и здоровья, свободы, достоинства личности.') then 
		
        local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
                end

                if imgui.Button(faicons('USER_CHECK') .. u8' УК 3.1 Похищение человека * 6', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 6 3.1 УК')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' УК 3.2 Клевета, то есть распространение заведомо ложных сведений, порочащих честь и достоинство другого лица или подрывающих его репутацию. * 2', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 2 3.2 УК')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' УК 3.3 Клевета, содержащаяся в публичном выступлении, средствах массовой информации либо с использованием своего служебного положения. * 4', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 4 3.3 УК')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' УК 3.4 Клевета, соединенная с обвинением лица в совершении преступления. * 3', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 3 3.4 УК')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' 3.5 Оскорбление или унижение чести и достоинства гражданина по национальному, культурному, половому, гендерному, расовому признаку. * 3', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' ')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' УК 3.6 Поддержка или финансирование, либо же создание ультраправых националистических организаций, занимающихся активной деятельностью, нарушающую общественный порядок. * 6', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 6 3.6 УК')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' УК 3.7 Дача ложной информации МЮ * 4', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 4 УК 3.7')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' УК 4.2 Грабеж, то есть открытое хищение чужого имущество способом, не представляющим опасности для жизни и здоровья. * 2', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 2 4.2 УК')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' УК  4.4 Неправомерное завладение автомобилем или иным транспортным средством без цели хищения. * 2', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 2 4.4 УК')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' 4.5 Неправомерное завладение автомобилем или иным транспортным средством с целью хищения или получения материальной прибыли. * 3', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 3 4.5 УК')
                    end)
                end
            end

            if imgui.CollapsingHeader(faicons('keyboard') .. u8' Преступления против правосудия') then 
    
                local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
                    if changed then
                            aidi = imgui.new.int(aidi[0])
                        end
                        
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.1 Вмешательство в какой бы то ни было форме в деятельность суда, следствия, ограничение прав граждан в целях воспрепятствования осуществлению правосудия. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' ')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.2 Угроза, а равно посягательство на жизнь судьи, или иного лица, участвующего в отправлении правосудия, защитника, эксперта, специалиста, судебного пристава, судебного исполнителя * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.2 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.3 Неуважение к суду, выразившееся в оскорблении участников судебного разбирательства или неуважении суда. * 1', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 1 8.3 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.4 Заведомо незаконное задержание, заключение под стражу или содержание под стражей. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.4 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК  8.5 Привлечение заведомо невиновного к уголовной или административной ответственности, включая арест. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.5 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.6 Подкуп лиц, участвующих в судебном процессе, в целях дачи ими ложного заключения или ложных показаний. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 8.6 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.7 Намеренное неисполнение вступивших в законную силу судебного акта, постановления лиц Правительства или выданного ордера а равно воспрепятствование их исполнению. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.7 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' 8.8 Сокрытие улик или уничтожение улик. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.8 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' 8.9 Скрытие с места преступления. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 8.9 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.10 Уклонение от расследования, задержания и суда, намеренные действия, которые направлены правонарушителем на уклонение от реального уголовного срока или другой уголовной ответственности * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 8.10 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.11 Дача ложных показаний во время проведение судебного процесса. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 8.11 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.12 За неадекватное поведение в зале суда. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.12 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.13 За разговоры в полный голос/выкрики в зале суда. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 8.13 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.14 За курение/распитие спиртных напитков в зале суда. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.14 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.15 За отказ от исполнения законных требований судьи во время судебного заседания. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 8.15 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.16 За попытку срыва судебного заседания. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.16 УК')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' УК 8.17 За публичные/завуалированные/прямые оскорбления в сторону судьи или других членов судебного заседания. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 8.17 УК')
            end)
        end
    end

    if imgui.CollapsingHeader(faicons('keyboard') .. u8' Соучастие в преступлении') then 
    
        local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
                end
                
if imgui.Button(faicons('USER_CHECK') .. u8' УК 11.1 Соучастие в преступлениях лёгкой тяжести. * 2', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 2 11.1 УК')
    end)
end
if imgui.Button(faicons('USER_CHECK') .. u8' 11.2 Соучастие в преступлениях тяжёлой тяжести. * 4', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 4 11.2 УК')
    end)
end
if imgui.Button(faicons('USER_CHECK') .. u8' УК 11.3 Соучастие в террористических актов. * 6', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 6 11.3 УК')
    end)
end
if imgui.Button(faicons('USER_CHECK') .. u8' УК 11.4 Соучастие в захвате или удержание лица в качестве заложников. * 6', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 6 11.4 УК')
    end)
end
end
end
imgui.EndChild()
end
imgui.End()
end)

imgui.OnFrame(function()
    return WinState[0]
end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(500,500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- отвечает за положение окна на экране
    imgui.SetNextWindowSize(imgui.ImVec2(1000, 480), imgui.Cond.Always) -- отвечает за размер окна
    imgui.Begin(faicons('user_police') .. u8' Police Helper', WinState)
    
    if imgui.Button(faicons('user_police') .. u8' Главная', imgui.ImVec2(160, 60)) then
        tab = 1
    end

    if imgui.Button(faicons('gears') .. u8' Шпаргалки', imgui.ImVec2(160, 60)) then
        tab = 6
    end

    if imgui.Button(faicons('keyboard') .. u8' Основное', imgui.ImVec2(160, 60)) then
        tab = 3
    end
    
    if imgui.Button(faicons('keyboard') .. u8' Рация Департамента', imgui.ImVec2(160, 60)) then
        tab = 5
    end
    
    if imgui.Button(faicons('user') .. u8' Команды хелпера', imgui.ImVec2(160, 60)) then
        tab = 7
    end 

    if imgui.Button(u8' Взаимодействие со скриптом', imgui.ImVec2(160, 60)) then
        tab = 4
    end 
     
imgui.SetCursorPos(imgui.ImVec2(175, 33))
if imgui.BeginChild('Name', imgui.ImVec2(-1, -1), true) then



        if tab == 1 then
        imgui.CenterText('Имя фамилия сотрудника: '..sampGetPlayerNickname(myID).. '[ ' ..myID.. ' ]') 
        imgui.CenterText('Состоит в организации: ' ..org)
        imgui.CenterText('Должность: ' ..rank)
        if imgui.Combo(u8'Тема', theme, new['const char*'][#themesList](themesList), #themesList) then 
			themes[theme[0]+1].func() 
			iniSave() 
		end
		if imgui.Combo(u8'Стиль', style, new['const char*'][#stylesList](stylesList), #stylesList) then 
			styles[style[0]+1].func() 
			iniSave() 
		end
		elseif tab == 6 then
				if imgui.CollapsingHeader(faicons('keyboard') .. u8' Тен-Коды') then
imgui.Text(u8'10-1 - Встреча всех офицеров на дежурстве')
imgui.Text(u8'10-3 - Радиомолчание (для срочных сообщений).')
imgui.Text(u8'10-4 - Принято.')
imgui.Text(u8'10-5 - Повторите последнее сообщение')
imgui.Text(u8'10-6 - Не принято/неверно/нет.')
imgui.Text(u8'10-7 - Ожидайте.')
imgui.Text(u8'10-8 - В настоящее время занят/не доступен.')
imgui.Text(u8'10-9 - В настоящее время занят/не доступен (детективы на ситуации).')
imgui.Text(u8'10-14 - Запрос транспортировки (включая локацию и цель транспортировки).')
imgui.Text(u8'10-15 - Подозреваемые арестованы (включая кол-во подозреваемых, локацию).')
imgui.Text(u8'10-18 - Требуется поддержка дополнительных юнитов.')
imgui.Text(u8'10-20 - Локация.')
imgui.Text(u8'10-21 - Сообщение о статусе и местонахождении, описание ситуации.')
imgui.Text(u8'10-22 - Направляйтесь в локация (обращение к конкретному офицеру).')
imgui.Text(u8'10-27 - Меняю маркировку патруля (включая старую и новую маркировку).')
imgui.Text(u8'10-30 - Дорожно-транспортное происшествие.')
imgui.Text(u8'10-40 - Большое скопление людей (4 и больше).')
imgui.Text(u8'10-41 - Нелегальная активность.')
imgui.Text(u8'10-46 - Провожу обыск.')
imgui.Text(u8'10-55 - Траффик стоп')
imgui.Text(u8'10-66 - Остановка повышенного риска (если известно, что подозреваемый в авто вооружен/совершил преступление. Если остановка произошла после погони).')
imgui.Text(u8'10-70 - Запрос поддержки (включая количество юнитов, код).')
imgui.Text(u8' 10-71 - Запрос медицинской поддержки.')
imgui.Text(u8'10-99 - Ситуация урегулирована.')
end
				if imgui.CollapsingHeader(faicons('keyboard') .. u8' Ситуационные коды') then
				
imgui.Text(u8'CODE 1 - Офицер (патруль) не ответил на запрос / поиск офицера (патруля).')
imgui.Text(u8'CODE 2 - Рутинный вызов, без сиреныч и спец. сигналов, полное соблюдение ПДД.')
imgui.Text(u8'CODE 3 - Срочный вызов, с сиреной и спец. сигналами, игнорирование...')
imgui.Text(u8'...отдельных пунктов ПДД согласно УК.')
imgui.Text(u8'CODE 4 - Не требуется помощь на ситуации / ситуация окончена.')
imgui.Text(u8'CODE 6 - Патрульная единица находится на ситуации, проводит следственные действия.')
imgui.Text(u8'CODE 7 - Запрос на убытие со службы во время начала свободного личного времени (обеденный перерыв и т.п.)...')
imgui.Text(u8'...При одобрении запроса служебный транспорт должен быть припаркован в соответствующих местах либо в управлении.')
imgui.Text(u8'CODE 20 - Когда событие имеет необычный характер и (или) может стать достоянием общественности через СМИ.')
imgui.Text(u8'CODE 37 - Сообщение об обнаружении угнанного транспортного средства с указанием направления и его описания.')
imgui.Text(u8'CODE 100 - Возможные пути отхода подозреваемого находятся под наблюдением патрульной единицы с указанием позиции.')
imgui.Text(u8'CODE ROBERT RIFLE - Офицер запрашивает винтовку или дополнительного офицера вооруженного винтовкой на свою позицию.')
imgui.Text(u8'CODE ROBERT SLUG - Офицер запрашивает ружьё (дробовик) или дополнительного офицера вооруженного...')
imgui.Text(u8'...ружьём (дробовиком) на свою позицию.')
imgui.Text(u8'CODE TOM - Офицер запрашивает дополнительного офицера вооруженного TASER-ом на свою позицию.')
end
		elseif tab == 7 then
        imgui.CenterText('/asu - кастом выдача розыска')
        imgui.CenterText('/on - Включение камеры')
        imgui.CenterText('/of - Выключение камеры')
        imgui.CenterText('/testyes - тест нарко в машине положительный')
        imgui.CenterText('/testno - тест нарко в машине отрицательный')
        imgui.CenterText('/testlabyes - тест нарко в лабаратории положительный')
        imgui.CenterText('/testlabno - тест нарко в млабаратории отрицательный')
        imgui.CenterText('/testweap - снятия отпечатков пальцев с оружия')
        imgui.CenterText('/doproson - включение оборудования в допросной')
        imgui.CenterText('/doprosof - выключение оборудования в допросной')
        imgui.CenterText('/unbomb - разминирование бомбы')
        imgui.CenterText('/pas - предоставление для полиции')
        imgui.CenterText('/pasf - предоставление для фбр')
        imgui.CenterText('/arm - армор с отыгровкой')
        imgui.CenterText('/drug - использование нарко под отыгровкой конфеты')
        imgui.CenterText('/miranda - миранда')
        imgui.CenterText('/probiv - пробив личности сотрудника')
        imgui.CenterText('/secretfbi - документ о неразглашение')
        imgui.CenterText('/fakepas - фейк пасспорт')
        imgui.CenterText('/delo - заведение дела по РП')
        elseif tab == 5 then
            if imgui.CollapsingHeader(u8"Настройки") then
    imgui.InputText(u8"Ваш тег", mytag, 255)
    ini.cfg.mytag = u8:decode(str(mytag))
    cfg_save()
    
    imgui.InputText(u8"Тег обращения", totag, 255)
    ini.cfg.totag = u8:decode(str(totag))
    cfg_save()
    
    if imgui.Button(u8"Закрытый канал") then
    zk = "з.к."
    ini.cfg.zk = u8:decode(str(zk))
    end
    
    if imgui.Button(u8"Открытый канал") then
    zk = "-"
    ini.cfg.zk = u8:decode(str(zk))
    end
    
    if zk == "-" then
    imgui.Text(u8"Выбран открытый канал")
    end
    
    if zk == "з.к." then
    imgui.Text(u8"Выбран закрытый канал")
    end
    end
    
    if imgui.CollapsingHeader(u8"На связь") then
    if imgui.Button(u8"Вызвать на связь") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: На связь!")
    end
    if imgui.Button(u8"Вызвать на связь [ Повтор ]") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: На связь! *Повторяя*")
    end
    end
    
    if imgui.CollapsingHeader(u8"Откат") then
    if imgui.Button(u8"Откатить сообщение") then
    sampSendChat("/d ["..ini.cfg.mytag.."] - [ALL]: Тех.Неполадки!")
    end
    end
    
    if imgui.CollapsingHeader(u8"Конец связи") then
    if imgui.Button(u8"Конец связи") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: Конец связи")
    end
    
    if imgui.Button(u8"Ответа не услышал") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: Ответа не услышал, конец связи")
    end
    end
	     
        elseif tab == 3 then

		if imgui.CollapsingHeader(faicons('keyboard') .. u8' Биндер Мл.состав') then 
		
		local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
                end
                
                                          if imgui.Button(faicons('USER_CHECK') .. u8' Обыск', imgui.ImVec2(-1, 25)) then 
                                lua_thread.create(function()
                             sampSendChat('/me нырнув руками в карманы вытянул оттуда белые перчатки и натянул их на руки')
            wait(1500)
            sampSendChat('/do Перчатки надеты.')
            wait(1500)
            sampSendChat('/me проводит руками по верхней части тела')
            wait(1500)
            sampSendChat('/me проверяет карманы, проводит руками по ногам')
            wait(1500)
            sampSendChat('/frisk '..aidi[0])
        end)
    end
    imgui.Separator()
if imgui.Button(faicons('USER_CHECK') .. u8' Повести за собой ', imgui.ImVec2(-1, 25)) then 
lua_thread.create(function()
            sampSendChat('/me заломил правую руку нарушителю')
            wait(1500)
            sampSendChat('/me ведет нарушителя за собой')
            wait(1500)
            sampSendChat('/gotome '..aidi[0])  
       end)	 
    end
  imgui.Separator()  
if imgui.Button(faicons('USER_CHECK') .. u8' Не вести за собой ', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('/me отпустил правую руку преступника')
            wait(1500)
            sampSendChat('/do Преступник свободен.')
            wait(1500)
            sampSendChat('/ungotome '..aidi[0])
        end)
    end
   imgui.Separator() 
if imgui.Button(faicons('USER_CHECK') .. u8' Надеть наручники', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
                            sampSendChat('/me одной рукой подозреваемого, другой достает из подсумка наручники ...')
                            wait(1500)
                            sampSendChat('/me ... и, скрестив руки подозреваемого нацепил их на него.')
                            wait(1500)
                            sampSendChat('/cuff '..aidi[0])
        end)
        end 
   imgui.Separator()     
if imgui.Button(faicons('USER_CHECK') .. u8' Снять наручники', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('/do Ключ от наручников в кармане.')
            wait(1500)
             sampSendChat('/me движением правой руки достал из кармана ключ и открыл наручники')
            wait(1500)
            sampSendChat('/do Преступник раскован.')
            wait(1500)
            sampSendChat('/uncuff '..aidi[0])
        end)
    end
imgui.Separator()
if imgui.Button(faicons('USER_CHECK') .. u8' Пурсуит', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
                            sampSendChat('/me положив руки на клавиатуру бортового компьютера, начал поиск по базе данных по имени')
                            wait(1000)
                            sampSendChat('/pursuit '..aidi[0])
                            wait(1000)
                            sampSendChat('/me найдя имя, проверил номер телефона и включил отслеживания по GPS')
        end)
    end
  imgui.Separator()  
     if imgui.Button(faicons('USER_CHECK') .. u8' Аррест', imgui.ImVec2(-1, 25)) then 
   lua_thread.create(function()
            sampSendChat('/do Рация вести в области груди.')
            wait(1500)
            sampSendChat('/me зажал кнопку на рации и доложил о доставке преступника')
            wait(1500)
            sampSendChat('/do Департамент: Принято, ожидайте двух офицеров.')
            wait(1500)
            sampSendChat('/do Из участка выходят 2 офицера, после забирают преступника.')
            sampSendChat('/arrest '..aidi[0])
        end)
    end
 imgui.Separator()   
if imgui.Button(faicons('USER_CHECK') .. u8' Остановка', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('/do Мегафон находится в бардачке.')
            wait(1500)
            sampSendChat('/me достал мегафон из бардачка, поднес его к рту и начал говорить')
            wait(1500)
            sampSendChat('/m Водитель транспортного средства, прижмитесь к обочине и заглушите двигатель...')
            wait(1500)
            sampSendChat('/m ...руки держите на руле. В случае неподчинения, по вам будет открыт огонь')
            wait(1500)
            sampSendChat('/me закончил говорить и убрал мегафон в бардачок')
        end)
    end
imgui.Separator()
if imgui.Button(faicons('USER_CHECK') .. u8' Миранда', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('Вы имеете право хранить молчание.')
            wait(2000)
            sampSendChat('Всё, что вы скажете, мы можем и будем использовать против вас в суде.')
            wait(2000)
            sampSendChat('Вы имеете право на адвоката и на один телефонный звонок.')
            wait(2000)
            sampSendChat('Если у вас нет адвоката, государство предоставит вам адвоката, увидеть которого вы сможете в зале суда.')
        end)
    end
  imgui.Separator()  
if imgui.Button(faicons('USER_CHECK') .. u8' Снять маску приступнику', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
            sampSendChat('/do На голове преступника одета балаклава')
            wait(1500)
            sampSendChat('/me сорвал маску с преступника и кинул ее на пол')
            sampSendChat('/unmask '..aidi[0])
        end)
    end
  imgui.Separator()  
if imgui.Button(faicons('USER_CHECK') .. u8' Предоставится по полицейски', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('Здравствуйте, сотрудник министерства юстиции штата, имя - '..sampGetPlayerNickname(myID))
            wait(1000)
            sampSendChat('/do Слева на груди жетон полицейского, справа - именная нашивка с фамилией.')
            wait(1000)
            sampSendChat('/showbadge '..aidi[0])
            wait(1000)
            sampSendChat('Прошу предьявить документ удостоверяющий вашу личность.')
        end)
     end
  imgui.Separator()
  if imgui.Button(faicons('USER_CHECK') .. u8' Предоставится по ФИБовски', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('Доброго времени суток, вас беспокоит сотрудник FBI.')
        wait(1000)
        sampSendChat('/do На поясе жетон FBI.')
        wait(1000)
        sampSendChat('Будьте добры предоставить ваши документики пожалуйста, паспорт')
        end)
    end
end
        if imgui.CollapsingHeader(faicons('keyboard') .. u8' Биндер руководства') then

    local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
        if changed then
                aidi = imgui.new.int(aidi[0])
        end

      if imgui.Button(faicons('USER_CHECK') .. u8' Выдать выговор(Н.У)', imgui.ImVec2(-1, 25)) then
                    lua_thread.create(function()
                        sampSendChat('/do На поясе закреплен КПК.')
                        wait(1000)
                        sampSendChat('/me снимает КПК с пояса и нажатием кнопки включает его.')
                        wait(1500)
                        sampSendChat('/me заходит в базу сотрудников и выбирает нужного,после чего нажимает на кнопку выдачи выговора.')
                        wait(1500)
                        sampSendChat('/me выключает КПК и вешает обратно на пояс.')
                        sampSendChat('/fwarn '..aidi[0])
                    end)
                end
if imgui.Button(faicons('USER_CHECK') .. u8' Снять выговор', imgui.ImVec2(-1, 25)) then
                    lua_thread.create(function()
                        sampSendChat('/do На поясе закреплен КПК.')
                        wait(1000)
                        sampSendChat('/me снимает КПК с пояса и нажатием кнопки включает его.')
                        wait(1500)
                        sampSendChat('/me заходит в базу сотрудников и выбирает нужного,после чего нажимает на кнопку снятия выговора.')
                        wait(1500)
                        sampSendChat('/me выключает КПК и вешает обратно на пояс.') 
                        sampSendChat('/unfwarn '..aidi[0])
    end)
end 
if imgui.Button(faicons('USER_CHECK') .. u8' Повысить(отыгровка без выдачи ранга)', imgui.ImVec2(-1, 25)) then
                    lua_thread.create(function()
                     sampSendChat('/do На поясе закреплен КПК.')
                     wait(1500)
                     sampSendChat('/me снимает КПК с пояса и нажатием кнопки включает его.')
                     wait(1500)
                     sampSendChat('/me заходит в базу сотрудников и вводит изменения, после чего вешает КПК обратно на пояс.')
                     wait(1500)
                     sampSendChat('/todo Новая форма в шкафчике*улыбаясь взглянув в сторону двери')
        end)
    end
end

		if imgui.CollapsingHeader(faicons('keyboard') .. u8' Собеседование') then

            local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
            end

		if imgui.Button(faicons('USER_CHECK') .. u8' Попросить документы', imgui.ImVec2(-1, 25)) then
		lua_thread.create(function()
		sampSendChat('Здравствуйте, если вы на собеседование.')
		wait(1500)
        sampSendChat('Пожалуйста приготовьте такие документы:')
        wait(1500)
        sampSendChat('Паспорт, мед.карту, лицензии.')
        wait(1500)
        sampSendChat('/b /showpass ' ..myID.. '  /showmc ' ..myID.. ' /showlic ' ..myID)
		end)
		end
		if imgui.Button(faicons('USER_CHECK') .. u8' Когда показали паспорт', imgui.ImVec2(-1, 25)) then
		lua_thread.create(function()
		sampSendChat('/me лёгким движением руки взял паспорт из рук человека')
		wait(1500)
        sampSendChat('/me изучил паспорт, затем вернул паспорт владельцу')
        sampSendChat('/offer')
		end)
		end
		if imgui.Button(faicons('USER_CHECK') .. u8' Когда показали Мед-Карту', imgui.ImVec2(-1, 25)) then
         lua_thread.create(function()
         sampSendChat('/me лёгким движением руки взял мед.карту из рук человека')
         wait(1500)
         sampSendChat('/me начал изучать мед.карту')
         wait(1500)
         sampSendChat('/me изучив мед.карту, отдал её владельцу')
         sampSendChat('/offer')
		end)
		end
		if imgui.Button(faicons('USER_CHECK') .. u8' Когда показали Лицензии', imgui.ImVec2(-1, 25)) then
		lua_thread.create(function()
		sampSendChat('/me лёгким движением руки взял мед.карту из рук человека')
		wait(1500)
        sampSendChat('/me начал изучать мед.карту')
        wait(1500)
        sampSendChat('/me изучив мед.карту, отдал её владельцу')
        sampSendChat('/offer')
        end)
        end
		if imgui.Button(faicons('USER_CHECK') .. u8' Человек прошел собеседование(инвайт)', imgui.ImVec2(-1, 25)) then 
		lua_thread.create(function()
            sampSendChat('Отлично! Вы к нам подходите, теперь вы наш сотрудник!')
            wait(1500)
		    sampSendChat('/do под стойкой находится рюкзак')
            wait(1500)
            sampSendChat('/do Форма в рюкзаке...')
            wait(1500)
            sampSendChat('/me сунул руку в рюкзак, после чего взял форму и бейджик в руки')
            wait(1500)
            sampSendChat('/me передаёт форму и бейджик')
            wait(1500)
            sampSendChat('/todo Идите переоденьтесь*указывая пальцем на дверь раздевалки')
            wait(1500)
            sampSendChat('/invite '..aidi[0])
        end)
    end
end

    if imgui.CollapsingHeader(faicons('user_police') .. u8' Биндер сотрудников FBI') then
    if imgui.Button(faicons('USER_CHECK') .. u8' Экспертиза наркотиков в машине положительная', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat("/me открыв багажник автомобиля достал набор с переносной лабараторией")
            wait(1500)
            sampSendChat("/me открыв его, взял из набора пробирку с этиловым спиртом")
            wait(1500)
            sampSendChat("/me насыпал в пробирку найденое вещество")
            wait(1500)
            sampSendChat ("/me добавил в пробирку тест Имуно-Хром-10")
            wait(1700)
            sampSendChat("/me резкими движениями взбалтывает пробирку")
            wait(1700)
            sampSendChat("/do Тест дал положительный результат, вещество является наркотиком.")
               end)
            end
            if imgui.Button(faicons('USER_CHECK') .. u8' Экспертиза наркотиков в машине отрицательная', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                    sampSendChat("/me открыв багажник автомобиля, достал набор перенасной лабаратории.")
                    wait(1500)
                    sampSendChat("/me открыв его, взял из набора пробирку с этиловым спиртом")
                    wait(1500)
                    sampSendChat("/me насыпал в пробирку найденое вещество")
                    wait(1500)
                    sampSendChat ("/me добавил в пробирку тест Имуно-Хром-10")
                    wait(1700)
                    sampSendChat("/me резкими движениями взбалтывает пробирку")
                    wait(1500)
                    sampSendChat("/do Тест дал отрицательный результат, вещество не является наркотиком. ")
                       end)
                    end
                    if imgui.Button(faicons('USER_CHECK') .. u8' Экспертиза наркотиков в лабаратории положительная', imgui.ImVec2(-1, 25)) then 
                        lua_thread.create(function()
                            sampSendChat("/do На столе стоит микроскоп, рядом с ним лежит небольшая книжечка и стоят весы.")
                                wait(1500)
                                sampSendChat("/do Во внутреннем кармане лежат изъятые неизвестные вещества.")
                                wait(1500)
                                sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
                                wait(1500)
                                sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
                                wait(1500)
                                sampSendChat("/me ..высыпал его содержимое на весы, стоящие на столе перед собой")
                                wait(1500)
                                sampSendChat("/do Весы отобразили вес высыпанной агентом субстанции.")
                                wait(1500)
                                sampSendChat("/me быстрыми движениями рук взял предметное стекло из-под микроскопа и насыпал на него пару миллиграмм..")
                                wait(1500)
                                sampSendChat("/me ..вещества с весов, после чего взял пипетку, наполнил её водой и капнул поверх вещества")
                                wait(1500)
                                sampSendChat("/me быстро положив пипетку обратно в колбочку, положил предметное стекло под микроскоп и начал изменять уровень..")
                                wait(1500)
                                sampSendChat("/me ..увеличения, смотря в экран микроскопа")
                                wait(1500)
                                sampSendChat("/me не отрывая взгляда от экрана микроскопа, взял со стола книгу и внимательно начал листать её страницы, ...")
                                wait(1500)
                                sampSendChat("/me ..сравнивая картинки в книге с изображением на экране микроскопа")
                                wait(1500)
                                sampSendChat("/do Агент внимательно изучил всю книгу и готов записать заключение, что вещетсво есть наркотиком.")
                                wait(1500)
                                sampSendChat("/me отстранившись от микроскопа, положил книгу на стол, после чего резкими движениями рук достал..")
                                wait(1500)
                                sampSendChat("/me ..из нагрудного кармана КПК и разблокировал его, зайдя в базу исследований написал там, что вещество - наркотик.")
                               end)
                            end
                            if imgui.Button(faicons('USER_CHECK') .. u8' Экспертиза наркотиков в лабаратории отрицательная', imgui.ImVec2(-1, 25)) then 
                                lua_thread.create(function()
                                    sampSendChat("/do На столе стоит микроскоп, рядом с ним лежит небольшая книжечка и стоят весы.")
                                        wait(1500)
                                        sampSendChat("/do Во внутреннем кармане лежат изъятые неизвестные вещества.")
                                        wait(1500)
                                        sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
                                        wait(1500)
                                        sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
                                        wait(1500)
                                        sampSendChat("/me ..высыпал его содержимое на весы, стоящие на столе перед собой")
                                        wait(1500)
                                        sampSendChat("/do Весы отобразили вес высыпанной агентом субстанции.")
                                        wait(1500)
                                        sampSendChat("/me быстрыми движениями рук взял предметное стекло из-под микроскопа и насыпал на него пару миллиграмм..")
                                        wait(1500)
                                        sampSendChat("/me ..вещества с весов, после чего взял пипетку, наполнил её водой и капнул поверх вещества")
                                        wait(1500)
                                        sampSendChat("/me быстро положив пипетку обратно в колбочку, положил предметное стекло под микроскоп и начал изменять уровень..")
                                        wait(1500)
                                        sampSendChat("/me ..увеличения, смотря в экран микроскопа")
                                        wait(1500)
                                        sampSendChat("/me не отрывая взгляда от экрана микроскопа, взял со стола книгу и внимательно начал листать её страницы, ...")
                                        wait(1500)
                                        sampSendChat("/me ..сравнивая картинки в книге с изображением на экране микроскопа")
                                        wait(1500)
                                        sampSendChat("/do Агент внимательно изучил всю книгу и готов записать заключение, что вещетсво не есть наркотиком.")
                                        wait(1500)
                                        sampSendChat("/me отстранившись от микроскопа, положил книгу на стол, после чего резкими движениями рук достал..")
                                        wait(1500)
                                        sampSendChat("/me ..из нагрудного кармана КПК и разблокировал его, зайдя в базу исследований написал там, что вещество - не наркотик.")
                                       end)
                                    end
                                    if imgui.Button(faicons('USER_CHECK') .. u8' Пробив инфы человека', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do На поясе висит личный КПК сотрудника.")
                                                wait(1500)
                                                sampSendChat("/me снял с пояса КПК , начал пробивать человека...")
                                                wait(1500)
                                                sampSendChat("/me ... по его лицу, ID-карте , бейджику и жетону")
                                                wait(1500)
                                                sampSendChat("/do На экране КПК высветилась вся информация о человеке.")
                                        end)
                                    end
                                    if imgui.Button(faicons('USER_CHECK') .. u8' Документ о неразглашении', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do На столе лежит документ: Документ о неразглашении деятельности ФБР.")
                                                wait(1500)
                                                sampSendChat("/do Рядом с документом аккуратно расположена ручка с золотой гравировкой ФБР.")
                                                wait(1500)
                                                sampSendChat("/do В документе написано: Я, (Имя / Фамилия), клянусь держать втайне то, что видел, вижу, и буду видеть.")
                                                wait(1500)
                                                sampSendChat("/do Ниже написано: Готов нести полную ответственность, и в случае своего неповиновения, ...")
                                                wait(1500)
                                                sampSendChat("/do ... готов быть арестованным и отстраненным от должности, при наличии таковой.")
                                                wait(1500)
                                                sampSendChat("/do Еще ниже написано: Дата: ; Подпись: .")
                                                wait(1500)
                                                sampSendChat("/me передал документ с ручкой человеку")
                                                wait(1500)
                                                sampSendChat("Подпишите пожалуйста документ и отдайте мне его, с ручкой только!")
                                        end)
                                    end
                                    if imgui.Button(faicons('USER_CHECK') .. u8' Разминирование бомбы', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do В руках был кейс сапёра, для разминирования бомбы.")
                                                wait(2500)
                                                sampSendChat("/me положив кейс на пол, быстрыми движениями рук открыл его и взял в правую руку кусачки")
                                                wait(2500)
                                                sampSendChat("/do В бомбе есть пять проводов: синий, жёлтый, красный, зелёный и голубой.")
                                                wait(2500)
                                                sampSendChat("/me внимательно изучая взрывное устройство, начал аккуратно искать провода, которые ведут к..")
                                                wait(2500)
                                                sampSendChat("/me .. самому механизму бомбы, параллельно левой рукой касаясь их")
                                                wait(2500)
                                                sampSendChat("/todo Этот теплый.*перерезая кусачками провод синего цвета")
                                                wait(2500)
                                                sampSendChat("/removebomb")
                                                wait(100)
                                                sampSendChat("/do Бомба обезврежена, таймер на ней остановился, а звуки таймера прекратились.")
                                                wait(2500)
                                                sampSendChat("/me быстрыми движениями рук положил кусачки в кейс, после чего взял бомбу в обе руки...")
                                                wait(2500)
                                                sampSendChat("/me ...и положил её в специальный отсек в кейсе сапёра, быстро закрывая его и взяв в левую руку")
                                        end)
                                    end

                                    local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
                                    if changed then
                                    aidi = imgui.new.int(aidi[0])
                                    end

                                    if imgui.Button(faicons('USER_CHECK') .. u8' Демоут(Г.Н.У)', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do В правом кармане брюк находится КПК.")
                                                wait(1500)
                                                sampSendChat("/me достал КПК из правого кармана, затем начал пробивать по базе данных сотрудника через лицо, ID карту и жетон")
                                                wait(1500)
                                                sampSendChat("/do На экране КПК появилась полная информация о сотруднике.")
                                                wait(1500)
                                                sampSendChat("/me нажал на кнопку Уволить из Гос. Организации")
                                                wait(1500)
                                                sampSendChat("/demoute "..aidi[0].." Г.Н.У")
                                                wait(1500)
                                                sampSendChat("/do "..sampGetPlayerNickname(aidi[0]).." был удален из списка Гос. Сотрудников.")
                                        end)
                                    end
                                end

 		if imgui.CollapsingHeader(faicons('keyboard') .. u8' Рп отыгровки паспорт и тд') then 
 
            local _, changed = imgui.InputInt(u8'Введите ID Игрока', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
            end

            if imgui.Button(faicons('USER_CHECK') .. u8' Показать паспорт', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                    sampSendChat("/do Сумка висит на груди.")
                    wait(1500)
                    sampSendChat("/me легким движением руки открыл сумку и нашел паспорт")
                    wait(1500)
                    sampSendChat("/me достал руку из сумки держа документ в правой руке")
                    wait(1500)
                    sampSendChat("/do Паспорт в правой руке.")
                    wait(1500)
                    sampSendChat("/todo Держите*передавая документ человеку")
                    sampSendChat('/showpass '..aidi[0])
                    end)
                    end
                             if imgui.Button(faicons('USER_CHECK') .. u8' Показать лицензии', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                sampSendChat("/do Сумка висит на груди.")
                wait(1500)
                sampSendChat("/do Папка с лицензиями находится в сумке.")
                    wait(1500)
                    sampSendChat("/me плавным движением правой руки нащупал папку")
                    wait(1500)
                    sampSendChat("/me вытащил папку, взял нужные лицензии")
                    wait(1500)
                    sampSendChat("/do Лицензии в правой руке.")
                    wait(1500)
                    sampSendChat("/me передал документы")
                    sampSendChat('/showlic '..aidi[0])
                    end)
                    end
                             if imgui.Button(faicons('USER_CHECK') .. u8' Показать навыки', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                sampSendChat("/do Сумка висит на груди.")
                wait(1500)
                sampSendChat("/do Нужные документы с навыками и талантами в правом кармашке сумки.")
                    wait(1500)
                    sampSendChat("/me открыв нужный отсек сумки, вытащил оттуда бумажку")
                    wait(1500)
                    sampSendChat("/do Документ в руке.")
                    wait(1500)
                    sampSendChat("/do На бумаге написано 'Мои навыки'.")
                    wait(1500)
                    sampSendChat("/me передал листочек с надписью человеку")
                    sampSendChat('/showskills '..aidi[0])
                    end)
                    end
                             if imgui.Button(faicons('USER_CHECK') .. u8' Показать Мед. карту', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()	
                sampSendChat("/do Сумка висит на груди.")
                wait(1500)
                sampSendChat("/do В сумке мед. карта.")
                    wait(1500)
                    sampSendChat("/me открыв сумку, нырнул в нее правой рукой")
                    wait(1500)
                    sampSendChat("/me спустя некоторое время нащупав документ, достал его")
                    wait(1500)
                    sampSendChat("/do Мед. карта в правой руке.")
                    wait(1500)
                    sampSendChat("/me передал мед. карту человеку напротив")
                    sampSendChat('/showmc '..aidi[0])
                    end)
                    end
                    end
                    
        elseif tab == 4 then
        
        if imgui.Button(u8'Перезагрузить Скрипт') then
				lua_thread.create(function() wait(5) thisScript():reload() end)
				imgui.ShowCursor = false
			end
				if imgui.IsItemHovered() then imgui.SetTooltip(u8'Кликните ЛКМ, чтобы перезагрузить скрипт')  end -- для перезагрузки
			imgui.SameLine()
			if imgui.Button(u8'Выгрузить Скрипт') then
				lua_thread.create(function() wait(1) thisScript():unload() end)
				imgui.ShowCursor = false
			end
            if imgui.update.needupdate then
                local centered_x = (imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Обновиться").x) / 2
                imgui.SetCursorPosX(centered_x)
                if imgui.Button(u8"Обновиться") then
                    local response = request.get("https://raw.githubusercontent.com/makson4ck/MVD-Helper/main/MVD_Helper.lua")
                         if response.status_code == 200 then
                            local file = io.open(thisScript().filename, "wb")
                               if file then
                                   file:write(response.text)
                                   file:close()
                                   thisScript():reload()
                              else
                                  sampAddChatMessage("Упс, ошибочка, сообщи автору скрипта, оно в настройках", -1)
                             end
                      end
                end
            else
                local centered_x = (imgui.GetWindowWidth() - imgui.CalcTextSize(u8"Проверить обновление").x) / 2
                imgui.SetCursorPosX(centered_x)
                    if imgui.Button(u8"Проверить обновление") then
                        local response = request.get("https://raw.githubusercontent.com/makson4ck/MVD-Helper/main/update.json")
                            if response.status_code == 200 then
                                local data = json.decode(response.text) -- Предполагаем, что есть библиотека JSON
                                    if data and data.version and data.version ~= imgui.update.version then
                                        imgui.update.needupdate = true
                                        imgui.update.updateText = u8"Найдено обновление на версию " .. data.version
                                        else
                                        imgui.update.updateText = u8"Обновлений не найдено"
                                    end
                            else
                            imgui.update.updateText = u8"Ошибка " .. tostring(response.status_code)
                            end
                        end
                    end
        if imgui.update.updateText ~= "" then
            imgui.Separator()
            local updateTextWidth = imgui.CalcTextSize(imgui.update.updateText).x
            local centered_x = (imgui.GetWindowWidth() - updateTextWidth) / 2
            imgui.SetCursorPosX(centered_x)
            imgui.Text(imgui.update.updateText)
            imgui.Separator()
        end
        if imgui.Button(u8"Связь с разработчиком") then
            gta._Z12AND_OpenLinkPKc("https://t.me/makson4ck")
     end
    end
        imgui.EndChild()
        end
    imgui.End()
end)

function iniSave()
	ini.cfg.theme = theme[0]
	ini.cfg.style = style[0]
	inicfg.save(ini, iniFile)
end

styles = {
	{
		name = u8'Строгий',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			style.WindowRounding = 0
			style.ChildRounding = 0
			style.FrameRounding = 0
			style.ItemSpacing = imgui.ImVec2(3.0, 3.0)
			style.ItemInnerSpacing = imgui.ImVec2(3.0, 3.0)
			style.FramePadding = imgui.ImVec2(4.0, 3.0)
			style.IndentSpacing = 21
			style.ScrollbarSize = 10.0
			style.ScrollbarRounding = 0
			style.GrabMinSize = 17.0
			style.GrabRounding = 0
			style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
			style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
		end
	},
	{
		name = u8'Мягкий',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			style.WindowRounding = 10
			style.ChildRounding = 10
			style.FrameRounding = 6.0
			style.ItemSpacing = imgui.ImVec2(3.0, 3.0)
			style.ItemInnerSpacing = imgui.ImVec2(3.0, 3.0)
			style.FramePadding = imgui.ImVec2(4.0, 3.0)
			style.IndentSpacing = 21
			style.ScrollbarSize = 10.0
			style.ScrollbarRounding = 13
			style.GrabMinSize = 17.0
			style.GrabRounding = 16.0
			style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
			style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
		end
	}
}

themes = {
	{
		name = u8'Зелёная',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				   = ImVec4(0.90, 0.90, 0.90, 1.00)
			colors[clr.TextDisabled]		   = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.WindowBg]			   = ImVec4(0.08, 0.08, 0.08, 1.00)
			colors[clr.ChildBg]		  = ImVec4(0.10, 0.10, 0.10, 0.40)
			colors[clr.PopupBg]				= ImVec4(0.08, 0.08, 0.08, 1.00)
			colors[clr.Border]				 = ImVec4(0.70, 0.70, 0.70, 0.40)
			colors[clr.BorderShadow]		   = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]				= ImVec4(0.15, 0.15, 0.15, 1.00)
			colors[clr.FrameBgHovered]		 = ImVec4(0.19, 0.19, 0.19, 0.71)
			colors[clr.FrameBgActive]		  = ImVec4(0.34, 0.34, 0.34, 0.79)
			colors[clr.TitleBg]				= ImVec4(0.00, 0.69, 0.33, 0.80)
			colors[clr.TitleBgActive]		  = ImVec4(0.00, 0.74, 0.36, 1.00)
			colors[clr.TitleBgCollapsed]	   = ImVec4(0.00, 0.69, 0.33, 0.50)
			colors[clr.MenuBarBg]			  = ImVec4(0.00, 0.80, 0.38, 1.00)
			colors[clr.ScrollbarBg]			= ImVec4(0.16, 0.16, 0.16, 1.00)
			colors[clr.ScrollbarGrab]		  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
			colors[clr.ScrollbarGrabActive]	= ImVec4(0.00, 1.00, 0.48, 1.00)
			colors[clr.CheckMark]			  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.SliderGrab]			 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.SliderGrabActive]	   = ImVec4(0.00, 0.77, 0.37, 1.00)
			colors[clr.Button]				 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.ButtonHovered]		  = ImVec4(0.00, 0.82, 0.39, 1.00)
			colors[clr.ButtonActive]		   = ImVec4(0.00, 0.87, 0.42, 1.00)
			colors[clr.Header]				 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.HeaderHovered]		  = ImVec4(0.00, 0.76, 0.37, 0.57)
			colors[clr.HeaderActive]		   = ImVec4(0.00, 0.88, 0.42, 0.89)
			colors[clr.Separator]			  = ImVec4(1.00, 1.00, 1.00, 0.40)
			colors[clr.SeparatorHovered]	   = ImVec4(1.00, 1.00, 1.00, 0.60)
			colors[clr.SeparatorActive]		= ImVec4(1.00, 1.00, 1.00, 0.80)
			colors[clr.ResizeGrip]			 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.ResizeGripHovered]	  = ImVec4(0.00, 0.76, 0.37, 1.00)
			colors[clr.ResizeGripActive]	   = ImVec4(0.00, 0.86, 0.41, 1.00)
			colors[clr.PlotLines]			  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.PlotLinesHovered]	   = ImVec4(0.00, 0.74, 0.36, 1.00)
			colors[clr.PlotHistogram]		  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
			colors[clr.TextSelectedBg]		 = ImVec4(0.00, 0.69, 0.33, 0.72)
			colors[clr.ModalWindowDimBg]   = ImVec4(0.17, 0.17, 0.17, 0.48)
		end
	},
	{
		name = u8'Красная',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				   = ImVec4(0.95, 0.96, 0.98, 1.00)
			colors[clr.TextDisabled]		   = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.WindowBg]			   = ImVec4(0.14, 0.14, 0.14, 1.00)
			colors[clr.ChildBg]		  = ImVec4(0.12, 0.12, 0.12, 0.40)
			colors[clr.PopupBg]				= ImVec4(0.08, 0.08, 0.08, 0.94)
			colors[clr.Border]				 = ImVec4(0.14, 0.14, 0.14, 1.00)
			colors[clr.BorderShadow]		   = ImVec4(1.00, 1.00, 1.00, 0.00)
			colors[clr.FrameBg]				= ImVec4(0.22, 0.22, 0.22, 1.00)
			colors[clr.FrameBgHovered]		 = ImVec4(0.18, 0.18, 0.18, 1.00)
			colors[clr.FrameBgActive]		  = ImVec4(0.09, 0.12, 0.14, 1.00)
			colors[clr.TitleBg]				= ImVec4(0.14, 0.14, 0.14, 0.81)
			colors[clr.TitleBgActive]		  = ImVec4(0.14, 0.14, 0.14, 1.00)
			colors[clr.TitleBgCollapsed]	   = ImVec4(0.00, 0.00, 0.00, 0.51)
			colors[clr.MenuBarBg]			  = ImVec4(0.20, 0.20, 0.20, 1.00)
			colors[clr.ScrollbarBg]			= ImVec4(0.02, 0.02, 0.02, 0.39)
			colors[clr.ScrollbarGrab]		  = ImVec4(0.36, 0.36, 0.36, 1.00)
			colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00)
			colors[clr.ScrollbarGrabActive]	= ImVec4(0.24, 0.24, 0.24, 1.00)
			colors[clr.CheckMark]			  = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.SliderGrab]			 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.SliderGrabActive]	   = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.Button]				 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.ButtonHovered]		  = ImVec4(1.00, 0.39, 0.39, 1.00)
			colors[clr.ButtonActive]		   = ImVec4(1.00, 0.21, 0.21, 1.00)
			colors[clr.Header]				 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.HeaderHovered]		  = ImVec4(1.00, 0.39, 0.39, 1.00)
			colors[clr.HeaderActive]		   = ImVec4(1.00, 0.21, 0.21, 1.00)
			colors[clr.ResizeGrip]			 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.ResizeGripHovered]	  = ImVec4(1.00, 0.39, 0.39, 1.00)
			colors[clr.PlotLines]			  = ImVec4(0.61, 0.61, 0.61, 1.00)
			colors[clr.PlotLinesHovered]	   = ImVec4(1.00, 0.43, 0.35, 1.00)
			colors[clr.PlotHistogram]		  = ImVec4(1.00, 0.21, 0.21, 1.00)
			colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00)
			colors[clr.TextSelectedBg]		 = ImVec4(1.00, 0.32, 0.32, 1.00)
			colors[clr.ModalWindowDimBg]   = ImVec4(0.26, 0.26, 0.26, 0.60)
		end
	},
	{
		name = u8'Пурпурная',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.FrameBg]				= ImVec4(0.46, 0.11, 0.29, 1.00)
			colors[clr.FrameBgHovered]		 = ImVec4(0.69, 0.16, 0.43, 1.00)
			colors[clr.FrameBgActive]		  = ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.TitleBg]				= ImVec4(0.00, 0.00, 0.00, 1.00)
			colors[clr.TitleBgActive]		  = ImVec4(0.61, 0.16, 0.39, 1.00)
			colors[clr.TitleBgCollapsed]	   = ImVec4(0.00, 0.00, 0.00, 0.51)
			colors[clr.CheckMark]			  = ImVec4(0.94, 0.30, 0.63, 1.00)
			colors[clr.SliderGrab]			 = ImVec4(0.85, 0.11, 0.49, 1.00)
			colors[clr.SliderGrabActive]	   = ImVec4(0.89, 0.24, 0.58, 1.00)
			colors[clr.Button]				 = ImVec4(0.46, 0.11, 0.29, 1.00)
			colors[clr.ButtonHovered]		  = ImVec4(0.69, 0.17, 0.43, 1.00)
			colors[clr.ButtonActive]		   = ImVec4(0.59, 0.10, 0.35, 1.00)
			colors[clr.Header]				 = ImVec4(0.46, 0.11, 0.29, 1.00)
			colors[clr.HeaderHovered]		  = ImVec4(0.69, 0.16, 0.43, 1.00)
			colors[clr.HeaderActive]		   = ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.Separator]			  = ImVec4(0.69, 0.16, 0.43, 1.00)
			colors[clr.SeparatorHovered]	   = ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.SeparatorActive]		= ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.ResizeGrip]			 = ImVec4(0.46, 0.11, 0.29, 0.70)
			colors[clr.ResizeGripHovered]	  = ImVec4(0.69, 0.16, 0.43, 0.67)
			colors[clr.ResizeGripActive]	   = ImVec4(0.70, 0.13, 0.42, 1.00)
			colors[clr.TextSelectedBg]		 = ImVec4(1.00, 0.78, 0.90, 0.35)
			colors[clr.Text]				   = ImVec4(1.00, 1.00, 1.00, 1.00)
			colors[clr.TextDisabled]		   = ImVec4(0.60, 0.19, 0.40, 1.00)
			colors[clr.WindowBg]			   = ImVec4(0.06, 0.06, 0.06, 0.94)
			colors[clr.ChildBg]		  = ImVec4(0.00, 0.00, 0.00, 0.40)
			colors[clr.PopupBg]				= ImVec4(0.08, 0.08, 0.08, 0.94)
			colors[clr.Border]				 = ImVec4(0.49, 0.14, 0.31, 1.00)
			colors[clr.BorderShadow]		   = ImVec4(0.49, 0.14, 0.31, 0.00)
			colors[clr.MenuBarBg]			  = ImVec4(0.15, 0.15, 0.15, 1.00)
			colors[clr.ScrollbarBg]			= ImVec4(0.02, 0.02, 0.02, 0.53)
			colors[clr.ScrollbarGrab]		  = ImVec4(0.31, 0.31, 0.31, 1.00)
			colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
			colors[clr.ScrollbarGrabActive]	= ImVec4(0.51, 0.51, 0.51, 1.00)
			colors[clr.ModalWindowDimBg]   = ImVec4(0.80, 0.80, 0.80, 0.35)
		end
	},
	{
		name = u8'Фиолетовая',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.WindowBg]			  = ImVec4(0.14, 0.12, 0.16, 1.00)
			colors[clr.ChildBg]		 = ImVec4(0.30, 0.20, 0.39, 0.40)
			colors[clr.PopupBg]			   = ImVec4(0.05, 0.05, 0.10, 0.90)
			colors[clr.Border]				= ImVec4(0.89, 0.85, 0.92, 0.30)
			colors[clr.BorderShadow]		  = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]			   = ImVec4(0.30, 0.20, 0.39, 1.00)
			colors[clr.FrameBgHovered]		= ImVec4(0.41, 0.19, 0.63, 0.68)
			colors[clr.FrameBgActive]		 = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.TitleBg]			   = ImVec4(0.41, 0.19, 0.63, 0.45)
			colors[clr.TitleBgCollapsed]	  = ImVec4(0.41, 0.19, 0.63, 0.35)
			colors[clr.TitleBgActive]		 = ImVec4(0.41, 0.19, 0.63, 0.78)
			colors[clr.MenuBarBg]			 = ImVec4(0.30, 0.20, 0.39, 0.57)
			colors[clr.ScrollbarBg]		   = ImVec4(0.30, 0.20, 0.39, 1.00)
			colors[clr.ScrollbarGrab]		 = ImVec4(0.41, 0.19, 0.63, 0.31)
			colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78)
			colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.CheckMark]			 = ImVec4(0.56, 0.61, 1.00, 1.00)
			colors[clr.SliderGrab]			= ImVec4(0.41, 0.19, 0.63, 0.24)
			colors[clr.SliderGrabActive]	  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.Button]				= ImVec4(0.41, 0.19, 0.63, 0.44)
			colors[clr.ButtonHovered]		 = ImVec4(0.41, 0.19, 0.63, 0.86)
			colors[clr.ButtonActive]		  = ImVec4(0.64, 0.33, 0.94, 1.00)
			colors[clr.Header]				= ImVec4(0.41, 0.19, 0.63, 0.76)
			colors[clr.HeaderHovered]		 = ImVec4(0.41, 0.19, 0.63, 0.86)
			colors[clr.HeaderActive]		  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.ResizeGrip]			= ImVec4(0.41, 0.19, 0.63, 0.20)
			colors[clr.ResizeGripHovered]	 = ImVec4(0.41, 0.19, 0.63, 0.78)
			colors[clr.ResizeGripActive]	  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.PlotLines]			 = ImVec4(0.89, 0.85, 0.92, 0.63)
			colors[clr.PlotLinesHovered]	  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.PlotHistogram]		 = ImVec4(0.89, 0.85, 0.92, 0.63)
			colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.TextSelectedBg]		= ImVec4(0.41, 0.19, 0.63, 0.43)
			colors[clr.TextDisabled]		  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.ModalWindowDimBg]  = ImVec4(0.20, 0.20, 0.20, 0.35)
		end
	},
	{
		name = u8'Вишнёвая',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				  = ImVec4(0.86, 0.93, 0.89, 0.78)
			colors[clr.TextDisabled]		  = ImVec4(0.71, 0.22, 0.27, 1.00)
			colors[clr.WindowBg]			  = ImVec4(0.13, 0.14, 0.17, 1.00)
			colors[clr.ChildBg]		 = ImVec4(0.20, 0.22, 0.27, 0.58)
			colors[clr.PopupBg]			   = ImVec4(0.20, 0.22, 0.27, 0.90)
			colors[clr.Border]				= ImVec4(0.31, 0.31, 1.00, 0.00)
			colors[clr.BorderShadow]		  = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]			   = ImVec4(0.20, 0.22, 0.27, 1.00)
			colors[clr.FrameBgHovered]		= ImVec4(0.46, 0.20, 0.30, 0.78)
			colors[clr.FrameBgActive]		 = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.TitleBg]			   = ImVec4(0.23, 0.20, 0.27, 1.00)
			colors[clr.TitleBgActive]		 = ImVec4(0.50, 0.08, 0.26, 1.00)
			colors[clr.TitleBgCollapsed]	  = ImVec4(0.20, 0.20, 0.27, 0.75)
			colors[clr.MenuBarBg]			 = ImVec4(0.20, 0.22, 0.27, 0.47)
			colors[clr.ScrollbarBg]		   = ImVec4(0.20, 0.22, 0.27, 1.00)
			colors[clr.ScrollbarGrab]		 = ImVec4(0.09, 0.15, 0.10, 1.00)
			colors[clr.ScrollbarGrabHovered]  = ImVec4(0.46, 0.20, 0.30, 0.78)
			colors[clr.ScrollbarGrabActive]   = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.CheckMark]			 = ImVec4(0.71, 0.22, 0.27, 1.00)
			colors[clr.SliderGrab]			= ImVec4(0.47, 0.77, 0.83, 0.14)
			colors[clr.SliderGrabActive]	  = ImVec4(0.71, 0.22, 0.27, 1.00)
			colors[clr.Button]				= ImVec4(0.47, 0.77, 0.83, 0.14)
			colors[clr.ButtonHovered]		 = ImVec4(0.46, 0.20, 0.30, 0.86)
			colors[clr.ButtonActive]		  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.Header]				= ImVec4(0.46, 0.20, 0.30, 0.76)
			colors[clr.HeaderHovered]		 = ImVec4(0.46, 0.20, 0.30, 0.86)
			colors[clr.HeaderActive]		  = ImVec4(0.50, 0.08, 0.26, 1.00)
			colors[clr.ResizeGrip]			= ImVec4(0.47, 0.77, 0.83, 0.04)
			colors[clr.ResizeGripHovered]	 = ImVec4(0.46, 0.20, 0.30, 0.78)
			colors[clr.ResizeGripActive]	  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.PlotLines]			 = ImVec4(0.86, 0.93, 0.89, 0.63)
			colors[clr.PlotLinesHovered]	  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.PlotHistogram]		 = ImVec4(0.86, 0.93, 0.89, 0.63)
			colors[clr.PlotHistogramHovered]  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.TextSelectedBg]		= ImVec4(0.46, 0.20, 0.30, 0.43)
			colors[clr.ModalWindowDimBg]  = ImVec4(0.20, 0.22, 0.27, 0.73)
		end
	},
	{
		name = u8'Жёлтая',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				 = ImVec4(0.92, 0.92, 0.92, 1.00)
			colors[clr.TextDisabled]		 = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.WindowBg]			 = ImVec4(0.06, 0.06, 0.06, 1.00)
			colors[clr.ChildBg]		= ImVec4(0.00, 0.00, 0.00, 0.40)
			colors[clr.PopupBg]			  = ImVec4(0.08, 0.08, 0.08, 0.94)
			colors[clr.Border]			   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.BorderShadow]		 = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]			  = ImVec4(0.11, 0.11, 0.11, 1.00)
			colors[clr.FrameBgHovered]	   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.FrameBgActive]		= ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.TitleBg]			  = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.TitleBgActive]		= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.TitleBgCollapsed]	 = ImVec4(0.00, 0.00, 0.00, 0.51)
			colors[clr.MenuBarBg]			= ImVec4(0.11, 0.11, 0.11, 1.00)
			colors[clr.ScrollbarBg]		  = ImVec4(0.06, 0.06, 0.06, 0.53)
			colors[clr.ScrollbarGrab]		= ImVec4(0.21, 0.21, 0.21, 1.00)
			colors[clr.ScrollbarGrabHovered] = ImVec4(0.47, 0.47, 0.47, 1.00)
			colors[clr.ScrollbarGrabActive]  = ImVec4(0.81, 0.83, 0.81, 1.00)
			colors[clr.CheckMark]			= ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.SliderGrab]		   = ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.SliderGrabActive]	 = ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.Button]			   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.ButtonHovered]		= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.ButtonActive]		 = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.Header]			   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.HeaderHovered]		= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.HeaderActive]		 = ImVec4(0.93, 0.65, 0.14, 1.00)
			colors[clr.Separator]			= ImVec4(0.21, 0.21, 0.21, 1.00)
			colors[clr.SeparatorHovered]	 = ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.SeparatorActive]	  = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.ResizeGrip]		   = ImVec4(0.21, 0.21, 0.21, 1.00)
			colors[clr.ResizeGripHovered]	= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.ResizeGripActive]	 = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.PlotLines]			= ImVec4(0.61, 0.61, 0.61, 1.00)
			colors[clr.PlotLinesHovered]	 = ImVec4(1.00, 0.43, 0.35, 1.00)
			colors[clr.PlotHistogram]		= ImVec4(0.90, 0.70, 0.00, 1.00)
			colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
			colors[clr.TextSelectedBg]	   = ImVec4(0.26, 0.59, 0.98, 0.35)
			colors[clr.ModalWindowDimBg] = ImVec4(0.80, 0.80, 0.80, 0.35)
		end
	},
	{
		name = u8'Темная',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
  style.WindowPadding = imgui.ImVec2(5, 5)
  style.FramePadding = imgui.ImVec2(10, 10)
  style.ItemSpacing = imgui.ImVec2(10, 10)
  style.ItemInnerSpacing = imgui.ImVec2(5, 5)
  style.TouchExtraPadding = imgui.ImVec2(5 * MONET_DPI_SCALE, 5 * MONET_DPI_SCALE)
  style.IndentSpacing = 0
  style.ScrollbarSize = 20 * MONET_DPI_SCALE
  style.GrabMinSize = 20 * MONET_DPI_SCALE

  --==[ BORDER ]==--
  style.WindowBorderSize = 1
  style.ChildBorderSize = 1
  style.PopupBorderSize = 1
  style.FrameBorderSize = 1
  style.TabBorderSize = 1

  --==[ ROUNDING ]==--
  style.WindowRounding = 5
  style.ChildRounding = 5
  style.FrameRounding = 5
  style.PopupRounding = 5
  style.ScrollbarRounding = 5
  style.GrabRounding = 5
  style.TabRounding = 5

  --==[ ALIGN ]==--
  style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
  style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
  style.SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
  style.Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
  style.Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
  style.Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
  style.Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
  style.Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
  style.Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, 0.54)
  style.Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
  style.Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
  style.Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
  style.Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
  style.Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
  style.Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, 1.00)
  style.Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
  style.Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.Button]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
  style.Colors[imgui.Col.Header]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, 1.00)
  style.Colors[imgui.Col.Separator]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
  style.Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
  style.Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.95)
  style.Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
  style.Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
  style.Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
  style.Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
  style.Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
  style.Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
  style.Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
  style.Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
  style.Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
  style.Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
  style.Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
  style.Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
  style.Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
  style.Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		end
	},
	{
		name = u8'Кровавая',
		func = function()
    imgui.SwitchContext()
    local ImVec4 = imgui.ImVec4
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 10
    imgui.GetStyle().WindowBorderSize = 1
    imgui.GetStyle().ChildBorderSize = 1

    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1
    imgui.GetStyle().WindowRounding = 8
    imgui.GetStyle().ChildRounding = 8
    imgui.GetStyle().FrameRounding = 8
    imgui.GetStyle().PopupRounding = 8
    imgui.GetStyle().ScrollbarRounding = 8
    imgui.GetStyle().GrabRounding = 8
    imgui.GetStyle().TabRounding = 8

    imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 0.43);
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 0.90);
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(1.00, 1.00, 1.00, 0.07);
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.00, 0.00, 0.00, 0.94);
    imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(1.00, 1.00, 1.00, 0.00);
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(1.00, 0.00, 0.00, 0.32);
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 0.09);
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(1.00, 1.00, 1.00, 0.17);
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(1.00, 1.00, 1.00, 0.26);
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.19, 0.00, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.46, 0.00, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.20, 0.00, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.03, 0.03, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.19, 0.00, 0.00, 0.53);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(1.00, 1.00, 1.00, 0.11);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(1.00, 1.00, 1.00, 0.24);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(1.00, 1.00, 1.00, 0.35);
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(1.00, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(1.00, 0.00, 0.00, 0.34);
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(1.00, 0.00, 0.00, 0.51);
    imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(1.00, 0.00, 0.00, 0.19);
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(1.00, 0.00, 0.00, 0.31);
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(1.00, 0.00, 0.00, 0.46);
    imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(1.00, 0.00, 0.00, 0.19);
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(1.00, 0.00, 0.00, 0.30);
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(1.00, 0.00, 0.00, 0.50);
    imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(1.00, 0.00, 0.00, 0.41);
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.78);
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.19, 0.00, 0.00, 0.53);
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.43, 0.00, 0.00, 0.75);
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.53, 0.00, 0.00, 0.95);
    imgui.GetStyle().Colors[imgui.Col.Tab]                    = ImVec4(1.00, 0.00, 0.00, 0.27);
    imgui.GetStyle().Colors[imgui.Col.TabHovered]             = ImVec4(1.00, 0.00, 0.00, 0.48);
    imgui.GetStyle().Colors[imgui.Col.TabActive]              = ImVec4(1.00, 0.00, 0.00, 0.60);
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = ImVec4(1.00, 0.00, 0.00, 0.27);
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = ImVec4(1.00, 0.00, 0.00, 0.54);
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(1.00, 1.00, 1.00, 0.35);
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = ImVec4(1.00, 1.00, 0.00, 0.90);
    imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = ImVec4(0.26, 0.59, 0.98, 1.00);
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = ImVec4(1.00, 1.00, 1.00, 0.70);
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = ImVec4(0.80, 0.80, 0.80, 0.20);
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = ImVec4(0.80, 0.80, 0.80, 0.35);
end
	},
	{
		name = u8'Синяя',
		func = function()
			local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(0.10, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        end
	},
	{
		name = u8'Красная',
		func = function()
			local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(1.00, 1.00, 1.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
            imgui.GetStyle().Colors[imgui.Col.Tab]                    = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.TabHovered]             = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabActive]              = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
        end
	},
}


function main() 
        sampRegisterChatCommand('mh', function()
        WinState[0] = not WinState[0]
        end)
        sampRegisterChatCommand('asu', function()
        Roz[0] = not Roz[0]
        end)
        sampRegisterChatCommand('sobes', function()
        sobes.FastAction[0] = not sobes.FastAction[0]
        end)
        sampRegisterChatCommand("fwarn", cmd_fwarn)
        sampRegisterChatCommand("showpass", cmd_showpass)
        sampRegisterChatCommand("showlic", cmd_showlic)
        sampRegisterChatCommand("showskill", cmd_showskill)
        sampRegisterChatCommand("showmc", cmd_showmc)
        sampRegisterChatCommand("pull", cmd_pull)
        sampRegisterChatCommand("invite", cmd_invite)
        sampRegisterChatCommand("uninvite", cmd_uninvite)
        sampRegisterChatCommand("cuff", cmd_cuff)
        sampRegisterChatCommand("uncuff", cmd_uncuff)
        sampRegisterChatCommand("gotome", cmd_gotome)
        sampRegisterChatCommand("ungotome", cmd_ungotome)
        sampRegisterChatCommand("frisk", cmd_frisk)
        sampRegisterChatCommand("pas", cmd_pas)
        sampRegisterChatCommand("pasf", cmd_pasf)
        sampRegisterChatCommand("mask", cmd_mask)
        sampRegisterChatCommand("arm", cmd_arm)
        sampRegisterChatCommand("drug", cmd_drug)
        sampRegisterChatCommand("arrest", cmd_arrest) 
        sampRegisterChatCommand("stop", cmd_stop) 
        sampRegisterChatCommand("giverank", cmd_giverank) 
        sampRegisterChatCommand("miranda", cmd_miranda) 
        sampRegisterChatCommand("on", cmd_bodyon) 
        sampRegisterChatCommand("of", cmd_bodyoff) 
        sampRegisterChatCommand("ticket", cmd_ticket)
        sampRegisterChatCommand("pursuit", cmd_pursuit)
        sampRegisterChatCommand("testno", cmd_drugtestno)
        sampRegisterChatCommand("testyes", cmd_drugtestyes)
        sampRegisterChatCommand("testlabyes", cmd_testlabyes)
        sampRegisterChatCommand("testlabno", cmd_testlabno)
        sampRegisterChatCommand("bribe", cmd_vzatka)
        sampRegisterChatCommand("unbomb", cmd_bomb)
        sampRegisterChatCommand("probiv", cmd_probiv)
        sampRegisterChatCommand("demoute", cmd_demoute)
        sampRegisterChatCommand("demoute", cmd_dismiss)
        sampRegisterChatCommand("cure", cmd_cure)
        sampRegisterChatCommand("find", cmd_find)
        sampRegisterChatCommand("incar", cmd_incar)
        sampRegisterChatCommand("eject", cmd_eject)
        sampRegisterChatCommand("time", cmd_time)
        sampRegisterChatCommand("fbisecret", cmd_secret_fbi)
        sampRegisterChatCommand("fakepas", cmd_fake_pas)
        sampRegisterChatCommand("doproson", cmd_dopros_on)
        sampRegisterChatCommand("doprosof", cmd_dopros_of)
        sampRegisterChatCommand("testweap", cmd_test_weap)
        sampRegisterChatCommand("delo", cmd_delo)
        sampRegisterChatCommand("spawncar", cmd_spawncar)
end

function cmd_spawncar()
	lua_thread.create(function()
		sampSendChat("/rb Внимание! Через 20 секунд будет спавн транспорта больницы.")
		wait(2000)
		sampSendChat("/rb Займите транспорт, иначе он будет заспавнен.")
		wait(18000)
		spawncar = true
		sampSendChat("/lmenu")
		wait(1000)
		spawncar = false
	end)
end

require("samp.events").onShowDialog = function(dialogid, style, title, button1, button2, text)
    if dialogid == 1214 and spawncar then -- спавн т/с
        sampSendDialogResponse(1214, 1, 3, 0)
        spawncar = false
        return false
    end
end

require("samp.events").onSendChat = function(text)
    if ini.cfg.rp_chat then
        text = text:sub(1, 1):rupper()..text:sub(2, #text)
         if not text:find('(.+)%.') and not text:find('(.+)%!') and not text:find('(.+)%?') then             text = text .. '.'
        end
end
return {text}
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solmyID'), 14, config, iconRanges)
end)

function cfg_save()
inicfg.save(ini, "Auto Tag MH.ini")
end

function cmd_d(data)
if data == "" then
sampAddChatMessage("Введите сообщение для отправки!", -1)
else
sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: "..data.."")
end
end

function cmd_incar(arg)
    lua_thread.create(function ()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/todo Голову аккуратнее!*сажая преступника в машину, открывая дверь, пригибая голову преступника")
        wait(1500)
        sampSendChat("/incar "..arg1.." "..arg2)
    else
        sampAddChatMessage("Введите айди игрока:: {FFFFFF} /incar [id][reason]",0x318CE7FF -1)
    end
end)
end

function cmd_fwarn(arg)
    lua_thread.create(function ()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/me достаёт КПК из кармана и заходит в базу сотрудников организации")
        wait(1500)
        sampSendChat("/me нашев сотрудника, изменяет информацию о нём и убирает КПК обратно в карман")
        wait(1500)
        sampSendChat("/fwarn "..arg1.." "..arg2)
    else
        sampAddChatMessage("Введи айди игрока:: {FFFFFF}/fwarn [ID][reason].",0x318CE7FF -1)
    end
end)
end

function cmd_showpass(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/showpass [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me достал папку с документами")
        wait(1500)
        sampSendChat("/do Папка в руке.")
        wait(1500)
        sampSendChat("/me достал паспорт")
        wait(1500)
        sampSendChat("/do Паспорт в руке.")
        wait(1500)
        sampSendChat("/me передал паспорт человеку на против")
        wait(1500)
        sampSendChat("/showpass " ..id.. " ")
    end)
end
end

function cmd_giverank(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/me достаёт из кармана Кпк и заходит в базу данных организации")
        wait(1500)
        sampSendChat("/me нашел сотрудника, нажав на информацию сотрудник, изменил его звание")
        wait(1500)
        sampSendChat("/giverank "..arg1.." "..arg2)
    else
        sampAddChatMessage("Введи айди игрока:: {FFFFFF}/giverank [ID] [rank].",0x318CE7FF -1)
    end
end)
end
function cmd_pas(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/pas [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat('Здравствуйте, сотрудник министерства юстиции штата, имя - '..sampGetPlayerNickname(myID))
            wait(1000)
            sampSendChat('/do Слева на груди жетон полицейского, справа - именная нашивка с фамилией.')
            wait(1000)
            sampSendChat('/showbadge '..id)
            wait(1000)
            sampSendChat('Прошу предьявить документ удостоверяющий вашу личность.')
    end)
end
end
function cmd_pasf()
        lua_thread.create(function()
            sampSendChat('Доброго времени суток, вас беспокоит сотрудник FBI.')
        wait(1000)
        sampSendChat('/do На поясе жетон FBI.')
        wait(1000)
        sampSendChat('Будьте добры предоставить ваши документики пожалуйста, паспорт')
        end)
    end
function cmd_showlic(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/showlic [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me достал папку с документами")
        wait(1500)
        sampSendChat("/do Папка в руке.")
        wait(1500)
        sampSendChat("/me достал лицензии")
        wait(1500)
        sampSendChat("/do Лицензии в руке.")
        wait(1500)
        sampSendChat("/me передал лицензии человеку на против")
        wait(1500)
        sampSendChat("/showlic " .. id .. " ")
    end)
end
end

function cmd_showskill(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/showskill [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me достал папку с документами")
        wait(1500)
        sampSendChat("/do Папка в руке.")
        wait(1500)
        sampSendChat("/me достал выписку с тира")
        wait(1500)
        sampSendChat("/do Выписка в руке.")
        wait(1500)
        sampSendChat("/me передал выписку человеку на против")
        wait(1500)
        sampSendChat("/showskill " .. id .. " ")
    end)
end
end

function cmd_showmc(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/showmc [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me достал папку с документами")
        wait(1500)
        sampSendChat("/do Папка в руке.")
        wait(1500)
        sampSendChat("/me достал мед. карту")
        wait(1500)
        sampSendChat("/do Мед. карта в руке.")
        wait(1500)
        sampSendChat("/me передал мед. карту человеку на против")
        wait(1500)
        sampSendChat("/showmc " .. id .. " ")
    end)
end
end

function cmd_pull(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/pull [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me схватил дубинку с пояса, резким взмахом ее и начал бить по окну водителя")
        wait(1500)
        sampSendChat("/pull " .. id .. " ")
        wait(1500)
        sampSendChat("/me разбив стекло, открыл дверь изнутри и схватил водителя за одежду ...")
        wait(1500)
        sampSendChat("/me ... после чего, выбросил подозреваемого на асфальт и заломал его руки")

    end)
end
end

function cmd_invite(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/invite [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/do Под стойкой находится рюкзак.")
        wait(1500)
        sampSendChat("/do Форма в рюкзаке...")
        wait(1500)
        sampSendChat("/me сунул руку в рюкзак, после чего взял форму и бейджик в руки")
        wait(1500)
        sampSendChat("/me передаёт форму и бейджик")
        wait(1500)
        sampSendChat("/todo Идите переоденьтесь*указывая пальцем на дверь раздевалки")
        wait(1500)
        sampSendChat("/invite " .. id .. " ")
    end)
end
end

function cmd_uninvite(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat ("/do В кармане лежит КПК с базой данных")
        wait(1500)
        sampSendChat ("/me движением правой руки, аккуратно достал КПК из кармана")
        wait(1500)
        sampSendChat ("/do Сотрудник держит КПК в руках.")
        wait(1500)
        sampSendChat("/me движением правой руки, нажал на кнопку включения КПК")
        wait(1500)
        sampSendChat ("/me зашел базу данных сотрудников")
        wait(1500)
        sampSendChat ("/me нажал на кнопку уволить сотрудника")
        wait(1500)
        sampSendChat ("/do КПК: Заполните информацию о сотруднике.")
        wait(1500)
        sampSendChat ("/me беглым движением рук, заполнил информацию о сотруднике, после чего нажал кнопку уволить сотрудника")
        wait(1500)
        sampSendChat ("/do КПК: Сотрудник успешно уволен из базы данных.")
        wait(1500)
        sampSendChat("/uninvite " ..arg1.. " "..arg2)
    else
        sampAddChatMessage("Введи айди игрока:: {FFFFFF}/uninvite [ID] [reason].",0x318CE7FF -1)
    end
end)
end

function cmd_cuff(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/cuff [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me одной рукой подозреваемого, другой достает из подсумка наручники ...")
        wait(1500)
        sampSendChat("/cuff "..id.." ")
        wait(1500)
        sampSendChat("/me ... и, скрестив руки подозреваемого нацепил их на него")
     end)
  end
end

function cmd_uncuff(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/uncuff [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/do Ключ от наручников в кармане.")
        wait(1500)
        sampSendChat("/me движением правой руки достал из кармана ключ и открыл наручники")
        wait(1500)
        sampSendChat("/do Преступник раскован.")
        wait(1500)
        sampSendChat("/uncuff "..id.." ")
    end)
 end
end

function cmd_gotome(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/gotome [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me заломил правую руку нарушителю")
        wait(1500)
        sampSendChat("/me ведет нарушителя за собой")
        wait(1500)
        sampSendChat("/gotome "..id.." ")
    end)
 end
end

function cmd_ungotome(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/ungotome [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me отпустил правую руку преступника")
        wait(1500)
        sampSendChat("/do Преступник свободен.")
        wait(1500)
        sampSendChat("/ungotome "..id.." ")
    end)
 end
end

function cmd_frisk(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/frisk [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me надев резиновые перчатки, начал прощупывать гражданина по всему телу ...")
        wait(1500)
        sampSendChat("/do Перчатки надеты.")
        wait(1500)
        sampSendChat("/me проводит руками по верхней части тела")
        wait(1500)
        sampSendChat("/me ... за тем начал тщательно обыскивать гражданина, выкладывая всё для изучения")
        wait(1500)
        sampSendChat("/frisk " .. id .. " ")
    end)
end
end

function cmd_pursuit(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/pursuit [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me положив руки на клавиатуру бортового компьютера, начал поиск по базе данных по имени")
        wait(1500)
        sampSendChat("/me найдя имя, проверил номер телефона и включил отслеживания по GPS")
        wait(1000)
        sampSendChat("/pursuit " .. id .. " ")
    end)
end
end

function cmd_arm()
    lua_thread.create(function()
        sampSendChat("/armour")
        wait(1500)
        sampSendChat("/me сменил пластины в бронижелете")
    end)
end
function cmd_ticket(arg)
    lua_thread.create(function ()
        local arg1, arg2, arg3 = arg:match('(.+) (.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil and arg3 ~= nil then
        sampSendChat("/me достав небольшой терминал, присоединил его к КПК и показал приёмник для карты")
        wait(1500)
        sampSendChat("/todo Вставьте сначала водительскую, затем кредитную карту в приёмник!*держа терминал")
        wait(1500)
        sampSendChat("/ticket "..arg1.." "..arg2.." "..arg3.." ")
    else
        sampAddChatMessage("Введи айди игрока:: {FFFFFF}/ticket [ID] [Сумма] [reason].",0x318CE7FF -1)
    end
end)
end
function cmd_mask()
lua_thread.create(function()
        sampSendChat("/mask")
        wait(1500)
        sampSendChat("/me надел на руки перчатки, надел балаклаву на лицо")
    end)
end

function cmd_drug(id)
if id == "" then
     sampAddChatMessage("Введи кол-во нарко [1-3]: {FFFFFF}/usedrugs [1-3].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me достал из кармана конфетку рошен")
        wait(1500)
        sampSendChat("/do Снял фантик, съел ее.")
        sampSendChat("/usedrugs "..id.." ")
    end)
end
end


function cmd_arrest(id)
if id == "" then
     sampAddChatMessage("Введи айди игрока:: {FFFFFF}/arrest [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me нажав на тангету, сообщил диспетчеру о провезенном преступники ...")
        wait(1500)
        sampSendChat("/me запросил офицеров для сопровождения")
        wait(1500)
        sampSendChat("/do Департамент: Принято, ожидайте двух офицеров.")
        wait(1500)
        sampSendChat("/do Из участка выходят 2 офицера, после забирают преступника.")
        sampSendChat("/arrest "..id.." ")
    end)
end
end
function cmd_stop(arg)
    lua_thread.create(function()
        local arg1 = arg:match('(.+)')
    if arg1 ~= nil then
        sampSendChat("/do Мегафон находится в бардачке.")
        wait(1500)
        sampSendChat("/me достал мегафон из бардачка, поднес его к рту и начал говорить")
        wait(1500)
        sampSendChat("/m Водитель транспортного средства, с N "..arg1.." прижмитесь к обочине и заглушите двигатель...")
        wait(1500)
        sampSendChat("/m ...руки держите на руле. В случае неподчинения, по вам будет открыт огонь")
        wait(1500)
        sampSendChat("/me закончил говорить и убрал мегафон в бардачок")
    else
        sampAddChatMessage("Введи айди игрока:: {FFFFFF}/stop [ID].",0x318CE7FF -1)
    end
end)
end
function cmd_miranda()
lua_thread.create(function()
        sampSendChat("Вы имеете право хранить молчание.")
        wait(1500)
        sampSendChat(" Всё, что вы скажете, мы можем и будем использовать против вас в суде.")
        wait(1500)
        sampSendChat(" Вы имеете право на адвоката и на один телефонный звонок.")
        wait(1500)
        sampSendChat(" Если у вас нет адвоката, государство предоставит вам адвоката, увидеть которого вы сможете в зале суда.")
        wait(1500)
        sampSendChat(" Вам понятны ваши права?")
    end)
 end

function cmd_bodyon()
    lua_thread.create(function()
        sampSendChat("/do На груди висит небольшая HD-камера.")
        wait(1500)
        sampSendChat("/me незаметным движением правой руки протянулся к камере, нажав кнопку включения камеры")
        wait(1500)
        sampSendChat("/do Камера на груди ведет запись.")
    end)
 end


function cmd_bodyoff()

lua_thread.create(function()
        sampSendChat("/do На груди  висит небольшая HD-камера")
        wait(1500)
        sampSendChat("/me незаметным движением правой руки протянулся к камере, нажав кнопку выключения камеры")
        wait(1500)
        sampSendChat("/do Камера на груди перестала вести запись и сохранила её на SD карте")
    end)
end

function cmd_drugtestno()
lua_thread.create(function()
        sampSendChat("/me открыв багажник автомобиля, достал набор перенасной лабаратории.")
        wait(1500)
        sampSendChat("/me открыв его, взял из набора пробирку с этиловым спиртом")
        wait(1500)
        sampSendChat("/me насыпал в пробирку найденое вещество")
        wait(1500)
        sampSendChat ("/me добавил в пробирку тест Имуно-Хром-10")
        wait(1700)
        sampSendChat("/me резкими движениями взбалтывает пробирку")
        wait(1700)
        sampSendChat("/do Тест дал отрицательный результат, вещество не является наркотиком. ")
    end)
 end


function cmd_drugtestyes()
lua_thread.create(function()
        sampSendChat("/me открыв багажник автомобиля достал набор с переносной лабараторией")
        wait(1500)
        sampSendChat("/me открыв его, взял из набора пробирку с этиловым спиртом")
        wait(1500)
        sampSendChat("/me насыпал в пробирку найденое вещество")
        wait(1500)
        sampSendChat ("/me добавил в пробирку тест Имуно-Хром-10")
        wait(1700)
        sampSendChat("/me резкими движениями взбалтывает пробирку")
        wait(1700)
        sampSendChat("/do Тест дал положительный результат, вещество является наркотиком.")
    end)
end

function cmd_testlabyes()
lua_thread.create(function()
    sampSendChat("/do На столе стоит микроскоп, рядом с ним лежит небольшая книжечка и стоят весы.")
    wait(1500)
    sampSendChat("/do Во внутреннем кармане лежат изъятые неизвестные вещества.")
    wait(1500)
    sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
    wait(1500)
    sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
    wait(1500)
    sampSendChat("/me ..высыпал его содержимое на весы, стоящие на столе перед собой")
    wait(1500)
    sampSendChat("/do Весы отобразили вес высыпанной агентом субстанции.")
    wait(1500)
    sampSendChat("/me быстрыми движениями рук взял предметное стекло из-под микроскопа и насыпал на него пару миллиграмм..")
    wait(1500)
    sampSendChat("/me ..вещества с весов, после чего взял пипетку, наполнил её водой и капнул поверх вещества")
    wait(1500)
    sampSendChat("/me быстро положив пипетку обратно в колбочку, положил предметное стекло под микроскоп и начал изменять уровень..")
    wait(1500)
    sampSendChat("/me ..увеличения, смотря в экран микроскопа")
    wait(1500)
    sampSendChat("/me не отрывая взгляда от экрана микроскопа, взял со стола книгу и внимательно начал листать её страницы, ...")
    wait(1500)
    sampSendChat("/me ..сравнивая картинки в книге с изображением на экране микроскопа")
    wait(1500)
    sampSendChat("/do Агент внимательно изучил всю книгу и готов записать заключение, что вещетсво есть наркотиком.")
    wait(1500)
    sampSendChat("/me отстранившись от микроскопа, положил книгу на стол, после чего резкими движениями рук достал..")
    wait(1500)
    sampSendChat("/me ..из нагрудного кармана КПК и разблокировал его, зайдя в базу исследований написал там, что вещество - наркотик.")
end)
end

function cmd_testlabno()
lua_thread.create(function()
    sampSendChat("/do На столе стоит микроскоп, рядом с ним лежит небольшая книжечка и стоят весы.")
    wait(1500)
    sampSendChat("/do Во внутреннем кармане лежат изъятые неизвестные вещества.")
    wait(1500)
    sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
    wait(1500)
    sampSendChat("/do Также на столе стоит небольшая колба с водой, а внутри неё лежит пипетка.")
    wait(1500)
    sampSendChat("/me ..высыпал его содержимое на весы, стоящие на столе перед собой")
    wait(1500)
    sampSendChat("/do Весы отобразили вес высыпанной агентом субстанции.")
    wait(1500)
    sampSendChat("/me быстрыми движениями рук взял предметное стекло из-под микроскопа и насыпал на него пару миллиграмм..")
    wait(1500)
    sampSendChat("/me ..вещества с весов, после чего взял пипетку, наполнил её водой и капнул поверх вещества")
    wait(1500)
    sampSendChat("/me быстро положив пипетку обратно в колбочку, положил предметное стекло под микроскоп и начал изменять уровень..")
    wait(1500)
    sampSendChat("/me ..увеличения, смотря в экран микроскопа")
    wait(1500)
    sampSendChat("/me не отрывая взгляда от экрана микроскопа, взял со стола книгу и внимательно начал листать её страницы, ...")
    wait(1500)
    sampSendChat("/me ..сравнивая картинки в книге с изображением на экране микроскопа")
    wait(1500)
    sampSendChat("/do Агент внимательно изучил всю книгу и готов записать заключение, что вещетсво не есть наркотиком.")
    wait(1500)
    sampSendChat("/me отстранившись от микроскопа, положил книгу на стол, после чего резкими движениями рук достал..")
    wait(1500)
    sampSendChat("/me ..из нагрудного кармана КПК и разблокировал его, зайдя в базу исследований написал там, что вещество - не наркотик.")
end)
end

function cmd_vzatka(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/me смотрит на задержанного, достаёт с бардачка ручку и листочек.")
        wait(1500)
        sampSendChat("/me пишет на листочке сумму с шестью нулями, кидает на заднее сиденье.")
        wait(1500)
        sampSendChat("/do На листочке небрежно и коряво было написано: 3.000.000$.")
        wait(1500)
        sampSendChat("/bribe "..arg1.." "..arg2)
    else
        sampAddChatMessage("Введи айди игрока:: {FFFFFF}/bribe [ID] [Сумма].",0x318CE7FF -1)
    end
end)
end

function cmd_bomb()
lua_thread.create(function()
        sampSendChat("/do В руках был кейс сапёра, для разминирования бомбы.")
        wait(2500)
        sampSendChat("/me положив кейс на пол, быстрыми движениями рук открыл его и взял в правую руку кусачки")
        wait(2500)
        sampSendChat("/do В бомбе есть пять проводов: синий, жёлтый, красный, зелёный и голубой.")
        wait(2500)
        sampSendChat("/me внимательно изучая взрывное устройство, начал аккуратно искать провода, которые ведут к..")
        wait(2500)
        sampSendChat("/me .. самому механизму бомбы, параллельно левой рукой касаясь их")
        wait(2500)
        sampSendChat("/todo Этот теплый.*перерезая кусачками провод синего цвета")
        wait(2500)
        sampSendChat("/removebomb")
        wait(100)
        sampSendChat("/do Бомба обезврежена, таймер на ней остановился, а звуки таймера прекратились.")
        wait(2500)
        sampSendChat("/me быстрыми движениями рук положил кусачки в кейс, после чего взял бомбу в обе руки...")
        wait(2500)
        sampSendChat("/me ...и положил её в специальный отсек в кейсе сапёра, быстро закрывая его и взяв в левую руку")
    end)
end

function cmd_probiv()
    lua_thread.create(function()
    sampSendChat("/do На поясе висит личный КПК сотрудника.")
    wait(1500)
    sampSendChat("/me снял с пояса КПК , начал пробивать человека...")
    wait(1500)
    sampSendChat("/me ... по его лицу, ID-карте , бейджику и жетону")
    wait(1500)
    sampSendChat("/do На экране КПК высветилась вся информация о человеке.")
end)
end

function cmd_cure(id)
if id == "" then   
     sampAddChatMessage("Введи айди игрока: {FFFFFF}/cure [ID].", 0x318CE7FF)
else
    lua_thread.create(function()
        sampSendChat("/cure "..id.." ")
        wait(1500)
        sampSendChat("/me ставит медицинскую сумку возле пострадавшего")
        wait(1500)
        sampSendChat("/do Мед.сумка на земле.")
        wait(1500)
        sampSendChat("/me наклоняется над телом, затем прощупывает пульс на сонной артерии")
        wait(1500)
        sampSendChat("/do Пульс Отсутствует.")
        wait(1500)
        sampSendChat("/me начинает непрямой массаж сердца, время от времени проверяя пульс")
        wait(1500)
        sampSendChat("/do Спустя несколько минут сердце пациента началось биться.")
        wait(1500)
        sampSendChat("/todo Что-то ему вообще плохо*снимая медицинскую сумку с плеча")
    end)
end
end

function cmd_time()
lua_thread.create(function()
    sampSendChat("/me поднял руку и посмотрел на часы с гравировкой 'Love FBI'")
    wait(1200)
    sampSendChat("/time")
    sampSendChat('/do На часах пони и время: '..os.date('%H:%M:%S'))
end)
end

function cmd_find(id)
if id == "" then
     sampAddChatMessage("Введи айди игрока: {FFFFFF}/find [ID].", 0x318CE7FF - 1)
else
    lua_thread.create(function()
    sampSendChat("/me положив руки на клавиатуру бортового компьютера, начал поиск по базе данных по имени")
    wait(1500)
    sampSendChat("/find "..id.." ")
    wait(1500)
    sampSendChat("/me найдя имя, проверил номер телефона и включил отслеживания по GPS")
  end)
end
end

function cmd_demoute(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/do В правом кармане брюк находится КПК.")
        wait(1500)
        sampSendChat("/me достал КПК из правого кармана, затем начал пробивать по базе данных сотрудника через лицо, ID карту и жетон")
        wait(1500)
        sampSendChat("/do На экране КПК появилась полная информация о сотруднике.")
        wait(1500)
        sampSendChat("/me нажал на кнопку Уволить из Гос. Организации")
        wait(1500)
        sampSendChat("/demoute "..arg1.." "..arg2)
        wait(1500)
        sampSendChat("/do Сотрудник был удален из списка Гос. Сотрудников.")
        else
            sampAddChatMessage("Введи айди игрока:: {FFFFFF}/demoute [ID] [reason].",0x318CE7FF -1)
    end
end)
end

function cmd_dismiss(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/do В правом кармане брюк находится КПК.")
        wait(1500)
        sampSendChat("/me достал КПК из правого кармана, затем начал пробивать по базе данных сотрудника через лицо, ID карту и жетон")
        wait(1500)
        sampSendChat("/do На экране КПК появилась полная информация о сотруднике.")
        wait(1500)
        sampSendChat("/me нажал на кнопку Уволить из Гос. Организации")
        wait(1500)
        sampSendChat("/dismiss "..arg1.." "..arg2)
        wait(1500)
        sampSendChat("/do Сотрудник был удален из списка Гос. Сотрудников.")
        else
            sampAddChatMessage("Введи айди игрока:: {FFFFFF}/demoute [ID] [reason].",0x318CE7FF -1)
    end
end)
end

function cmd_eject(id)
if id == "" then
    sampAddChatMessage("Введи айди игрока:: {FFFFFF}/eject [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me открыл дверь авто, после чего выдвинул "..sampGetPlayerNickname(id).." из авто за дверь")
        wait(1500)
        sampSendChat("/eject "..id.." ")
        wait(1500)
        sampSendChat("/me закрыл дверь авто")
  end)
end
end

function cmd_secret_fbi()
lua_thread.create(function()
    sampSendChat("/do На столе лежит документ: Документ о неразглашении деятельности ФБР.")
    wait(1500)
    sampSendChat("/do Рядом с документом аккуратно расположена ручка с золотой гравировкой ФБР.")
    wait(1500)
    sampSendChat("/do В документе написано: Я, (Имя / Фамилия), клянусь держать втайне то, что видел, вижу, и буду видеть.")
    wait(1500)
    sampSendChat("/do Ниже написано: Готов нести полную ответственность, и в случае своего неповиновения, ...")
    wait(1500)
    sampSendChat("/do ... готов быть арестованным и отстраненным от должности, при наличии таковой.")
    wait(1500)
    sampSendChat("/do Еще ниже написано: Дата: ; Подпись: .")
    wait(1500)
    sampSendChat("/me передал документ с ручкой человеку")
    wait(1500)
    sampSendChat("Подпишите пожалуйста документ и отдайте мне его, с ручкой только!")
    wait(1500)
end)
end

function cmd_fake_pas()
lua_thread.create(function()
sampSendChat("/do В нагрудном кармане находиться фальшивый паспорт.")
wait(1500)
sampSendChat("/todo Так посмотрим*достав из нагрудного кармана фальшивый паспорт")
wait(1500)
sampSendChat("/me достал паспорт из нагрудного кармана, после чего предъявил его человеку напротив")
wait(1500)
sampSendChat("/do В паспорте написано: Имя: Mark В штате 30 лет. Работа: Сми ЛС.")
wait(1500)
sampSendChat("/me убрал паспорт в нагрудный карман")
end)
end

function cmd_dopros_on()
lua_thread.create(function()
sampSendChat("/me подходит к камере которая стояла в углу допросной и нажимает на кнопку включения записи.")
wait(1500)
sampSendChat("/do Камера в углу допросной начала запись сохраняет её в облако.")
wait(1500)
sampSendChat("/me подошел до стола, и наклонившись достал сумку которая там лежала.")
wait(1500)
sampSendChat("/do В сумке находится: Полиграф, ноутбук, и пренадлежности для полиграфа.")
wait(1500)
sampSendChat("/me открыв сумку, выложил все содержимое на стол")
wait(1500)
sampSendChat("/me подключил устройство полиграфа к ноутбуку")
wait(1500)
sampSendChat("/do На столе лежат присоски для измерения пульса и температуры тела.")
wait(1500)
sampSendChat("/me подключил присоски в область груди человека, после чего одел клемы на пальцы человека.")
wait(1500)
sampSendChat("/me проверил всё оборудование.")
wait(1500)
sampSendChat("/do Устройство подключено и полиграф пишет.")
wait(1500)
sampSendChat("Итак, начнём допрос, сейчас я буду вам задавать вопросы, просьба отвечать на них правильно.")
wait(1500)
sampSendChat("Если вы хорошо ответите на все вопросы, и не соврёте, я вам понижу срок либо вообще вас отпущу за помощь следствию.")
wait(1500)
sampSendChat("Я надеюсь на данный момент всё понятно.")
wait(1500)
sampSendChat("/b после каждого задоного вопроса я буду спрашивать на правильность ответа в /do")
wait(1500)
sampSendChat("/b затем вы должны писать /do *Своё Имя* ответил правильно на вопрос.")
wait(1500)
sampSendChat("/b в случаи же, если на ответ который будет не правильный по вопросу скажете в /do ответил правильно, это РП в свою сторону, варн.")
wait(1500)
sampSendChat("И так, ваше имя фамилия и возраст?")
wait(1500)
end)
end

function cmd_dopros_of()
lua_thread.create(function()
sampSendChat("/me подходит к камере которая стояла в углу допросной и нажимает кнопку отключения записи.")
wait(1500)
sampSendChat("/do Камера в углу допросной прекратила запись, и сохранила её в облако.")
wait(1500)
sampSendChat("/me подошел до человека, и снял с него присоски с клемами")
wait(1500)
sampSendChat("/me положил оборудование на стол, после чего сложил и положил в сумку.")
wait(1500)
sampSendChat("/me закрыл сумку, и положил её под стол")
wait(1500)
sampSendChat("Так, ну что-ж")
wait(1500)
sampSendChat("Допрос на это окончен. Спасибо.")
wait(1500)
end)
end

function cmd_test_weap()
lua_thread.create(function()
sampSendChat("/do В кармане пиджака лежат резиновые перчатки.")
wait(1500)
sampSendChat("/me правой рукой достал из кармана перчатки и надел их на кисти рук")
wait(1500)
sampSendChat("/do На столе лежит оружие, полоска и лист белой бумаги, две стойки с пробирками.")
wait(1500)
sampSendChat("/me осмотрел оружие и аккуратно разобрал его на отдельные части")
wait(1500)
sampSendChat("/me взял в руки затвор и полоску бумаги, поместил полоску в задний срез патронника")
wait(1500)
sampSendChat("/me убрал полоску бумаги из затвора")
wait(1500)
sampSendChat("/do На полоске бумаги остались следы нагара от не сгоревшего пороха.")
wait(1500)
sampSendChat("/me вытряхнул частицы с полоски на лист бумаги")
wait(1500)
sampSendChat("/me взял пробирку со стойки и пересыпал содержимое с листа в пробирку")
wait(1500)
sampSendChat("/me закрыл пробирку и поставил на другую стойку")
wait(1500)
sampSendChat("/me взял в руки крышку ствольной коробки и просмотрел серийный номер оружия")
wait(1500)
sampSendChat("/me включил компьютер и открыл базу данных, в поисковую строку ввёл номер оружия")
wait(1500)
sampSendChat("/do На экране высветилась информация об оружии и владельце.")
wait(1500)
sampSendChat("/me положил крышку ствольной коробки обратно на стол")
wait(1500)
sampSendChat("/me собрал оружие в целое, достал из ящика прозрачный спец.пакет и поместил в него оружиe")
wait(1500)
sampSendChat("/me взял со стола фломастер и пометил им спец.пакет, убрал фломастер в ящик и закрыл его")
end)
end

function cmd_delo()
lua_thread.create(function()
SampSendChat("/do На полке шкафе лежат папки с бланками.")
wait(1500)
SampSendChat("/me взял одну папку, открыл её и осмотрел содержимое")
wait(1500)
SampSendChat("/me положил папку на край стола, отодвинул кресло от себя")
wait(1500)
SampSendChat("/do В верхнем ящике стола лежит ручка и печать.")
wait(1500)
SampSendChat("/me открыл ящик, взял ручку с печатью, положил их на стол")
wait(1500)
SampSendChat("/me открыл папку, взял ручку в правую руку, заполняет дело")
wait(1500)
SampSendChat("/do Бланк заполнен и оформлен.")
wait(1500)
SampSendChat("/me закончил оформлять бланк, поставил печать в правом углу, закрыл папку")
wait(1500)
SampSendChat("/me убрал принадлежности в ящик, положил папку на край стола")
wait(1500)
end)
end

imgui.OnFrame(function()
    return sobes.FastAction[0]
end, function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(1400, sizeY - 700), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(150, 0), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"Меню собеседования", sobes.FastAction)
        imgui.Columns(1, "fastactions", false)
        if imgui.Button(u8"На собес?", imgui.ImVec2(150, 50)) then sampSendChat("Приветствую. Вы пришли на собеседование?") end
        imgui.NextColumn()
        if imgui.Button(u8"Документики", imgui.ImVec2(150, 50)) then
            lua_thread.create(function ()
            sampSendChat("Отлично, тогда мне понадобятся ваши документы, а именно: Паспорт, мед.карта, лицензии. ")
            wait(1000)
            sampSendChat('/b /showpass ' ..myID.. '  /showmc ' ..myID.. ' /showlic ' ..myID)
            end)
        end
        imgui.NextColumn()
        if imgui.Button(u8'Показал медкарту', imgui.ImVec2(150, 50)) then
            lua_thread.create(function ()
                sampSendChat('/me лёгким движением руки взял мед.карту из рук человека')
                wait(1500)
                sampSendChat('/me начал изучать мед.карту')
                wait(1500)
                sampSendChat('/me изучив мед.карту, отдал её владельцу')
                sampSendChat('/offer')
               end)
               end
        imgui.NextColumn()
        if imgui.Button(u8'Показал паспорт', imgui.ImVec2(150, 50)) then
            lua_thread.create(function ()
                sampSendChat('/me лёгким движением руки взял паспорт из рук человека')
                wait(1500)
                sampSendChat('/me изучил паспорт, затем вернул паспорт владельцу')
                sampSendChat('/offer')
                end)
            end
        imgui.NextColumn()
        if imgui.Button(u8'Показал лицензии', imgui.ImVec2(150, 50)) then
            lua_thread.create(function ()
                sampSendChat('/me лёгким движением руки взял мед.карту из рук человека')
                wait(1500)
                sampSendChat('/me начал изучать мед.карту')
                wait(1500)
                sampSendChat('/me изучив мед.карту, отдал её владельцу')
                sampSendChat('/offer')
                end)
                end
        imgui.NextColumn()
        if imgui.Button(u8'Вопрос 1', imgui.ImVec2(150, 50)) then
            sampSendChat("Сколько вы готовы работать в день?")
        end
        imgui.NextColumn()
        if imgui.Button(u8'Вопрос 2', imgui.ImVec2(150, 50)) then
            sampSendChat("Как вы понимаете слово \"Адекватность\"?")
        end
        imgui.NextColumn()
        if imgui.Button(u8'Вопрос 3', imgui.ImVec2(150, 50)) then
            sampSendChat("Как вы понимаете слово \"Коммуникабельность\" ?")
        end
        imgui.NextColumn()
        if imgui.Button(u8'Принят, инвайт сами.', imgui.ImVec2(150, 50)) then
            lua_thread.create(function ()
                sampSendChat('Отлично! Вы к нам подходите, теперь вы наш сотрудник!')
                wait(1500)
                sampSendChat('/do под стойкой находится рюкзак')
                wait(1500)
                sampSendChat('/do Форма в рюкзаке...')
                wait(1500)
                sampSendChat('/me сунул руку в рюкзак, после чего взял форму и бейджик в руки')
                wait(1500)
                sampSendChat('/me передаёт форму и бейджик')
                wait(1500)
                sampSendChat('/todo Идите переоденьтесь*указывая пальцем на дверь раздевалки')
            end)
            closeFastAction()
        end
        imgui.NextColumn()
        if imgui.Button(u8'Не принят', imgui.ImVec2(150, 50)) then sampSendChat('Увы вы не прошли собеседование, всего доброго.') closeFastAction() end
        imgui.Columns()
        imgui.End()
end)

function closeFastAction()
    sobes.FastAction[0] = false
end
