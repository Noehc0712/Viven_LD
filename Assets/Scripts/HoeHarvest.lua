local maxDistance = 5.0

local kadaifCount = 0
local REQUIRED_KADAIF = 5

local FARM_NAME = "Farm"
local PORTAL_NAME = "FarmPortal"
local TELEPORT_TARGET_NAME = "TeleportTarget_AfterFarm"

function objectShortClickAction(interactor)
    local origin = Player.Mine.CharacterHead.transform.position
    local dir = Player.Mine.CharacterHead.transform.forward
    local ray = Ray(origin, dir)

    local hits = VivenUtil.Physics.RayCastAll(ray, maxDistance)

    local closestHitDistance = math.huge
    local closestHitIndex = -1

    for i = 0, hits.Length - 1 do
        local hitObj = hits[i].transform.gameObject
        local n = hitObj.name

        if n == FARM_NAME or n == PORTAL_NAME then
            local d = hits[i].distance
            if d < closestHitDistance then
                closestHitDistance = d
                closestHitIndex = i
            end
        end
    end

    if closestHitIndex == -1 then
        Debug.Log("No relevant object hit within range.")
        return
    end

    local target = hits[closestHitIndex].transform.gameObject
    local name = target.name

    Debug.Log("Processing closest hit object: " .. name)

    -- Farm 클릭 = 카다이프 채집
    if name == FARM_NAME then
        kadaifCount = kadaifCount + 1
        Debug.Log("Kadaif harvested: " .. kadaifCount .. "/" .. REQUIRED_KADAIF)

        -- Farm을 한번 클릭하면 사라지게 하고 싶으면 아래 주석 해제
        target:SetActive(false)

        return
    end

    -- 포탈 클릭 = 5개 이상일 때 텔레포트
    if name == PORTAL_NAME then
        if kadaifCount >= REQUIRED_KADAIF then
            local teleportTarget = GameObject.Find("TeleportTarget_AfterFarm")
            if teleportTarget == nil then
                Debug.Log("Teleport target not found: " .. TeleportTarget_AfterFarm)
                return
            end

            Debug.Log("Teleporting... target=" .. teleportTarget.name)
            Player.Mine.TeleportPlayer(teleportTarget.transform.position, teleportTarget.transform.rotation)
        else
            Debug.Log("Not enough Kadaif! Now: " .. kadaifCount .. "/" .. REQUIRED_KADAIF)
        end
        return
    end
end

