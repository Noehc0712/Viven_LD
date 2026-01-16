
local maxDistance = 5.0

function objectShortClickAction(interactor)
    local origin = Player.Mine.CharacterHead.transform.position
    local dir = Player.Mine.CharacterHead.transform.forward
    local ray = Ray(origin, dir)

    local hits = VivenUtil.Physics.RayCastAll(ray, maxDistance)

    local closestDist = math.huge
    local closestIdx = -1

    for i = 0, hits.Length - 1 do
        local go = hits[i].transform.gameObject
        if go.name == "ma" then
            local d = hits[i].distance
            if d < closestDist then
                closestDist = d
                closestIdx = i
            end
        end
    end

    if closestIdx == -1 then
        Debug.Log("No marshmallow (ma) hit.")
        return
    end

    -- 마시멜로를 밀대로 눌러서 피(mapi) 생성
    if Mapi == nil then
        Debug.Log("Mapi injection is missing.")
        return
    end

    Mapi:SetActive(true) -- 도마 위 mapi 등장
    hits[closestIdx].transform.gameObject:SetActive(false) -- ma 소모(원하면 제거 가능)

    Player.Mine.EndAllInteractions()
    Debug.Log("RollingPin used on ma -> mapi activated!")
end
