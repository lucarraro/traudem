# taudem_aread8() works

    Code
      output <- taudem_pitremove(file.path(test_dir, "MED_01_01.tif"))
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
      Draining flats towards lower adjacent terrain
      ......................................................................................................................................................................................................................
      Draining flats away from higher adjacent terrain
      ........................................
      Setting directions
      Iteration complete. Number of flats remaining: 
      Draining flats towards lower adjacent terrain
      .......
      Draining flats away from higher adjacent terrain
      .....
      Setting directions
    Code
      contributing_area_grid <- taudem_aread8(outputs$output_d8flowdir_grid)
    Output
      AreaD version ..
      Input file blop.tif has projected coordinate system.
      Number of Processes: 
      Read time: .
      Compute time: .
      Write time: .
      Total time: .
      This run may take on the order of  minutes to complete.
      This estimate is very approximate. 
      Run time is highly uncertain as it depends on the complexity of the input data 
      and speed and memory of the computer. This estimate is based on our testing on 
      a dual quad core Dell Xeon E .GHz PC with GB RAM.
    Code
      contributing_area_grid2 <- taudem_aread8(outputs$output_d8flowdir_grid,
      check_edge_contamination = FALSE)
    Output
      AreaD version ..
      Input file blop.tif has projected coordinate system.
      Number of Processes: 
      Read time: .
      Compute time: .
      Write time: .
      Total time: .
      This run may take on the order of  minutes to complete.
      This estimate is very approximate. 
      Run time is highly uncertain as it depends on the complexity of the input data 
      and speed and memory of the computer. This estimate is based on our testing on 
      a dual quad core Dell Xeon E .GHz PC with GB RAM.

