; 𝗘𝗹𝗲𝘃𝗮𝘁𝗶𝗼𝗻 𝗕𝘆𝗽𝗮𝘀𝘀
; Version 𝟭.𝟬
; Created by 𝗔𝗽𝗼𝗰𝗮𝗹𝘆𝗽𝘀𝗶𝗻𝗴
; Some Windows applications have manifests that dictate that they need to be run with elevated (administrative) privileges. Despite this, some of these applications may run just fine with standard user-invoked privileges, which this AHK script will permit.

#NoEnv
EnvSet, __COMPAT_LAYER, RUNASINVOKER
IniFile = ElevationBypass.ini
if (!FileExist(IniFile)) {
    IniWrite, PlaceholderApp.exe, %IniFile%, Application, AppName
}
IniRead, Application, %IniFile%, Application, AppName
if (FileExist(Application)) {
	Run, %Application%
} else {
    MsgBox, 16, Unable to Launch, %Application% is missing
}
exit