taudem_algorithms <- function() {
  dir(taudem_path())
}

# all "*mn.cpp" in https://github.com/dtarb/TauDEM/blob/Develop/src/CMakeLists.txt
# see inst/taudem-algo-list.R
taudem_official_list <- function() {
  c("aread8", "areadinf", "CatchHydroGeo", "CatchOutlets", "ConnectDown",
    "D8FlowDir", "D8FlowPathExtremeUp", "D8HDistToStrm", "DinfAvalanche",
    "DinfConcLimAccum", "DinfDecayAccum", "DinfDistDown", "DinfDistUp",
    "DinfFlowDir", "DinfRevAccum", "DinfTransLimAccum", "DinfUpDependence",
    "DropAnalysis", "EditRaster", "FlowdirCond", "gagewatershed",
    "gridnet", "LengthArea", "MoveOutletsToStrm", "PeukerDouglas",
    "PitRemove", "RetLimFlow", "SetRegion", "SinmapSI", "SlopeArea",
    "SlopeAreaRatio", "SlopeAveDown", "streamnet", "Threshold", "TWI"
  )
}
