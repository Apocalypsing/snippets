; 𝟯𝘂𝗧𝗼𝗼𝗹𝘀 𝗟𝗮𝘂𝗻𝗰𝗵𝗲𝗿
; Version 𝟭.𝟬
; Created by 𝗔𝗽𝗼𝗰𝗮𝗹𝘆𝗽𝘀𝗶𝗻𝗴
; 3uTools is an alternative to iTunes that lets you manage Apple iOS devices like iPhones and iPads. However, it was compiled with a manifest requiring the user to have elevated (administrative) privileges to run it. Despite this, 3uTools doesn't actually need elevated privileges to run, so I created this AHK script to launch it with standard user-invoked permissions for security reasons.

#NoEnv
#NoTrayIcon
EnvSet, __COMPAT_LAYER, RUNASINVOKER
Application = 3uTools.exe
if (FileExist(Application)) {
    Run, %Application%
}
exit
