
local maxDistance = 5.0

function objectShortClickAction(interactor)
    local origin = Player.Mine.CharacterHead.transform.position
    local dir = Player.Mine.CharacterHead.transform.forward
    local ray = Ray(origin, dir)

    local hits = VivenUtil.Physics.RayCastAll(ray, maxDistance)

    local closestHitDistance = math.huge
    local closestHitIndex = -1

    for i = 0, hits.Length - 1 do
        local hitObj = hits[i].transform.gameObject
        if hitObj.name == "green_bowl" then
            local d = hits[i].distance
            if d < closestHitDistance then
                closestHitDistance = d
                closestHitIndex = i
            end
        end
    end

    if closestHitIndex == -1 then
        Debug.Log("No green_bowl hit.")
        return
    end

    -- 초록색 볼을 주걱으로 처리
    Spread:SetActive(true)  -- spread 활성화

    -- 초록색 볼 소모(가까운 히트 오브젝트를 꺼도 되고, Injection으로 넣은 GreenBowl을 꺼도 됨)
    hits[closestHitIndex].transform.gameObject:SetActive(false)
    -- GreenBowl:SetActive(false)

    Player.Mine.EndAllInteractions()
    Debug.Log("spatula used on green_bowl -> spread activated!")
end
