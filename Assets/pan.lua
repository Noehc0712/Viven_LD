local near = nil

function start()
    Debug.Log("[pan] ready")
end

-- pan 트리거에 들어온 가장 가까운 오브젝트 기억
function onTriggerEnter(other)
    if other == nil then return end

    local n = other.name
    if n == "yellow_bowl" or n == "spatula" then
        near = other
        Debug.Log("[pan] near = " .. n)
    end
end

function onTriggerExit(other)
    if other == nil then return end
    if near == other then
        Debug.Log("[pan] near cleared")
        near = nil
    end
end

-- ✅ pan을 잡고 있는 상태에서 Action(짧게 클릭)
function objectShortClickAction(interactor)
    if near == nil then
        Debug.Log("[pan] no near object")
        return
    end

    local n = near.name

    -- 1) 노란볼 근처 + pan Action -> 노란볼 삭제
    if n == "yellow_bowl" then
        Debug.Log("[pan] consume yellow_bowl")
        Viven.Destroy(near)
        near = nil
        return
    end

    -- 2) 주걱 근처 + pan Action -> 갈색볼 생성
    if n == "spatula" then
        Debug.Log("[pan] spawn brown_bowl")
        Viven.Instantiate("brown_bowl", self.transform.position)
        return
    end
end