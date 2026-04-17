//
//  CBKeyboardHIDUsage.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 14.02.25.
//

#if canImport(UIKit)
import UIKit

public typealias CBKeyboardHIDUsage = UIKeyboardHIDUsage

#else

import AppKit
import Carbon.HIToolbox

public enum CBKeyboardHIDUsage: UInt16, @unchecked Sendable {
    case keyboardErrorRollOver = 1
    case keyboardPOSTFail = 2
    case keyboardErrorUndefined = 3
    case keyboardA = 4
    case keyboardB = 5
    case keyboardC = 6
    case keyboardD = 7
    case keyboardE = 8
    case keyboardF = 9
    case keyboardG = 10
    case keyboardH = 11
    case keyboardI = 12
    case keyboardJ = 13
    case keyboardK = 14
    case keyboardL = 15
    case keyboardM = 16
    case keyboardN = 17
    case keyboardO = 18
    case keyboardP = 19
    case keyboardQ = 20
    case keyboardR = 21
    case keyboardS = 22
    case keyboardT = 23
    case keyboardU = 24
    case keyboardV = 25
    case keyboardW = 26
    case keyboardX = 27
    case keyboardY = 28
    case keyboardZ = 29
    case keyboard1 = 30
    case keyboard2 = 31
    case keyboard3 = 32
    case keyboard4 = 33
    case keyboard5 = 34
    case keyboard6 = 35
    case keyboard7 = 36
    case keyboard8 = 37
    case keyboard9 = 38
    case keyboard0 = 39
    case keyboardReturnOrEnter = 40
    case keyboardEscape = 41
    case keyboardDeleteOrBackspace = 42
    case keyboardTab = 43
    case keyboardSpacebar = 44
    case keyboardHyphen = 45
    case keyboardEqualSign = 46
    case keyboardOpenBracket = 47
    case keyboardCloseBracket = 48
    case keyboardBackslash = 49
    case keyboardNonUSPound = 50
    case keyboardSemicolon = 51
    case keyboardQuote = 52
    case keyboardGraveAccentAndTilde = 53
    case keyboardComma = 54
    case keyboardPeriod = 55
    case keyboardSlash = 56
    case keyboardCapsLock = 57
    case keyboardF1 = 58
    case keyboardF2 = 59
    case keyboardF3 = 60
    case keyboardF4 = 61
    case keyboardF5 = 62
    case keyboardF6 = 63
    case keyboardF7 = 64
    case keyboardF8 = 65
    case keyboardF9 = 66
    case keyboardF10 = 67
    case keyboardF11 = 68
    case keyboardF12 = 69
    case keyboardPrintScreen = 70
    case keyboardScrollLock = 71
    case keyboardPause = 72
    case keyboardInsert = 73
    case keyboardHome = 74
    case keyboardPageUp = 75
    case keyboardDeleteForward = 76
    case keyboardEnd = 77
    case keyboardPageDown = 78
    case keyboardRightArrow = 79
    case keyboardLeftArrow = 80
    case keyboardDownArrow = 81
    case keyboardUpArrow = 82
    case keypadNumLock = 83
    case keypadSlash = 84
    case keypadAsterisk = 85
    case keypadHyphen = 86
    case keypadPlus = 87
    case keypadEnter = 88
    case keypad1 = 89
    case keypad2 = 90
    case keypad3 = 91
    case keypad4 = 92
    case keypad5 = 93
    case keypad6 = 94
    case keypad7 = 95
    case keypad8 = 96
    case keypad9 = 97
    case keypad0 = 98
    case keypadPeriod = 99
    case keyboardNonUSBackslash = 100
    case keyboardApplication = 101
    case keyboardPower = 102
    case keypadEqualSign = 103
    case keyboardF13 = 104
    case keyboardF14 = 105
    case keyboardF15 = 106
    case keyboardF16 = 107
    case keyboardF17 = 108
    case keyboardF18 = 109
    case keyboardF19 = 110
    case keyboardF20 = 111
    case keyboardF21 = 112
    case keyboardF22 = 113
    case keyboardF23 = 114
    case keyboardF24 = 115
    case keyboardExecute = 116
    case keyboardHelp = 117
    case keyboardMenu = 118
    case keyboardSelect = 119
    case keyboardStop = 120
    case keyboardAgain = 121
    case keyboardUndo = 122
    case keyboardCut = 123
    case keyboardCopy = 124
    case keyboardPaste = 125
    case keyboardFind = 126
    case keyboardMute = 127
    case keyboardVolumeUp = 128
    case keyboardVolumeDown = 129
    case keyboardLockingCapsLock = 130
    case keyboardLockingNumLock = 131
    case keyboardLockingScrollLock = 132
    case keypadComma = 133
    case keypadEqualSignAS400 = 134
    case keyboardInternational1 = 135
    case keyboardInternational2 = 136
    case keyboardInternational3 = 137
    case keyboardInternational4 = 138
    case keyboardInternational5 = 139
    case keyboardInternational6 = 140
    case keyboardInternational7 = 141
    case keyboardInternational8 = 142
    case keyboardInternational9 = 143
    case keyboardLANG1 = 144
    case keyboardLANG2 = 145
    case keyboardLANG3 = 146
    case keyboardLANG4 = 147
    case keyboardLANG5 = 148
    case keyboardLANG6 = 149
    case keyboardLANG7 = 150
    case keyboardLANG8 = 151
    case keyboardLANG9 = 152
    case keyboardAlternateErase = 153
    case keyboardSysReqOrAttention = 154
    case keyboardCancel = 155
    case keyboardClear = 156
    case keyboardPrior = 157
    case keyboardReturn = 158
    case keyboardSeparator = 159
    case keyboardOut = 160
    case keyboardOper = 161
    case keyboardClearOrAgain = 162
    case keyboardCrSelOrProps = 163
    case keyboardExSel = 164
    case keyboardLeftControl = 224
    case keyboardLeftShift = 225
    case keyboardLeftAlt = 226
    case keyboardLeftGUI = 227
    case keyboardRightControl = 228
    case keyboardRightShift = 229
    case keyboardRightAlt = 230
    case keyboardRightGUI = 231
    case keyboard_Reserved = 65535
    
    init?(keyCode: UInt16) {
        switch Int(keyCode) {
        case kVK_ANSI_A: self = .keyboardA
        case kVK_ANSI_B: self = .keyboardB
        case kVK_ANSI_C: self = .keyboardC
        case kVK_ANSI_D: self = .keyboardD
        case kVK_ANSI_E: self = .keyboardE
        case kVK_ANSI_F: self = .keyboardF
        case kVK_ANSI_G: self = .keyboardG
        case kVK_ANSI_H: self = .keyboardH
        case kVK_ANSI_I: self = .keyboardI
        case kVK_ANSI_J: self = .keyboardJ
        case kVK_ANSI_K: self = .keyboardK
        case kVK_ANSI_L: self = .keyboardL
        case kVK_ANSI_M: self = .keyboardM
        case kVK_ANSI_N: self = .keyboardN
        case kVK_ANSI_O: self = .keyboardO
        case kVK_ANSI_P: self = .keyboardP
        case kVK_ANSI_Q: self = .keyboardQ
        case kVK_ANSI_R: self = .keyboardR
        case kVK_ANSI_S: self = .keyboardS
        case kVK_ANSI_T: self = .keyboardT
        case kVK_ANSI_U: self = .keyboardU
        case kVK_ANSI_V: self = .keyboardV
        case kVK_ANSI_W: self = .keyboardW
        case kVK_ANSI_X: self = .keyboardX
        case kVK_ANSI_Y: self = .keyboardY
        case kVK_ANSI_Z: self = .keyboardZ
            
        case kVK_ANSI_0: self = .keyboard0
        case kVK_ANSI_1: self = .keyboard1
        case kVK_ANSI_2: self = .keyboard2
        case kVK_ANSI_3: self = .keyboard3
        case kVK_ANSI_4: self = .keyboard4
        case kVK_ANSI_5: self = .keyboard5
        case kVK_ANSI_6: self = .keyboard6
        case kVK_ANSI_7: self = .keyboard7
        case kVK_ANSI_8: self = .keyboard8
        case kVK_ANSI_9: self = .keyboard9
            
        case kVK_LeftArrow: self = .keyboardLeftArrow
        case kVK_RightArrow: self = .keyboardRightArrow
        case kVK_UpArrow: self = .keyboardUpArrow
        case kVK_DownArrow: self = .keyboardDownArrow
            
        case kVK_ANSI_Equal: self = .keyboardEqualSign
        case kVK_ANSI_Minus: self = .keypadHyphen
        case kVK_ANSI_RightBracket: self = .keyboardOpenBracket
        case kVK_ANSI_LeftBracket: self = .keyboardCloseBracket
        case kVK_ANSI_Quote: self = .keyboardQuote
        case kVK_ANSI_Semicolon: self = .keyboardSemicolon
        case kVK_ANSI_Backslash: self = .keyboardBackslash
        case kVK_ANSI_Comma: self = .keyboardComma
        case kVK_ANSI_Slash: self = .keyboardSlash
        case kVK_ANSI_Period: self = .keyboardPeriod
        case kVK_ANSI_Grave: self = .keyboardGraveAccentAndTilde
            
        case kVK_ANSI_KeypadDecimal: self = .keypadPeriod
        case kVK_ANSI_KeypadPlus: self = .keypadPlus
        case kVK_ANSI_KeypadMinus: self = .keypadHyphen
        case kVK_ANSI_KeypadDivide: self = .keypadSlash
        case kVK_ANSI_KeypadMultiply: self = .keypadAsterisk
        case kVK_ANSI_Keypad0: self = .keypad0
        case kVK_ANSI_Keypad1: self = .keypad1
        case kVK_ANSI_Keypad2: self = .keypad2
        case kVK_ANSI_Keypad3: self = .keypad3
        case kVK_ANSI_Keypad4: self = .keypad4
        case kVK_ANSI_Keypad5: self = .keypad5
        case kVK_ANSI_Keypad6: self = .keypad6
        case kVK_ANSI_Keypad7: self = .keypad7
        case kVK_ANSI_Keypad8: self = .keypad8
        case kVK_ANSI_Keypad9: self = .keypad9
            
        case kVK_F1: self = .keyboardF1
        case kVK_F2: self = .keyboardF2
        case kVK_F3: self = .keyboardF3
        case kVK_F4: self = .keyboardF4
        case kVK_F5: self = .keyboardF5
        case kVK_F6: self = .keyboardF6
        case kVK_F7: self = .keyboardF7
        case kVK_F8: self = .keyboardF8
        case kVK_F9: self = .keyboardF9
        case kVK_F10: self = .keyboardF10
        case kVK_F11: self = .keyboardF11
        case kVK_F12: self = .keyboardF12
        case kVK_F13: self = .keyboardF13
        case kVK_F14: self = .keyboardF14
        case kVK_F15: self = .keyboardF15
        case kVK_F16: self = .keyboardF16
        case kVK_F17: self = .keyboardF17
        case kVK_F18: self = .keyboardF18
        case kVK_F19: self = .keyboardF19
        case kVK_F20: self = .keyboardF20
            
        case kVK_PageUp: self = .keyboardPageUp
        case kVK_PageDown: self = .keyboardPageDown
        case kVK_Home: self = .keyboardHome
        case kVK_End: self = .keyboardEnd
        case kVK_Help: self = .keyboardHelp
        case kVK_Return: self = .keyboardReturn
        case kVK_Tab: self = .keyboardTab
        case kVK_Space: self = .keyboardSpacebar
        case kVK_Delete: self = .keyboardDeleteOrBackspace
        case kVK_ForwardDelete: self = .keyboardDeleteForward
        case kVK_Escape: self = .keyboardEscape
        case kVK_VolumeUp: self = .keyboardVolumeUp
        case kVK_VolumeDown: self = .keyboardVolumeDown
            
        default:
            return nil
        }
    }
}

#endif

extension CBKeyboardHIDUsage: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
        case .keyboardErrorRollOver: return "keyboardErrorRollOver"
        case .keyboardPOSTFail: return "keyboardPOSTFail"
        case .keyboardErrorUndefined: return "keyboardErrorUndefined"
        case .keyboardA: return "keyboardA"
        case .keyboardB: return "keyboardB"
        case .keyboardC: return "keyboardC"
        case .keyboardD: return "keyboardD"
        case .keyboardE: return "keyboardE"
        case .keyboardF: return "keyboardF"
        case .keyboardG: return "keyboardG"
        case .keyboardH: return "keyboardH"
        case .keyboardI: return "keyboardI"
        case .keyboardJ: return "keyboardJ"
        case .keyboardK: return "keyboardK"
        case .keyboardL: return "keyboardL"
        case .keyboardM: return "keyboardM"
        case .keyboardN: return "keyboardN"
        case .keyboardO: return "keyboardO"
        case .keyboardP: return "keyboardP"
        case .keyboardQ: return "keyboardQ"
        case .keyboardR: return "keyboardR"
        case .keyboardS: return "keyboardS"
        case .keyboardT: return "keyboardT"
        case .keyboardU: return "keyboardU"
        case .keyboardV: return "keyboardV"
        case .keyboardW: return "keyboardW"
        case .keyboardX: return "keyboardX"
        case .keyboardY: return "keyboardY"
        case .keyboardZ: return "keyboardZ"
        case .keyboard1: return "keyboard1"
        case .keyboard2: return "keyboard2"
        case .keyboard3: return "keyboard3"
        case .keyboard4: return "keyboard4"
        case .keyboard5: return "keyboard5"
        case .keyboard6: return "keyboard6"
        case .keyboard7: return "keyboard7"
        case .keyboard8: return "keyboard8"
        case .keyboard9: return "keyboard9"
        case .keyboard0: return "keyboard0"
        case .keyboardReturnOrEnter: return "keyboardReturnOrEnter"
        case .keyboardEscape: return "keyboardEscape"
        case .keyboardDeleteOrBackspace: return "keyboardDeleteOrBackspace"
        case .keyboardTab: return "keyboardTab"
        case .keyboardSpacebar: return "keyboardSpacebar"
        case .keyboardHyphen: return "keyboardHyphen"
        case .keyboardEqualSign: return "keyboardEqualSign"
        case .keyboardOpenBracket: return "keyboardOpenBracket"
        case .keyboardCloseBracket: return "keyboardCloseBracket"
        case .keyboardBackslash: return "keyboardBackslash"
        case .keyboardNonUSPound: return "keyboardNonUSPound"
        case .keyboardSemicolon: return "keyboardSemicolon"
        case .keyboardQuote: return "keyboardQuote"
        case .keyboardGraveAccentAndTilde: return "keyboardGraveAccentAndTilde"
        case .keyboardComma: return "keyboardComma"
        case .keyboardPeriod: return "keyboardPeriod"
        case .keyboardSlash: return "keyboardSlash"
        case .keyboardCapsLock: return "keyboardCapsLock"
        case .keyboardF1: return "keyboardF1"
        case .keyboardF2: return "keyboardF2"
        case .keyboardF3: return "keyboardF3"
        case .keyboardF4: return "keyboardF4"
        case .keyboardF5: return "keyboardF5"
        case .keyboardF6: return "keyboardF6"
        case .keyboardF7: return "keyboardF7"
        case .keyboardF8: return "keyboardF8"
        case .keyboardF9: return "keyboardF9"
        case .keyboardF10: return "keyboardF10"
        case .keyboardF11: return "keyboardF11"
        case .keyboardF12: return "keyboardF12"
        case .keyboardPrintScreen: return "keyboardPrintScreen"
        case .keyboardScrollLock: return "keyboardScrollLock"
        case .keyboardPause: return "keyboardPause"
        case .keyboardInsert: return "keyboardInsert"
        case .keyboardHome: return "keyboardHome"
        case .keyboardPageUp: return "keyboardPageUp"
        case .keyboardDeleteForward: return "keyboardDeleteForward"
        case .keyboardEnd: return "keyboardEnd"
        case .keyboardPageDown: return "keyboardPageDown"
        case .keyboardRightArrow: return "keyboardRightArrow"
        case .keyboardLeftArrow: return "keyboardLeftArrow"
        case .keyboardDownArrow: return "keyboardDownArrow"
        case .keyboardUpArrow: return "keyboardUpArrow"
        case .keypadNumLock: return "keypadNumLock"
        case .keypadSlash: return "keypadSlash"
        case .keypadAsterisk: return "keypadAsterisk"
        case .keypadHyphen: return "keypadHyphen"
        case .keypadPlus: return "keypadPlus"
        case .keypadEnter: return "keypadEnter"
        case .keypad1: return "keypad1"
        case .keypad2: return "keypad2"
        case .keypad3: return "keypad3"
        case .keypad4: return "keypad4"
        case .keypad5: return "keypad5"
        case .keypad6: return "keypad6"
        case .keypad7: return "keypad7"
        case .keypad8: return "keypad8"
        case .keypad9: return "keypad9"
        case .keypad0: return "keypad0"
        case .keypadPeriod: return "keypadPeriod"
        case .keyboardNonUSBackslash: return "keyboardNonUSBackslash"
        case .keyboardApplication: return "keyboardApplication"
        case .keyboardPower: return "keyboardPower"
        case .keypadEqualSign: return "keypadEqualSign"
        case .keyboardF13: return "keyboardF13"
        case .keyboardF14: return "keyboardF14"
        case .keyboardF15: return "keyboardF15"
        case .keyboardF16: return "keyboardF16"
        case .keyboardF17: return "keyboardF17"
        case .keyboardF18: return "keyboardF18"
        case .keyboardF19: return "keyboardF19"
        case .keyboardF20: return "keyboardF20"
        case .keyboardF21: return "keyboardF21"
        case .keyboardF22: return "keyboardF22"
        case .keyboardF23: return "keyboardF23"
        case .keyboardF24: return "keyboardF24"
        case .keyboardExecute: return "keyboardExecute"
        case .keyboardHelp: return "keyboardHelp"
        case .keyboardMenu: return "keyboardMenu"
        case .keyboardSelect: return "keyboardSelect"
        case .keyboardStop: return "keyboardStop"
        case .keyboardAgain: return "keyboardAgain"
        case .keyboardUndo: return "keyboardUndo"
        case .keyboardCut: return "keyboardCut"
        case .keyboardCopy: return "keyboardCopy"
        case .keyboardPaste: return "keyboardPaste"
        case .keyboardFind: return "keyboardFind"
        case .keyboardMute: return "keyboardMute"
        case .keyboardVolumeUp: return "keyboardVolumeUp"
        case .keyboardVolumeDown: return "keyboardVolumeDown"
        case .keyboardLockingCapsLock: return "keyboardLockingCapsLock"
        case .keyboardLockingNumLock: return "keyboardLockingNumLock"
        case .keyboardLockingScrollLock: return "keyboardLockingScrollLock"
        case .keypadComma: return "keypadComma"
        case .keypadEqualSignAS400: return "keypadEqualSignAS400"
        case .keyboardInternational1: return "keyboardInternational1"
        case .keyboardInternational2: return "keyboardInternational2"
        case .keyboardInternational3: return "keyboardInternational3"
        case .keyboardInternational4: return "keyboardInternational4"
        case .keyboardInternational5: return "keyboardInternational5"
        case .keyboardInternational6: return "keyboardInternational6"
        case .keyboardInternational7: return "keyboardInternational7"
        case .keyboardInternational8: return "keyboardInternational8"
        case .keyboardInternational9: return "keyboardInternational9"
        case .keyboardLANG1: return "keyboardLANG1"
        case .keyboardLANG2: return "keyboardLANG2"
        case .keyboardLANG3: return "keyboardLANG3"
        case .keyboardLANG4: return "keyboardLANG4"
        case .keyboardLANG5: return "keyboardLANG5"
        case .keyboardLANG6: return "keyboardLANG6"
        case .keyboardLANG7: return "keyboardLANG7"
        case .keyboardLANG8: return "keyboardLANG8"
        case .keyboardLANG9: return "keyboardLANG9"
        case .keyboardAlternateErase: return "keyboardAlternateErase"
        case .keyboardSysReqOrAttention: return "keyboardSysReqOrAttention"
        case .keyboardCancel: return "keyboardCancel"
        case .keyboardClear: return "keyboardClear"
        case .keyboardPrior: return "keyboardPrior"
        case .keyboardReturn: return "keyboardReturn"
        case .keyboardSeparator: return "keyboardSeparator"
        case .keyboardOut: return "keyboardOut"
        case .keyboardOper: return "keyboardOper"
        case .keyboardClearOrAgain: return "keyboardClearOrAgain"
        case .keyboardCrSelOrProps: return "keyboardCrSelOrProps"
        case .keyboardExSel: return "keyboardExSel"
        case .keyboardLeftControl: return "keyboardLeftControl"
        case .keyboardLeftShift: return "keyboardLeftShift"
        case .keyboardLeftAlt: return "keyboardLeftAlt"
        case .keyboardLeftGUI: return "keyboardLeftGUI"
        case .keyboardRightControl: return "keyboardRightControl"
        case .keyboardRightShift: return "keyboardRightShift"
        case .keyboardRightAlt: return "keyboardRightAlt"
        case .keyboardRightGUI: return "keyboardRightGUI"
        case .keyboard_Reserved: return "keyboard_Reserved"
        @unknown default:
            return "unknown"
        }
    }
    
}
