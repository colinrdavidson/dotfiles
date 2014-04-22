import XMonad

import XMonad.Actions.UpdatePointer
import XMonad.Actions.CycleWS

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook

import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Scratchpad

import XMonad.Prompt
import XMonad.Prompt.Shell

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.IO (hPutStrLn)
import GHC.IOBase (Handle)

main = do 
		xmobar <- spawnPipe "xmobar"
		xmonad $ defaultConfig
			{ borderWidth        = 2
			, terminal           = "urxvt"
			, normalBorderColor  = backgroundColor
			, focusedBorderColor = focusColor
			, workspaces = myWorkspaces 
			, manageHook = manageDocks <+> scratchpadManageHook (W.RationalRect 0.2 0.2 0.6 0.5) <+> composeOne [ isFullscreen -?> doFullFloat ] <+> (className =? "trayer" --> doIgnore)
			, keys = \c -> myKeys c `M.union` keys defaultConfig c
			, logHook = dynamicLogWithPP (myPP xmobar) >> updatePointer (Relative 0.9 0.9)
      , layoutHook = avoidStruts  $  layoutHook defaultConfig
			}
			where

				myWorkspaces = ["ONE ", " TWO ", " THREE ", " FOUR ", " FIVE "]

				myFont = "xft:DejaVu Sans:size=10"
				focusColor = "#535d6c"
				textColor = "#aaaaaa"
				lightTextColor = "#fffff0"
				backgroundColor = "#222222"
				lightBackgroundColor = "#81bef7"
				urgentColor = "#ffc000"

				myPP :: Handle -> PP
				myPP din = defaultPP
					{ ppCurrent = xmobarColor lightTextColor ""
					, ppVisible = xmobarColor focusColor ""
					, ppHiddenNoWindows = xmobarColor lightBackgroundColor ""
					, ppUrgent = xmobarColor urgentColor ""
					, ppSep = " · "
					, ppWsSep = ""
					, ppTitle = xmobarColor lightTextColor ""
					, ppOutput = hPutStrLn din
				}

				myKeys conf@(XConfig {XMonad.modMask = modMask, workspaces = ws }) = M.fromList $
					[ ((modMask                , xK_q), recompile True >> restart "xmonad" True)
					, ((modMask                , xK_p), shellPrompt defaultXPConfig)
					, ((modMask                , xK_Escape), toggleWS)
					, ((modMask .|. controlMask, xK_j), nextScreen)
					, ((modMask .|. controlMask, xK_k), prevScreen)
					, ((modMask                , xK_o), shiftNextScreen >> nextScreen)
					, ((modMask .|. shiftMask  , xK_r), scratchpadSpawnActionTerminal "urxvt")
					, ((modMask                , xK_b), sendMessage ToggleStruts)
					]
