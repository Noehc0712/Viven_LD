local yellowBowlCount = 0

function AddYellowBowl()
    yellowBowlCount = yellowBowlCount + 1
    Debug.Log("Pan yellowBowlCount = " .. yellowBowlCount)
end

function GetYellowBowlCount()
    return yellowBowlCount
end

function ShowBrownBowl()
    if BrownBowl == nil then
        Debug.Log("BrownBowl injection is missing.")
        return
    end

    BrownBowl:SetActive(true)
    Debug.Log("brown_bowl activated.")
end
