taudem_algorithms <- function() {
  dir(taudem_path())
}


# all "*mn.cpp" in https://github.com/dtarb/TauDEM/blob/Develop/src/CMakeLists.txt
# see inst/taudem-algo-list.R

taudem_official_list <- function() {
  algos <- c("aread8", "areadinf", "ConnectDown",
    "D8FlowDir", "D8FlowPathExtremeUp", "D8HDistToStrm", "DinfAvalanche",
    "DinfConcLimAccum", "DinfDecayAccum", "DinfDistDown", "DinfDistUp",
    "DinfFlowDir", "DinfRevAccum", "DinfTransLimAccum", "DinfUpDependence",
    "DropAnalysis", "FlowdirCond", "gagewatershed",
    "gridnet", "LengthArea", "MoveOutletsToStrm", "PeukerDouglas",
    "PitRemove", "SinmapSI", "SlopeArea",
    "SlopeAreaRatio", "SlopeAveDown", "streamnet", "Threshold", "TWI"
  )
  if (on_windows()) {
    algos[algos == "MoveOutletsToStrm"] <- "MoveOutletsToStreams"
  }
  algos
}

find_algo <- function(algo) {
  nzchar(Sys.which(tolower(algo)))
}
