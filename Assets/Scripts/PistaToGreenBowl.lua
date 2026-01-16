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
        if hitObj.name == "blender" then
            local d = hits[i].distance
            if d < closestHitDistance then
                closestHitDistance = d
                closestHitIndex = i
            end
        end
    end

    if closestHitIndex == -1 then
        Debug.Log("No blender hit.")
        return
    end

    -- blender를 맞춘 상태


    GreenBowl:SetActive(true)     -- 초록색 볼 등장
    Player.Mine.EndAllInteractions()
    self.gameObject:SetActive(false)  -- 피스타치오는 소모(원하면 이 줄 빼도 됨)
    
    Debug.Log("Blended pista -> green_bowl activated!")
end

