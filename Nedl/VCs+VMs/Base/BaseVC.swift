//
//  BaseVC.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-05-13.
//

import UIKit
import RxCocoa
import RxSwift
import WebKit
import SwiftyJSON
import AgoraRtcKit
import AgoraRtmKit

struct TextFieldInfo {
    var tf: UITextField = UITextField()
    var placeHolder: String = String()
}

class BaseVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LoadingIndicatorDelegate, AgoraRtmDelegate, AgoraRtmChannelDelegate {
    
    // MARK: - Variables
    
    let baseVM = BaseVM()
    let imagePicker = UIImagePickerController()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Hide the keyboard when tap background
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    // Back navigation
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // Dismiss Top VC
    func dismissTop() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Temp Alert
    
    // Show Temp alert
    func showTempAlert(vc: UIViewController? = nil, tvc: UITableViewController? = nil) {
        if let _vc = vc {
            AlertProvider(vc: _vc).showAlert(title: .Alert, message: .FeatureNotImplemented, action: AlertAction(title: .Dismiss))
        } else if let _tvc = tvc {
            AlertProvider(tvc: _tvc).showAlert(title: .Alert, message: .FeatureNotImplemented, action: AlertAction(title: .Dismiss))
        }
    }
    
    // MARK: - Text Editor Delegate
    
    func setDelegatesForTextEditors(tfs: [UITextField] = [], tvs: [UITextView] = []) {
        tfs.forEach({ tf in
            tf.delegate = self
        })
        
        tvs.forEach({ tv in
            tv.delegate = self
        })
    }
    
    
    // MARK: Replace Characters
    
    func replaceCharacter(text: BehaviorRelay<String>, avoidingCharacters: [String], with replacement: String) -> String {
        for i in 0..<avoidingCharacters.count {
            text.accept(text.value.replacingOccurrences(of: avoidingCharacters[i], with: replacement))
        }
        return text.value
    }
    
    // MARK: - Delete User & Set Root
    
    // Delete local user and set root
//    func deleteLocalUserAndSetRoot() {
//        // Delete Realm current user
//        guard let user = LocalUser.current() else { return }
//        RealmService.shared.delete(user)
//        SwaggerClientAPI.customHeaders.removeValue(forKey: "x-access-token")
//
//        // Direct to login root
//        ApplicationServiceProvider.shared.directToPath(in: .Authentication, for: .AuthNC, from: self)
//    }
    
    // MARK: - Load URL In Web
    
    // Load Url in webview
    func loadUrlInWebView(urlString: String, webView: WKWebView) {
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
            webView.load(urlRequest)
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    // MARK: - Load HTML
    
    // Load html string in webview
    func loadHtmlStringInWebView(htmlString: String, webView: WKWebView) -> Void {
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
}

// MARK: - Image Picker

extension BaseVC {
    
//    func showImagePickerAlert(sourceView: UIView, editting: Bool) {
//        let action1 = AlertAction(title: .TakePhoto, style: .default)
//        let action2 = AlertAction(title: .ChooseFromLibrary, style: .default)
//
//        AlertProvider(vc: self).showActionSheetWithActions(title: nil, message: nil, actions: [action1, action2], sourceView: sourceView, completion:  { (action) in
//            if action.title == .TakePhoto {
//                self.provideCameraForImagePicking(editting: editting)
//            }
//            else if action.title == .ChooseFromLibrary {
//                self.provideGalleryForImagePicking(editting: editting)
//            }
//        })
//    }
    
    // Provide Camera
//    func provideCameraForImagePicking(editting: Bool) {
//        self.imagePicker.allowsEditing = editting
//        self.imagePicker.sourceType = .camera
//        self.imagePicker.cameraCaptureMode = .photo
//        self.present(imagePicker, animated: true, completion: nil)
//    }
//
//    // Provide Image Library
//    func provideGalleryForImagePicking(editting: Bool) {
//        self.imagePicker.allowsEditing = editting
//        self.imagePicker.sourceType = .photoLibrary
//        self.present(imagePicker, animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//
    // Save image to document directory
//    func saveImageToDocumentDirectory(image: UIImage, imageFormat: ImageFormat = .png, quality: CGFloat = 1.0) -> (Bool, URL?) {
//
//        let pngData = image.pngData()
//        let jpgData = image.jpegData(compressionQuality: quality)
//
//        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
//            return (false, nil)
//        }
//
//        if !FileManager.default.fileExists(atPath: directory.path!) {
//            try? FileManager.default.createDirectory(atPath: directory.path!, withIntermediateDirectories: true, attributes: nil)
//        }
//
//
//        let randomString = NSUUID().uuidString
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = documentsURL.appendingPathComponent(randomString + ".\(imageFormat.rawValue)")
//
//        if let _data = imageFormat == .png ? pngData : jpgData {
//            do {
//                try _data.write(to: fileURL)
//                return (true, fileURL)
//
//            } catch {
//                print("Error saving image")
//                return (false, nil)
//            }
//        }
//
//        return (false, nil)
//    }
}

extension BaseVC {

//    func loadProfileData() -> User? {
//        return nil
//    }
}
