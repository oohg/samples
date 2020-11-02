/*
 * Windows Api Sample # 3
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to get Windows "Known Folders".
 * See https://docs.microsoft.com/en-us/windows/win32/shell/knownfolderid
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"
#include "i_windefs.ch"

FUNCTION Main

   LOCAL cMemo := "", cPath, i, k := 0
   LOCAL cPathNames := { "AccountPictures       ", "AddNewPrograms        ", "AdminTools            ", "AppsFolder            ", ;
                         "ApplicationShortcuts  ", "AppUpdates            ", "CDBurning             ", "ChangeRemovePrograms  ", ;
                         "CommonAdminTools      ", "CommonOEMLinks        ", "CommonPrograms        ", "CommonStartMenu       ", ;
                         "CommonStartup         ", "CommonTemplates       ", "ComputerFolder        ", "ConflictFolder        ", ;
                         "ConnectionsFolder     ", "Contacts              ", "ControlPanelFolder    ", "Cookies               ", ;
                         "Desktop               ", "DeviceMetadataStore   ", "Documents             ", "DocumentsLibrary      ", ;
                         "Downloads             ", "Favorites             ", "Fonts                 ", "Games                 ", ;
                         "GameTasks             ", "History               ", "HomeGroup             ", "HomeGroupCurrentUser  ", ;
                         "ImplicitAppShortcuts  ", "InternetCache         ", "InternetFolder        ", "Libraries             ", ;
                         "Links                 ", "LocalAppData          ", "LocalAppDataLow       ", "LocalizedResourcesDir ", ;
                         "Music                 ", "MusicLibrary          ", "NetHood               ", "NetworkFolder         ", ;
                         "OriginalImages        ", "PhotoAlbums           ", "Pictures              ", "PicturesLibrary       ", ;
                         "Playlists             ", "PrintHood             ", "PrintersFolder        ", "Profile               ", ;
                         "ProgramData           ", "ProgramFiles          ", "ProgramFilesX64       ", "ProgramFilesX86       ", ;
                         "ProgramFilesCommon    ", "ProgramFilesCommonX64 ", "ProgramFilesCommonX86 ", "Programs              ", ;
                         "Public                ", "PublicDesktop         ", "PublicDocuments       ", "PublicDownloads       ", ;
                         "PublicGameTasks       ", "PublicLibraries       ", "PublicMusic           ", "PublicPictures        ", ;
                         "PublicRingtones       ", "PublicUserTiles       ", "PublicVideos          ", "QuickLaunch           ", ;
                         "Recent                ", "RecordedTVLibrary     ", "RecycleBinFolder      ", "ResourceDir           ", ;
                         "Ringtones             ", "RoamingAppData        ", "RoamingTiles          ", "RoamedTileImages      ", ;
                         "SampleMusic           ", "SamplePictures        ", "SamplePlaylists       ", "SampleVideos          ", ;
                         "SavedGames            ", "SavedSearches         ", "Screenshots           ", "SEARCH_MAPI           ", ;
                         "SEARCH_CSC            ", "SearchHome            ", "SendTo                ", "SidebarDefaultParts   ", ;
                         "SidebarParts          ", "StartMenu             ", "Startup               ", "SyncManagerFolder     ", ;
                         "SyncResultsFolder     ", "SyncSetupFolder       ", "System                ", "SystemX86             ", ;
                         "Templates             ", "UserPinned            ", "UserProfiles          ", "UserProgramFiles      ", ;
                         "UserProgramFilesCommon", "UsersFiles            ", "UsersLibraries        ", "Videos                ", ;
                         "VideosLibrary         ", "Windows               " }

   FOR i := 1 to KNOWN_FOLDERS_COUNT
      cPath := GetKnownFolder( i )
      IF Empty( cPath )
         cPath := "Not defined."
      ELSE
         k ++
      ENDIF
      cMemo += Str( i, 3, 0 ) + " - " + cPathNames[ i ] + ": " +  cPath + CRLF
   NEXT i

   hb_MemoWrit( "KnownFolders.txt", cMemo )

   AutoMsgBox( LTrim( Str( k ) ) + " Known Folders found!" + CRLF + 'See file "KnownFolders.txt"' )

RETURN NIL

/*
 * EOF
 */
