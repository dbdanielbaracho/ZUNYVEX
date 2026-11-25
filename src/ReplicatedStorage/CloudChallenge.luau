--!strict
local Challenge = {}
export type Progress = {checkpoint: number, challengeActive: boolean}
function Challenge.start(s: Progress)
    s.checkpoint = 0
    s.challengeActive = true
end
function Challenge.reset(s: Progress)
    s.checkpoint = 0
    s.challengeActive = false
end
function Challenge.advance(s: Progress, index: number, total: number): string
    if not s.challengeActive or index ~= s.checkpoint + 1 or index > total or index < 1 then
        return "ignored"
    end
    s.checkpoint = index
    if index == total then
        Challenge.reset(s)
        return "finished"
    end
    return "advanced"
end
return Challenge
