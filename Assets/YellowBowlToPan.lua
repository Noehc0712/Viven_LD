-- YellowBowlToPan.lua (yellow_bowl에 붙이기)
local maxDistance = 5.0
local PAN_LUA_NAME = "PanState"

function objectShortClickAction(interactor)
    local origin = Player.Mine.CharacterHead.transform.position
    local dir = Player.Mine.CharacterHead.transform.forward
    local ray = Ray(origin, dir)

    local hits = VivenUtil.Physics.RayCastAll(ray, maxDistance)

    local closestDist = math.huge
    local closestIdx = -1

    for i = 0, hits.Length - 1 do
        local go = hits[i].transform.gameObject
        if go.name == "pan" then
            local d = hits[i].distance
            if d < closestDist then
                closestDist = d
                closestIdx = i
            end
        end
    end

    if closestIdx == -1 then
        Debug.Log("No pan hit.")
        return
    end

    local panGO = hits[closestIdx].transform.gameObject
    local panLua = panGO:GetLuaComponent(PAN_LUA_NAME)
    if panLua == nil then
        Debug.Log("PanState lua not found on pan.")
        return
    end

    panLua:AddYellowBowl()

    Player.Mine.EndAllInteractions()
    self.gameObject:SetActive(false) -- 노란색 볼 사라짐
    Debug.Log("yellow_bowl consumed and count added to pan.")
end
