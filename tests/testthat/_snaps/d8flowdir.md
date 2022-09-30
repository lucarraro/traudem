# taudem_d8flowdir() works

    Code
      output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
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
    Code
      outputs <- taudem_d8flowdir(output)
    Output
      DFlowDir version ..
      Input file blop.tif has projected coordinate system.
      Processors: 
      Header read time: .
      Data read time: .
      Compute Slope time: .
      Write Slope time: .
      Resolve Flat time: .
      Write Flat time: .
      Total time: .
      This run may take on the order of  minutes to complete.
      This estimate is very approximate. 
      Run time is highly uncertain as it depends on the complexity of the input data 
      and speed and memory of the computer. This estimate is based on our testing on 
      a dual quad core Dell Xeon E .GHz PC with GB RAM.
      All slopes evaluated.  flats to resolve.

