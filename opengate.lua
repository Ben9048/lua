script_name("FAST OPEN GATE")
script_author("Ben_Puls")
script_description("fast open gate")



require "lib.moonloader"

local dlstatus = require('moonloader').download_status
local keys = require "vkeys"
local sampev = require 'lib.samp.events'
local inicfg = require "inicfg"

update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/Ben9048/lua/main/update.ini?token=GHSAT0AAAAAACDSWBWIRKG5PFAUC7CSIWCGZFF4CRA"
local update_path = getWorkingDirectory() .. "/update.ini" -- link

local scirpt_url = "" -- link
local script_path = thisScript().path

function main()
	repeat wait(0) until isSampAvailable()
	sampAddChatMessage("{ff7300}[Ben_Puls]: {ffffff}Fast open gate", -1)
	wait(2000)

	downloadUrlToFile(update_url, update_path, function(id, status) 
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nill, update_path)
           if tonumber(updateIni.info.vers) > script_vers then
            sampAddChatMessage("{ffffff}Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
                            updateIni = inicfg.load(nill, update_path)
                    
                                sampAddChatMessage("{ffffff}Скрипт успешно обновлён! Версия: " .. updateIni.info.vers_text, -1)
                                thisScript():reload()
                                                    
                        end
                    end)
                    break
                 end

          if not sampIsChatInputActive() then
	  if isKeyJustPressed(VK_H) then
			sampSendChat("/opengate")
	  end
end
end

function cmd_update(arg)
	sampShowDialog(1000, "Заголовок", "Описание", "Закрыть", "", 0)


end

end