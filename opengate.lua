script_name("Model")
script_author("Ben_Puls")
script_description("Model")

require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require 'vkeys'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

update_state = false

local script_vers = 1
local script_vers_text = "1.00"
local script_path = thisScript().path
local script_url = "https://raw.githubusercontent.com/Ben9048/lua/main/opengate.lua" -- link
local update_path = getWorkingDirectory() .. "/update.ini" -- link
local update_url = "https://raw.githubusercontent.com/Ben9048/lua/main/update.ini?token=GHSAT0AAAAAACDSWBWIRKG5PFAUC7CSIWCGZFF4CRA"


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end

    sampRegisterChatCommand("update", cmd_update)

    __, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nick = sampGetPlayerNickname(id)



    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
           if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('{ffffff}Есть обновление! Версия: ' .. updateIni.info.vers_text, -1)
                update_state = true
           end
           os.remove(update_path)
        end

    end)


    while true do
        wait(0)
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage('{ffffff}Скрипт успешно обновлён!', -1)
                    thisScript():reload()
              
                end
        
            end)
            break
        end
        end

    end


function cmd_update(arg)
    sampShowDialog(1000, "Заголовок v1.2", "Текст", "Закрыть", "", 0)
end