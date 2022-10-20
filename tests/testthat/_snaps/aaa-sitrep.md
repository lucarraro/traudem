# taudem_sitrep() works - problems

    x Can't find directory `blop` (TauDEM executables)
    i Register your TauDEM installation. See vignette('taudem-installation').

# taudem_sitrep() works - missing algos

    x Can't find executables for `aread8`, `areadinf`, `ConnectDown`, `D8FlowDir`, `D8FlowPathExtremeUp`, `D8HDistToStrm`, `DinfAvalanche`, `DinfConcLimAccum`, `DinfDecayAccum`, `DinfDistDown`, `DinfDistUp`, `DinfFlowDir`, `DinfRevAccum`, `DinfTransLimAccum`, `DinfUpDependence`, `DropAnalysis`, `FlowdirCond`, `gagewatershed`, `gridnet`, `LengthArea`, `MoveOutletsToStrm`, `PeukerDouglas`, `PitRemove`, `SinmapSI`, `SlopeArea`, `SlopeAreaRatio`, `SlopeAveDown`, `streamnet`, `Threshold`, `TWI`
    i Try re-installing TauDEM and write down any problem.

# taudem_sitrep() works - all well

    Code
      taudem_sitrep()
    Message <cliMessage>
      v Found GDAL
      v Found MPI (MPI).
      v Found TauDEM path
      v Found TauDEM executables directory.
      v Found all TauDEM executables.
      i Testing TauDEM on an example file (please wait a bit)...
      -- TauDEM output ---------------------------------------------------------------
    Output
      PitRemove version ..
      Input file blop.tif has projected coordinate system.
      Processes: 
      Header read time: .
      Data read time: .
      Compute time: .
      Write time: .
      Total time: .
      This run may take on the order of  minutes to complete.
      This estimate is very approximate. 
      Run time is highly uncertain as it depends on the complexity of the input data 
      and speed and memory of the computer. This estimate is based on our testing on 
      a dual quad core Dell Xeon E .GHz PC with GB RAM.
    Message <cliMessage>
      -- End of TauDEM output --------------------------------------------------------
      v Was able to launch a TauDEM example!
      ! Double-check above output for serious error messages.

