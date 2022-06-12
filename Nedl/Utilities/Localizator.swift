//
//  Localizator.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-08.
//

import Foundation

extension String {
    
    // Viewcontrollers
    static let SignInVC = NSLocalizedString("SignInVC", comment: "")
    static let SignUpVC = NSLocalizedString("SignUpVC", comment: "")
    static let ForgotPasswordVC = NSLocalizedString("ForgotPasswordVC", comment: "")
    static let HomeVC = NSLocalizedString("HomeVC", comment: "")
    static let LandingVC = NSLocalizedString("LandingVC", comment: "")
    static let NumberVC = NSLocalizedString("NumberVC", comment: "")
    static let VerificationCodeVC = NSLocalizedString("VerificationCodeVC", comment: "")
    static let UserUrlVC = NSLocalizedString("UserUrlVC", comment: "")
    static let SuccessVC = NSLocalizedString("SuccessVC", comment: "")
    static let ViewController = NSLocalizedString("ViewController", comment: "")
    static let AgoraAudioViewController = NSLocalizedString("AgoraAudioViewController", comment: "")
    static let BroadcastVC = NSLocalizedString("BroadcastVC", comment: "")
    static let OnAirVC = NSLocalizedString("OnAirVC", comment: "")
    static let CashOutVC = NSLocalizedString("CashOutVC", comment: "")
    static let NewUserLandingVC = NSLocalizedString("NewUserLandingVC", comment: "")
    static let LoungeVC = NSLocalizedString("LoungeVC", comment: "")
    static let CountDownTimerVC = NSLocalizedString("CountDownTimerVC", comment: "")
    
    // Top ViewControllers of the SB
    
    static let MainTBC = NSLocalizedString("MainTBC", comment: "")
    static let HomeNC = NSLocalizedString("HomeNC", comment: "")
    static let AuthNC = NSLocalizedString("AuthNC", comment: "")
    
    
    // ALERT MESSAGES
    // Local error messages
    static let ErrorCorrupted = NSLocalizedString("Error is corrupted.", comment: "")
    static let MissingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let AnyFieldEmpty = NSLocalizedString("All fields are required.", comment: "")
    static let MissingRequiredFields = NSLocalizedString("Missing some required fields.", comment: "")
    static let NameEmpty = NSLocalizedString("Please enter name.", comment: "")
    static let FirstNameEmpty = NSLocalizedString("Please enter first name.", comment: "")
    static let LastNameEmpty = NSLocalizedString("Please enter last name.", comment: "")
    static let OccupationNotPicked = NSLocalizedString("Please select occupation.", comment: "")
    static let AnyPasswordEmpty = NSLocalizedString("Please fill both password fields.", comment: "")
    static let EmailEmpty = NSLocalizedString("Please enter email address.", comment: "")
    static let PasswordEmpty = NSLocalizedString("Please enter Password.", comment: "")
    static let PhoneEmpty = NSLocalizedString("Please enter phone number.", comment: "")
    static let dobEmpty = NSLocalizedString("Please enter Date of Birth.", comment: "")
    static let InvalidEmail = NSLocalizedString("Invalid email address.", comment: "")
    static let InvalidPhone = NSLocalizedString("Invalid phone number.", comment: "")
    static let InvalidUrl = NSLocalizedString("Invalid url.", comment: "")
    static let InvalidPassword = NSLocalizedString("Invalid password.", comment: "")
//    static let ShorterPassword = NSLocalizedString("Password should be at least \(Constant.Counts.passwordCount) characters.", comment: "")
    static let MismatchingPasswords = NSLocalizedString("Passwords do not match.", comment: "")
    static let NoCameraPermission = NSLocalizedString("No camera permission set.", comment: "")
    static let CurrentPasswordEmpty = NSLocalizedString("Please enter current password.", comment: "")
    static let NewPasswordEmpty = NSLocalizedString("Please enter new password.", comment: "")
    static let ConfirmPasswordEmpty = NSLocalizedString("Please enter confirm password.", comment: "")
    static let newCurrentMatchPasswords = NSLocalizedString("Current password and new password can not be same.", comment: "")
    static let SuccessfullyUpdated = NSLocalizedString("Profile updated successfully.", comment: "")
    static let SubjectMissing = NSLocalizedString("Please enter subject", comment: "")
    static let MessageMissing = NSLocalizedString("Please enter message", comment: "")
    static let MissingQuestion = NSLocalizedString("Please enter Question", comment: "")
    static let InternetConnectionOffline = NSLocalizedString("Internet connection appears to be offline. ", comment: "")
    static let openTermsCondition = NSLocalizedString("Read \"Terms & Conditions\" befor signup.", comment: "")
    static let DevelopmentOnProgress = NSLocalizedString("This feature development is on Progress.", comment: "")
    static let NoVideo = NSLocalizedString("No video found", comment: "")
    static let NoCurrentVideo = NSLocalizedString("No current video found", comment: "")
    static let Dissabled = NSLocalizedString("This feature is dissabled.", comment: "")
    static let ProfileCreated = NSLocalizedString("Your profile has been created.", comment: "")
    static let NoAnswerTypes = NSLocalizedString("Please type the answer and try again.", comment: "")
    static let AnswerIsShort = NSLocalizedString("Your Answer is too short.", comment: "")
    static let NoCluePaymentOptions = NSLocalizedString("No clue payment options found.", comment: "")
    static let WrongAnswer = NSLocalizedString("Wrong answer! \nPlease try again", comment: "")
    static let NoVideos = NSLocalizedString("There are no videos", comment: "")
    static let AlreadyRevealed = NSLocalizedString("Already Revealed", comment: "")
    static let NoCluesBought = NSLocalizedString("Answers can not be revealed", comment: "")
    static let SpottedAllMistakes = NSLocalizedString("You spotted all the mistakes! Claim your prize now.", comment: "")
    static let NotSubscribed = NSLocalizedString("You are not subscribed yet", comment: "")
    static let SelectAMethod = NSLocalizedString("Select a preferred method", comment: "")
    static let TryPurchaseAgain = NSLocalizedString("There is a problem in loading products.Please try again", comment: "")

    static let FeatureNotImplemented = NSLocalizedString("This feature is not implemented.", comment: "")
    // Success messages
    static let ProfileUpdated = NSLocalizedString("Profile has been updated successfully.", comment: "")
    static let ProfilePictureUpdated = NSLocalizedString("Profile picture has been updated successfully.", comment: "")
    
    // Failure messages
    static let MisingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let SignUpSuccessMessage = NSLocalizedString("Your profile has been created.", comment: "")
    static let AvatarUploadFaliureMessage = NSLocalizedString("Faild to upload profile picture.", comment: "")
    static let RetryMessage = NSLocalizedString("Do you wish to retry?", comment: "")
    static let InAppPurchaseFaild = NSLocalizedString("Fail to complete In-app purchase.", comment: "")
    
    // Alert titles
    static let Alert = NSLocalizedString("Alert", comment: "")
    static let Confirmation = NSLocalizedString("Confirmation", comment: "")
    static let Congratulations = NSLocalizedString("Congratulations!", comment: "")
    static let Error = NSLocalizedString("Error", comment: "")
    static let Incomplete = NSLocalizedString("Incomplete", comment: "")
    static let Success = NSLocalizedString("Success !", comment: "")
    static let Failed = NSLocalizedString("Failed", comment: "")
    static let Oops = NSLocalizedString("Oops", comment: "")
    static let Warning = NSLocalizedString("Warning", comment: "")
    static let ResetEmailSent = NSLocalizedString("A password reset link has been sent. Please check your email.", comment: "")
    static let SomethingWentWrong = NSLocalizedString("Something went wrong.", comment: "")
    static let PasswordChanged = NSLocalizedString("Password Changed", comment: "")
    
    // Action titles
    static let Ok = NSLocalizedString("OK", comment: "")
    static let Cancel = NSLocalizedString("Cancel", comment: "")
    static let Yes = NSLocalizedString("Yes", comment: "")
    static let No = NSLocalizedString("No", comment: "")
    static let Retry = NSLocalizedString("Retry", comment: "")
    static let Dismiss = NSLocalizedString("Dismiss", comment: "")
    static let Call = NSLocalizedString("Call", comment: "")
    static let Settings = NSLocalizedString("Settings", comment: "")
    static let Continue = NSLocalizedString("Continue", comment: "")
    static let Create = NSLocalizedString("Create", comment: "")
    static let Add = NSLocalizedString("Add", comment: "")
    static let Update = NSLocalizedString("Update", comment: "")
    static let Delete = NSLocalizedString("Delete", comment: "")
    static let Skip = NSLocalizedString("Skip", comment: "")
    static let RequestPrize = NSLocalizedString("Request Prize Now!", comment: "")
    static let RequestLate = NSLocalizedString("Request Later", comment: "")
    static let TryAgain = NSLocalizedString("Try again", comment: "")
}
