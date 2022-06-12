//
//  ApplicationControl.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-08.
//

import Foundation
import UIKit

struct ApplicationControl {
    
    // Check with app scope and update values below
    static let appLoginType: LoginType = .Email_Password
    static let appMainInterfaceType: MainInterfaceType = .TabBarNavigations
    static let appResetPassswordType: ResetPassswordType = .Email
    static let appChangePassswordType: ChangePassswordType = .CurrentPassword_NewPassword
    
}

public enum LoginType {
    case Email_Password
    case Username_Password
    case Mobile_Password
    case Mobile_OTP
}

public enum ResetPassswordType {
    case Email
    case Username
    case Mobile
}

public enum ChangePassswordType {
    case CurrentPassword_NewPassword
    case Token_NewPassword
}

public enum MainInterfaceType {
    case Main
    case SideMenuNavigations
    case TabBarNavigations
    case Custom
}
