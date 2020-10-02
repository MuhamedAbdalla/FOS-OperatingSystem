set "local_directory=%cd%"
set PATH=%local_directory%\bin;%local_directory%\opt\cross\bin;
set PATH=%PATH%;${PWD}\..\..\bin;${PWD}\..\..\opt\cross\bin

rem this line is not needed for FOS projects, only if a new generic C++ project 
rem is added with Debug and Release subfolders, this line will be useful for reaching 
rem cross-gcc from the PWD path of this project
set PATH=%PATH%;${PWD}\..\..\..\bin;${PWD}\..\..\..\opt\cross\bin

cd .\FOS_CODES
start ..\eclipse\eclipse.exe

