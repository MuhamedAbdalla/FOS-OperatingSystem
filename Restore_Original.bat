rmdir /S /Q FOS_Labs_Template
unzip FOS_Labs_Template.zip 
del /F /Q FOS_CODES\FOS_Labs_Template\kern\*.*
del /F /Q FOS_CODES\FOS_Labs_Template\user\*.*
move /Y FOS_Labs_Template\kern\*.* FOS_CODES\FOS_Labs_Template\kern\
move /Y FOS_Labs_Template\user\*.* FOS_CODES\FOS_Labs_Template\user\
move /Y FOS_Labs_Template\boot\*.* FOS_CODES\FOS_Labs_Template\boot\
move /Y FOS_Labs_Template\conf\*.* FOS_CODES\FOS_Labs_Template\conf\
move /Y FOS_Labs_Template\inc\*.*  FOS_CODES\FOS_Labs_Template\inc\
move /Y FOS_Labs_Template\lib\*.*  FOS_CODES\FOS_Labs_Template\lib\
rmdir /S /Q FOS_Labs_Template

