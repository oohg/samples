/*
 * Execute File Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to send a WhastApp message.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include 'oohg.ch'

FUNCTION Main()

   DEFINE WINDOW MainForm ;
      AT 114,218 ;
      WIDTH 534 ;
      HEIGHT 276 ;
      TITLE 'OOHG - How to send a WhatsApp message' ;
      MAIN

      @ 20,20 BUTTON btn_1 ;
         CAPTION 'Send' ;
         ACTION ExecBAT()

      ON KEY ESCAPE ACTION MainForm.Release
   END WINDOW

   MainForm.Center
   MainForm.Activate

RETURN NIL

FUNCTION ExecBAT()

   IF ! FILE( "send.vbs" )
      hb_MemoWrit( "send.bat", ;
                   "@echo off" + CRLF + ;
                   "echo Executing .bat file ...." + CRLF + ;
                   "copy send.txt xxx.txt" + CRLF + ;
                   "ren xxx.txt send.vbs" + CRLF + ;
                   "send.vbs" + CRLF + ;
                   "exit" + CRLF )
   ENDIF

   IF ! FILE( "send.txt" )
      hb_MemoWrit( "send.txt", ;
                   "' Based on original script from https://github.com/Gotham13121997/whatsapp-ddos/blob/master/vv.vbs" + CRLF + ;
                   CRLF + ;
                   "' InputBoxes" + CRLF + ;
                   'Contact = InputBox("Contact?","Send WhatsApp")' + CRLF + ;
                   'Message = InputBox("Message?","Send WhatsApp")' + CRLF + ;
                   CRLF + ;
                   "' Go To WhatsApp" + CRLF + ;
                   CRLF + ;
                   'Set WshShell = WScript.CreateObject("WScript.Shell")' + CRLF + ;
                   'Return = WshShell.Run("https://web.whatsapp.com/", 1)' + CRLF + ;
                   CRLF + ;
                   "' Loading Time" + CRLF + ;
                   CRLF + ;
                   'If MsgBox("Is WhatsApp loaded?" & vbNewLine & vbNewLine & "Press No to cancel", vbYesNo + vbQuestion + vbSystemModal, "Send WhatsApp") = vbYes Then' + CRLF + ;
                   CRLF + ;
                   "' Go To The WhatsApp Search Bar" + CRLF + ;
                   "WScript.Sleep 50" + CRLF + ;
                   'WshShell.SendKeys "{TAB}"' + CRLF + ;
                   "WScript.Sleep 50" + CRLF + ;
                   CRLF + ;
                   "' Go To The Contacts Chat" + CRLF + ;
                   "WshShell.SendKeys Contact" + CRLF + ;
                   "WScript.Sleep 100" + CRLF + ;
                   'WshShell.SendKeys "{ENTER}"' + CRLF + ;
                   "WScript.Sleep 200" + CRLF + ;
                   CRLF + ;
                   "' Send message" + CRLF + ;
                   "WshShell.SendKeys Message" + CRLF + ;
                   "WScript.Sleep 5" + CRLF + ;
                   'WshShell.SendKeys "{ENTER}"' + CRLF + ;
                   CRLF + ;
                   "' End Of The Script" + CRLF + ;
                   "WScript.Sleep 3000" + CRLF + ;
                   'MsgBox "Script Ended", 1024 + vbSystemModal, "Message was sent!"' + CRLF + ;
                   CRLF + ;
                   "Else" + CRLF + ;
                   CRLF + ;
                   'MsgBox "Script Canceled", vbSystemModal, "WhatsApp is not loaded!"' + CRLF + ;
                   CRLF + ;
                   "End If" + CRLF )
   ENDIF

   // For WIN 7 & 10 because sometimse file operations are delayed
   hb_idleSleep( 3 )

   EXECUTE FILE 'CMD.EXE' PARAMETERS '/C send.bat' HIDE

RETURN NIL

/*
 * EOF
 */
