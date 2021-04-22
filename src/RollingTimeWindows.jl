module RollingTimeWindows

import Dates
export RollingTimeWindow

struct RollingTimeWindow
    timestamps::AbstractArray{Dates.AbstractDateTime}
    period::Dates.Period
end

struct RollingTimeWindowState
    index::Int
    start_timestamp::Union{Nothing, Dates.AbstractDateTime}
end
RollingTimeWindowState() = RollingTimeWindowState(1, nothing)

function Base.iterate(
    rolling::RollingTimeWindow,
    state::RollingTimeWindowState=RollingTimeWindowState()
)
    max_index = length(rolling.timestamps)
    if state.index > max_index
        return nothing
    end
    index = state.index
    start_index = index
    start_timestamp = state.start_timestamp === nothing ? floor(rolling.timestamps[start_index], rolling.period) : state.start_timestamp
    end_timestamp = start_timestamp + rolling.period
    println(end_timestamp)
    while index <= max_index && rolling.timestamps[index] < end_timestamp
        index += 1
    end
    end_index = index - 1
    next_state = RollingTimeWindowState(index, end_timestamp)
    return (start_index:end_index, next_state)
end

Base.IteratorSize(IterType::RollingTimeWindow) = Base.SizeUnknown()
Base.IteratorEltype(IterType::RollingTimeWindow) = Base.HasEltype()
Base.eltype(IterType::RollingTimeWindow) = UnitRange{Int}

end
