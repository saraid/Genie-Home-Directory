start:
gosub target
pause
goto start

target:
put prep bolt %1
put target
waitfor formation of the target pattern
put cast
return