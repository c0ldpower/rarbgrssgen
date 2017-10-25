#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

appname=RarBG RSS Search Link Generator
ver=1.0

Menu,Tray,Tip,%appname% %ver%
Menu,Tray,Add,&Server Setup,ButtonSetup

servaddr=localhost ;default server address
port=4444 ;default port
address=http://%servaddr%:%port%
;srchmode=search

GUIstart:
Gui, Add, Text,, Search string:
Gui, Add, Edit, w500 vsearchstr ym  ; The ym option starts a new column of controls.

Gui, Add, CheckBox, x10 y50 vCheck_All gCheck_All, Check All

Gui, Add, Text, x85 y50, Categories:
Gui, Add, Checkbox, cRed vcategory4, 4 XXX (18+)
Gui, Add, Checkbox, vcategory14, 14 Movies/XVID
Gui, Add, Checkbox, vcategory48, 48 Movies/XVID/720
Gui, Add, Checkbox, vcategory17, 17 Movies/x264
Gui, Add, Checkbox, cBlue vcategory44, 44 Movies/x264/1080
Gui, Add, Checkbox, vcategory45, 45 Movies/x264/720
Gui, Add, Checkbox, vcategory47, 47 Movies/x264/3D
Gui, Add, Checkbox, vcategory42, 42 Movies/Full BD
Gui, Add, Checkbox, vcategory46, 46 Movies/BD Remux
Gui, Add, Checkbox, x270 y65 vcategory18, 18 TV Episodes
Gui, Add, Checkbox, cBlue vcategory41, 41 TV HD Episodes
Gui, Add, Checkbox, vcategory23, 23 Music/MP3
Gui, Add, Checkbox, vcategory25, 25 Music/FLAC
Gui, Add, Checkbox, vcategory27, 27 Games/PC ISO
Gui, Add, Checkbox, vcategory28, 28 Games/PC RIP
Gui, Add, Checkbox, vcategory40, 40 Games/PS3
Gui, Add, Checkbox, vcategory32, 32 Games/XBOX-360
Gui, Add, Checkbox, vcategory33, 33 Software/PC ISO
Gui, Add, Checkbox, vcategory35, 35 e-Books

Gui, Add, Checkbox, x570 y235 Checked valwysontop gUpdatetop, Always on Top

Gui, Add, Text, x450 y50, Search mode:
Gui, Add, Radio, Checked vsrchmoderaw, search
Gui, Add, Radio,, imdb
Gui, Add, Radio,, tvdb

Gui, Add, Text, x450 y135, Limit to:
Gui, Add, Radio, Checked vlimitraw, 25
Gui, Add, Radio,, 50
Gui, Add, Radio,, 100
Gui, Add, Text, x85 y32 +wrap w500 cGray vlastlink, Link: current search link will be displayed here and copied to Clipboard automatically
Gui, Add, Button, x595 y5 default, &Get link ;generates link
Gui, Add, Button, x595 y30, &Run link ; Opens generated link in def browser
Gui, Add, Button, x595 y70, Setup
Gui, Add, Button, x595 y95, About
Gui, Show,, %appname% %ver%

Updatetop:
    Gui, Submit, NoHide
    If alwysontop = 1
    {
        Gui, +AlwaysOnTop
    }
    else
    {
        Gui, -AlwaysOnTop
    }

return  ; End of auto-execute section. The script is idle until the user does something.

ButtonSetup:
Gui, Hide
Gui, 2:+AlwaysOnTop
Gui, 2:Add, Text,, Server address:
Gui, 2:Add, Text,, Port:
Gui, 2:Add, Edit, w100 vservaddr ym, %servaddr%  ; The ym option starts a new column of controls.
Gui, 2:Add, Edit, w40 vport number, %port%
Gui, 2:Add, Checkbox, vsslcheck, Use SSL
Gui, 2:Add, Button, default gSet, Set
Gui, 2:Show,, Setup
return

Set:
Gui, 2:Submit  ; Save the input from the user to each control's associated variable.
If (port = "") ;checks if port is specified
	{
		if sslcheck=1
		{
		address=https://%servaddr%
		}
		else
		{
		address=http://%servaddr%
		}
	}
	else
	{
		if sslcheck=1
		{
		address=https://%servaddr%:%port%
		}
		else
		{
		address=http://%servaddr%:%port%
		}
	}
Gui, 2:Destroy
Gui, 1:Show
return
2GuiEscape:
2GuiClose:
Gui, 2:Destroy
Gui, 1:Show
return

ButtonGetlink:
Gui, Submit, NoHide  ; Save the input from the user to each control's associated variable.
categories=0

StringReplace, searchstr, searchstr, :,%A_SPACE%, All
StringReplace, searchstr, searchstr, %A_SPACE%,+, All
StringReplace, searchstr, searchstr, ', , All
StringReplace, searchstr, searchstr, ++,+, All

if category4=1
	categories=%categories%;4
if category14=1
	categories=%categories%;14
if category48=1
	categories=%categories%;48
if category17=1
	categories=%categories%;17
if category44=1
	categories=%categories%;44
if category45=1
	categories=%categories%;45
if category47=1
	categories=%categories%;47
if category42=1
	categories=%categories%;42
if category46=1
	categories=%categories%;46
if category18=1
	categories=%categories%;18
if category41=1
	categories=%categories%;41
if category23=1
	categories=%categories%;23
if category25=1
	categories=%categories%;25
if category27=1
	categories=%categories%;27
if category28=1
	categories=%categories%;28
if category40=1
	categories=%categories%;40
if category32=1
	categories=%categories%;32
if category33=1
	categories=%categories%;33
if category35=1
	categories=%categories%;35

if limitraw=1
	limit=25
if limitraw=2
	limit=50
if limitraw=3
	limit=100

if srchmoderaw=1
	srchmode=search
if srchmoderaw=2
	srchmode=imdb
if srchmoderaw=3
	srchmode=tvdb

;MsgBox, Link: %address%%searchstr%&?category=%categories%&limit=%limit%

If categories!=0
	StringTrimLeft, categories, categories, 2	;removes the default 0 category
Clipboard=%address%/%srchmode%/%searchstr%?category=%categories%&limit=%limit%
GuiControl,,lastlink, %address%/%srchmode%/%searchstr%?category=%categories%&&limit=%limit% ;updates the link line in GUI, double && to display in GUI text properly
return

ButtonRunlink:
Run, %Clipboard%
return

Check_All:
GuiControlGet, Check_All,, Check_All

If(Check_All == 1)

   Loop, 20

      GuiControl,,Button%A_Index%, 1
	  
If(Check_All == 0)

   Loop, 20

      GuiControl,,Button%A_Index%, 0
return

ButtonAbout:
Gui, 99:+AlwaysOnTop
Gui, 99:Margin,20,10
Gui, 99:Font, bold
Gui, 99:Add, Text,, %appname% %ver%
Gui, 99:Font, CBlue Underline
Gui, 99:Add, Text,y+5 GGITRARBGRSSGEN, github.com/c0ldpower/rarbgrssgen
Gui, 99:Font
Gui, 99:Add, Text,, The script generates link for search with RSS for RarBG
Gui, 99:Add, Text,y+10, Just enter search term, optional categories and results limit
Gui, 99:Add, Text,y+10, If no category is selected, category will be 0 and default to all categories
Gui, 99:Add, Text,y+10, Setup the server address in Setup menu if different than the default localhost:4444
Gui, 99:Add, Text,y+10, Get link (AltG) button generates link and automatically copies it into Clipboard 
Gui, 99:Add, Text,y+10, Run link (Alt+R) button will open the last generated link in the default browser.
Gui, 99:Add, Text,y+10, This generator is compatible with the awsome script found here:
Gui, 99:Font, CBlue Underline
Gui, 99:Add, Text,y+5 GGITRARBGRSS, github.com/banteg/rarbg
Gui, 99:Font
Gui, 99:Show,, About
return

GITRARBGRSS:
  Run,https://github.com/banteg/rarbg,,UseErrorLevel
Return

GITRARBGRSSGEN:
  Run,https://github.com/c0ldpower/rarbgrssgen,,UseErrorLevel
Return

99GuiEscape:
99GuiClose:
Gui, 99:Destroy
return

GuiClose:
;GuiEscape:
ExitApp