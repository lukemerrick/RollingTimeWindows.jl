# RollingTimeWindows.jl

This package lets you iterate over time-indexed data in fixed-size periods, even if the number of observations in each period varies.

## Example

```julia
using Dates
using Random
using RollingTimeWindows: RollingTimeWindow

timestamps = [
    DateTime("2018-01-03T14:30:00.098"),
    DateTime("2018-01-03T14:30:00.672"),
    DateTime("2018-01-03T14:30:02.235"),
    DateTime("2018-01-03T14:30:04.016"),
    DateTime("2018-01-03T14:30:06.220"),
    DateTime("2018-01-03T14:30:11.476"),
    DateTime("2018-01-03T14:30:17.158"),
    DateTime("2018-01-03T14:30:18.091"),
    DateTime("2018-01-03T14:30:23.663"),
    DateTime("2018-01-03T14:30:24.239")
]


#####
##### `timestamps`
#####

# 10-element Vector{DateTime}:
#  2018-01-03T14:30:00.098
#  2018-01-03T14:30:00.672
#  2018-01-03T14:30:02.235
#  2018-01-03T14:30:04.016
#  2018-01-03T14:30:06.220
#  2018-01-03T14:30:11.476
#  2018-01-03T14:30:17.158
#  2018-01-03T14:30:18.091
#  2018-01-03T14:30:23.663
#  2018-01-03T14:30:24.239

foo = Random.rand(Random.MersenneTwister(0), length(timestamps))


#####
##### `foo`
#####

# 10-element Vector{Float64}:
#  0.8236475079774124
#  0.9103565379264364
#  0.16456579813368521
#  0.17732884646626457
#  0.278880109331201
#  0.20347655804192266
#  0.042301665932029664
#  0.06826925550564478
#  0.3618283907762174
#  0.9732164043865108


for indices in RollingTimeWindow(timestamps, Second(4))
    println(indices)
    println(view(timestamps, indices))
    println(view(foo, indices))
    println()
end

#####
##### Output
#####

# 1:3
# [DateTime("2018-01-03T14:30:00.098"), DateTime("2018-01-03T14:30:00.672"), DateTime("2018-01-03T14:30:02.235")]
# [0.8236475079774124, 0.9103565379264364, 0.16456579813368521]

# 4:5
# [DateTime("2018-01-03T14:30:04.016"), DateTime("2018-01-03T14:30:06.220")]
# [0.17732884646626457, 0.278880109331201]

# 6:6
# [DateTime("2018-01-03T14:30:11.476")]
# [0.20347655804192266]

# 7:6
# DateTime[]
# Float64[]

# 7:8
# [DateTime("2018-01-03T14:30:17.158"), DateTime("2018-01-03T14:30:18.091")]
# [0.042301665932029664, 0.06826925550564478]

# 9:9
# [DateTime("2018-01-03T14:30:23.663")]
# [0.3618283907762174]

# 10:10
# [DateTime("2018-01-03T14:30:24.239")]
# [0.9732164043865108]
```
