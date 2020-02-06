view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 400ns sim:/majority/x1 
wave modify -driver freeze -pattern constant -value 1 -starttime 400ns -endtime 800ns Edit:/majority/x1 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 800ns sim:/majority/x2 
wave edit invert -start 200000ps -end 400000ps Edit:/majority/x2 
wave edit invert -start 600000ps -end 800000ps Edit:/majority/x2 
wave create -driver freeze -pattern clock -initialvalue 0 -period 200ns -dutycycle 50 -starttime 0ns -endtime 800ns sim:/majority/x3 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ns -endtime 200ns Edit:/majority/x1 
WaveCollapseAll -1
wave clipboard restore
