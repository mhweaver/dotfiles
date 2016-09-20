import XMonad                       hiding ( (|||) )
import XMonad.Util.Run                     ( hPutStrLn
                                           , spawnPipe )
import Data.List.Utils                     ( replace ) -- From the MissingH package
import XMonad.Hooks.DynamicLog             ( dynamicLogWithPP
                                           , defaultPP
                                           , ppOutput
                                           , ppTitle
                                           , ppSep
                                           , ppCurrent
                                           , ppUrgent
                                           , ppHidden
                                           , ppSort
                                           , shorten
                                           , ppLayout
                                           , ppVisible
                                           , wrap )
import System.Exit                         ( exitWith
                                           , ExitCode(ExitSuccess) )
import Data.List                           ( isPrefixOf )
import Data.Char                           ( toLower )
import XMonad.Layout.Reflect               ( REFLECTX(REFLECTX) )
import XMonad.Layout.LayoutCombinators     ( (|||) )
import XMonad.Hooks.ManageDocks            ( ToggleStruts(ToggleStruts)
                                           , avoidStruts
                                           , manageDocks
                                           , docksEventHook )
import XMonad.Hooks.SetWMName              ( setWMName )
import XMonad.Actions.CycleWS              ( shiftNextScreen
                                           , shiftPrevScreen )
import XMonad.Layout.WindowNavigation      ( Navigate(Go, Swap)
                                           , windowNavigation )
import XMonad.Actions.Promote              ( promote )
import XMonad.Actions.CopyWindow           ( copy
                                           , killAllOtherCopies )
import XMonad.Layout.SubLayouts            ( pullGroup
                                           , GroupMsg(UnMerge)
                                           , defaultSublMap
                                           , subTabbed )
import XMonad.Actions.Submap               ( submap )
import XMonad.Layout.BoringWindows         ( focusDown
                                           , focusUp
                                           , boringWindows )
import XMonad.Layout.Tabbed                ( simpleTabbed
                                           , Direction2D(U, D, L, R) )
import XMonad.Hooks.EwmhDesktops           ( ewmhDesktopsEventHook )
import XMonad.Layout.MultiToggle           ( Toggle(Toggle)
                                           , mkToggle
                                           , single )
import XMonad.Layout.MultiToggle.Instances ( StdTransformers(FULL) )
import XMonad.Util.NamedWindows            ( getName )

import XMonad.Hooks.UrgencyHook
import XMonad.Util.Loggers
import XMonad.Util.WorkspaceCompare
import XMonad.Actions.GridSelect
import Data.Maybe
import Data.List

import qualified XMonad.Layout.Magnifier as Mag

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myKeys conf@(XConfig {XMonad.modMask = modm}) = 
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return  ), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_KP_Enter), spawn $ XMonad.terminal conf)

    -- Launch launchers
    , ((modm,               xK_p     ), spawn "dmenu_run")
    , ((modm,               xK_d     ), spawn "rofi -show run")
    , ((modm .|. shiftMask, xK_d     ), spawn "rofi -show drun")

    , ((modm .|. shiftMask, xK_c     ), kill)

    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Toggle layout transformers
    , ((modm,                xK_f    ), sendMessage $ Toggle FULL)
    , ((modm .|. shiftMask,  xK_f    ), sendMessage $ Toggle REFLECTX)
    , ((modm .|. shiftMask,  xK_m    ), sendMessage Mag.Toggle)

    , ((modm,               xK_n     ), refresh)

    -- Grid select bindings
    , ((modm,               xK_Tab   ), goToSelected defaultGSConfig)
    , ((modm .|. shiftMask, xK_Tab   ), gridselectWorkspace defaultGSConfig $ \i -> W.view i . W.shift i)

    -- Window navigation
    , ((modm,               xK_j       ), focusDown            )
    , ((modm,               xK_k       ), focusUp              )
    , ((modm,               xK_m       ), windows W.focusMaster)
    , ((modm,               xK_Return  ), windows W.swapMaster )
    , ((modm,               xK_KP_Enter), windows W.swapMaster )
    , ((modm .|. shiftMask, xK_j       ), windows W.swapDown   )
    , ((modm .|. shiftMask, xK_k       ), windows W.swapUp     )
    , ((modm,               xK_t       ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma   ), sendMessage $ IncMasterN 1)
    , ((modm              , xK_period  ), sendMessage $ IncMasterN (-1))

    -- Resizing
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Manage xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Lock the screen
    , ((modm .|. controlMask, xK_l   ), spawn "lock")

    -- Send active window to workspace on other screen
    , ((modm .|. shiftMask .|. controlMask, xK_Right), shiftNextScreen)
    , ((modm .|. shiftMask .|. controlMask, xK_Left) , shiftPrevScreen)

    -- Promote the current window to master to swap the first slave with master
    , ((modm .|. controlMask, xK_Return  ), promote)
    , ((modm .|. controlMask, xK_KP_Enter), promote)

    -- WindowNavigation bindings
    , ((modm,                 xK_Right), sendMessage $ Go R)
    , ((modm,                 xK_Left ), sendMessage $ Go L)
    , ((modm,                 xK_Up   ), sendMessage $ Go U)
    , ((modm,                 xK_Down ), sendMessage $ Go D)

    , ((modm .|. shiftMask, xK_Right), sendMessage $ Swap R)
    , ((modm .|. shiftMask, xK_Left ), sendMessage $ Swap L)
    , ((modm .|. shiftMask, xK_Up   ), sendMessage $ Swap U)
    , ((modm .|. shiftMask, xK_Down ), sendMessage $ Swap D)

    -- Sublayout bindings
    , ((modm .|. controlMask, xK_Right), sendMessage $ pullGroup R)
    , ((modm .|. controlMask, xK_Left ), sendMessage $ pullGroup L)
    , ((modm .|. controlMask, xK_Up   ), sendMessage $ pullGroup U)
    , ((modm .|. controlMask, xK_Down ), sendMessage $ pullGroup D)

    , ((modm                , xK_a    ), withFocused $ sendMessage . UnMerge)
    , ((modm                , xK_s    ), submap $ defaultSublMap conf)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- mod-control-[1..9], Copy client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k, n) <- zip3 (XMonad.workspaces conf) [xK_1..] [1..]
        , (f, m)    <- [ (W.greedyView , 0    ) -- mod-N
                       , (W.shift, shiftMask  ) -- mod-shift
                       , (copy   , controlMask) -- mod-control
                       ]
    ]
    ++
    -- Remove the current window from all other workspaces
    -- (this binding is down here to keep it with the other workspace-related bindings)
    ((modm,       xK_v), killAllOtherCopies)
    :

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc, keyCh) <- zip3 [xK_w, xK_e, xK_r] [0..] ['w', 'e', 'r']
        , (f, m)           <- [ (W.view, 0         )
                              , (W.shift, shiftMask)
                              ]
    ]

------------------------------------------------------------------------
-- Layouts:
myLayout = id
    . windowNavigation           -- Easy window navigation
    . subTabbed                  -- Tabbed sublayouts = all kinds of buggy fun
    . boringWindows              -- Skip over hidden windows (e.g., hidden subtabs)
    . avoidStruts                -- Don't cover docked windows
    . mkToggle (single FULL)     -- Toggle full screen
    . mkToggle (single REFLECTX) -- Toggle flipping the layout
    . Mag.magnifiercz' 1.5
    $ tiled ||| simpleTabbed ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 2/3

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = manageDocks

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = docksEventHook <+> ewmhDesktopsEventHook

------------------------------------------------------------------------
-- Status bars and logging
myLogHookPP stdOutProc color =
    defaultPP { ppOutput = hPutStrLn stdOutProc
              , ppCurrent = color "#ffff00" "" . wrap "[" "]"
              , ppUrgent = color "#ff0000" "#ffff00"
              , ppTitle = const "" 
              , ppSep = " : "
              , ppSort = getSortByXineramaRule
              , ppLayout = const ""
              , ppVisible = color "#999999" "" . wrap "(" ")"
              }

lemonbarColor :: String -- ^ foreground color
              -> String -- ^ background color
              -> String -- ^ input string to color
              -> String -- ^ colored output
lemonbarColor fg bg = wrap (fg1++bg1) (fg2++bg2)
    where (fg1,fg2) | null fg  = ("","")
                    | otherwise = ("%{F" ++ fg ++ "}", "%{F-}")
          (bg1,bg2) | null bg = ("", "")
                    | otherwise = ("%{B" ++ bg ++ "}", "%{B-}")
lemonbarStrip       = replace "%{" "%%{"
lemonbarTag tag     = ((wrap "%{" "}" tag) ++)
lemonbarCenter      = lemonbarTag "c"
lemonbarLeft        = lemonbarTag "l"
lemonbarScreen sid  = lemonbarTag $ "S" ++ show sid

myTitleLogHook :: (String -> IO ()) -> X ()
myTitleLogHook output = do
    winset        <- gets windowset
    currentTitle  <- maybe (return "") (fmap show . getName) . W.peek $ winset

    let screenOut screen = lemonbarScreen sid $ pp workspaceName layout
            where sid           = (\(S s) -> s) . W.screen $ screen
                  layout        = description . W.layout . W.workspace $ screen
                  workspaceName = fromMaybe "no workspaceName found" $ W.lookupWorkspace (W.screen screen) winset

        pp workspaceName layout = lemonbarLeft left ++ lemonbarCenter center
            where (left, center) = if currentTag == workspaceName 
                                   then (ppCurrent workspaceName 
                                         ++ " : " ++ ppLayout "#ffffff" layout
                                        , ppTitle currentTitle)
                                   else (ppVisible workspaceName 
                                         ++ " : " ++ ppLayout "#bbbbbb" layout
                                        , "")
                                   where currentTag = W.currentTag winset
                  ppTitle   = lemonbarColor "#00ff00" "" . lemonbarStrip
                  ppCurrent = lemonbarColor "#ffff00" "" . wrap "[" "]"
                  ppVisible = lemonbarColor "#999999" "" . wrap "(" ")"
                  ppLayout color = lemonbarColor color "" . abbreviateLayoutName
                  abbreviateLayoutName = unwords 
                                       . abbreviateName
                                       . removePrefix "tabbed"
                                       . filter allowedInLayoutName
                                       . words
                                       . map toLower 
                  abbreviateName [] = []
                  abbreviateName ("reflectx":rest)          = "flipped" : abbreviateName rest
                  abbreviateName ("mirror":"tall":rest)     = "wide"    : abbreviateName rest
                  abbreviateName ("tabbed":"simplest":rest) = "tabbed"  : abbreviateName rest
                  abbreviateName name = name
                  allowedInLayoutName "magnifier" = False
                  allowedInLayoutName "nomaster"  = False
                  allowedInLayoutName "(off)"     = False
                  allowedInLayoutName _           = True
                  removePrefix prefix xs = case xs of
                                              (prefix:rest) -> rest
                                              _             -> xs

    let outStr = return . concat . map screenOut $ W.screens winset
    outStr >>= io . output

myLogHook lemonbarproc titleproc = do
    dynamicLogWithPP $ myLogHookPP lemonbarproc lemonbarColor
    myTitleLogHook $ hPutStrLn titleproc

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
myStartupHook = setWMName "LG3D"

------------------------------------------------------------------------
-- Start up xmonad 
main = do
    let lemonbarPrefs = " -U '#000000' -B '#000000' -F '#dddddd' -f 'DejaVu Sans Mono for Powerline:pixelsize=13:bold' -f 'FontAwesome'"
        trayerPrefs   = " --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype percent --width 5 --transparent true --tint 0x000000 --height 17"

    lemonbarproc <- spawnPipe $ "gostatus | lemonbar -b -u 3" ++ lemonbarPrefs
    titleproc    <- spawnPipe $ "lemonbar" ++ lemonbarPrefs
    spawn                     $ "killall trayer; trayer" ++ trayerPrefs

    xmonad 
        $ withUrgencyHookC 
            BorderUrgencyHook 
                { urgencyBorderColor = "#ff0000" } 
            urgencyConfig 
                { 
                  suppressWhen = Focused,
                  remindWhen   = Every 60
                } 
        $ defaultConfig
             {
               -- simple stuff
                 terminal           = "st",
                 focusFollowsMouse  = False,
                 clickJustFocuses   = False,
                 borderWidth        = 2,
                 modMask            = mod4Mask,
                 workspaces         = ["1:main","2:ide","3:term","4:misc","5","6","7","8","9"],
                 normalBorderColor  = "#555555",
                 focusedBorderColor = "#bb0000",

               -- key bindings
                 keys               = M.fromList . myKeys,

               -- hooks, layouts
                 layoutHook         = myLayout,
                 manageHook         = myManageHook,
                 handleEventHook    = myEventHook,
                 logHook            = myLogHook lemonbarproc titleproc,
                 startupHook        = myStartupHook
             }

