#SingleInstance force

;singe script




;——————————————————————————————————————————————————————————————————————————————————————————————————————————————————

;paths and parameters
Chrome_dir := "C:\Program Files\Google\Chrome\Application\chrome.exe"
VS_dir := "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
Everything_dir := "C:\Program Files\Everything\Everything.exe"
FastCopy_dir := "D:\software\FastCopy\FastCopy.exe /cmd=update /auto_close "
Wechat_dir := "D:\software\WeChat\WeChat.exe"



; Check App's Status
Activate(t)
{
  IfWinActive,%t%
  {
    WinMinimize
    return
  }
  SetTitleMatchMode 2    
  DetectHiddenWindows,on
  IfWinExist,%t%
  {
    WinShow
    WinActivate           
    return 1
  }
  return 0
} 



; Boost App
ActivateAndOpen(t,p)
{
  if Activate(t)==0
  {
    Run %p%,,Max
    WinActivate
    return 0
  }
  return 1
} 

; Edit the script by Alt+Ctrl+E.
!^e::
Edit   
return



; Reload the script 
!^r::
Reload 
return

; roll down quickly
RShift & [::
  MouseClick, WheelDown,,,10,0,D,R
return
  

; roll up quickly
RShift & ]::
 MouseClick, WheelUp,,,10,0,D,R
return



; Maximize
RShift & m::#up 

; Minimize
RShift & n:: #down 

; Quick Boost 
RShift & g::ActivateAndOpen("Google Chrome", Chrome_dir) 
RShift & v::ActivateAndOpen("Visual Studio 2019", VS_dir)
RShift & e::ActivateAndOpen("Everything", Everything_dir)
RShift & f::
  ControlGetText, path, Edit1, ahk_class CabinetWClass
  Run % (FastCopy_dir . Clipboard . " /to=" . path)
  Return
RShift & z:: Run https://www.zhihu.com
RShift & w:: Run % Wechat_dir


;————————————————————————————————————————————————————————————————————————————————————————————————————————————————————     
;hhkb keyboard layout improved
;project the key I don't use to a more common one 
`::Del

;temporary solution of direction key
Tab::Tab
Tab & j::Left
Tab & k::Down
Tab & l::Right  
Tab & i::Up

;project RAlt to a layout changing key
IsDoubleClick(){
  static doubleClickTime := DllCall("GetDoubleClickTime")
  keyWait, % LTrim(A_ThisHotkey, "~")
  return (A_ThisHotKey = A_PriorHotKey) && (A_TimeSincePriorHotkey <= doubleClickTime)
}

RAlt::
  IsDoubleClick() ? (RemapKeys := !RemapKeys) : ""
  return

RemapKeys = False

#If RemapKeys 
    1::F1
    2::F2
    3::F3
    4::F4
    5::F5
    6::F6
    7::F7
    8::F8
    9::F9
    0::F10
    -::F11
    =::F12
    '::Up
    /::Down
    .::Left
    RShift::Right
#If