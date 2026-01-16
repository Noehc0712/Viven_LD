-- PickaxeMine.lua
local maxDistance = 5.0  

local pistachioCount = 0
local cocoaCount = 0
local kadaifCount = 0

function objectShortClickAction(interactor)

    local origin = Player.Mine.CharacterHead.transform.position
    local dir = Player.Mine.CharacterHead.transform.forward

    local ray = Ray(origin, dir)

   
    -- local isHit, hitInfo = VivenUtil.Physics.RayCast(ray, maxDistance)

    -- if not isHit then
        -- Debug.Log("No object hit within range.")
        -- return
    -- end

    -- local hitObj = hitInfo.transform.gameObject

    -- Debug.Log("Hit object: " .. hitObj.name)

    local hits = VivenUtil.Physics.RayCastAll(ray, maxDistance)

    local closestHitDistance = math.huge
    local closestHitIndex = -1

    for i = 0, hits.Length - 1 do
        local hitObj = hits[i].transform.gameObject

        if hitObj.name == "Rock" or hitObj.name == "Pistachio" or hitObj.name == "Cocoa" or hitObj.name == "Kadaif" then
            local hitDistance = hits[i].distance
            if hitDistance < closestHitDistance then
                closestHitDistance = hitDistance
                closestHitIndex = i
            end

        end
    end

    if closestHitIndex == -1 then
        Debug.Log("No relevant object hit within range.")
        return
    end

     Debug.Log("Processing closest hit object: " .. hits[closestHitIndex].transform.gameObject.name)
     hits[closestHitIndex].transform.gameObject:SetActive(false)




    -- for i = 0, hits.Length - 1 do
    --     local hitObj = hits[i].transform.gameObject

    --     Debug.Log("Raycast hit: " .. hits[i].transform.gameObject.name)

    --     if hitObj.name == "Rock" then
    --          hitObj:SetActive(false)
    --      end
     
    --     if hitObj.name == "Pistachio" then
    --          pistachioCount = pistachioCount + 1
    --          Debug.Log("Pistachio collected! Total count: " .. pistachioCount)
    --          hitObj:SetActive(false)
    --          return
    --      end
    --       if hitObj.name == "Cocoa" then
    --          cocoaCount = cocoaCount + 1
    --          Debug.Log("Cocoa collected! Total: " .. cocoaCount)
    --          hitObj:SetActive(false)
    --          return
    --      end
     
    --      if hitObj.name == "Kadaif" then
    --          kadaifCount = kadaifCount + 1
    --          Debug.Log("Kadaif collected! Total: " .. kadaifCount)
    --          hitObj:SetActive(false)
    --          return
    --      end
    -- end


    
end
