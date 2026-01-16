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
        if hitObj.name == "pan" then
            local hitDistance = hits[i].distance
            if hitDistance < closestHitDistance then
                closestHitDistance = hitDistance
                closestHitIndex = i
            end
        end
    end

    if closestHitIndex == -1 then return end

    -- ❌ GameObject.Find로 inactive 찾으려 해서 문제였음
    -- ✅ 해결: 미리 활성화된 brown_bowl을 위치 이동
    local brown = GameObject.Find("brown_bowl")
    if brown == nil then
        Debug.Log("brown_bowl not found (inactive objects cannot be found!)")
        return
    end

    brown.transform.position =
        hits[closestHitIndex].transform.position

    Viven.Destroy(self.gameObject)
end