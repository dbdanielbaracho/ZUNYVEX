--!strict
-- Server-authoritative checkpoint race rules; standalone until Studio integration.
-- Players race through ordered checkpoints. No work/economy mechanics.
local Race = {}
export type State = {nextCheckpoint: number, startedAt: number, finishedAt: number?}

function Race.new(checkpointCount: number, maxSeconds: number)
    assert(checkpointCount >= 2 and checkpointCount <= 64 and checkpointCount % 1 == 0, "checkpoint count")
    assert(maxSeconds >= 10 and maxSeconds <= 3600 and maxSeconds % 1 == 0, "time limit")
    local players: {[number]: State} = {}
    local controller = {}

    function controller.start(userId: number, now: number): boolean
        if userId <= 0 or userId % 1 ~= 0 or now ~= now or now == math.huge or now == -math.huge then return false end
        local previous = players[userId]
        if previous and previous.finishedAt == nil and now - previous.startedAt <= maxSeconds then return false end
        players[userId] = {nextCheckpoint = 1, startedAt = now}
        return true
    end

    -- Caller must validate that the server-side character touched the checkpoint.
    -- Client-supplied checkpoint claims are never sufficient.
    function controller.touch(userId: number, checkpoint: number, now: number): (string, number?)
        local state = players[userId]
        if state == nil then return "not_started", nil end
        if state.finishedAt ~= nil then return "already_finished", nil end
        if now ~= now or now == math.huge or now == -math.huge or now < state.startedAt then return "invalid_time", nil end
        local elapsed = now - state.startedAt
        if elapsed > maxSeconds then
            players[userId] = nil
            return "timed_out", nil
        end
        if checkpoint ~= state.nextCheckpoint then return "out_of_order", nil end
        if checkpoint == checkpointCount then
            state.finishedAt = now
            return "finished", elapsed
        end
        state.nextCheckpoint += 1
        return "checkpoint", nil
    end

    function controller.leave(userId: number)
        players[userId] = nil
    end

    function controller.progress(userId: number): number?
        local state = players[userId]
        return if state then state.nextCheckpoint else nil
    end

    return controller
end
return Race
