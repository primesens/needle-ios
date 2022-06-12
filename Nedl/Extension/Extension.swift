//
//  Extension.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-20.
//

import Foundation
import UIKit

// MARK: - UITextField

extension UITextField {
    func textFieldBoarderOne() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.1803921569, blue: 0.2, alpha: 1)
        self.layer.cornerRadius = 8
    }
}

// MARK: - UIButton

extension UIButton {
    func buttonPropertiesOne() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 8
    }
    
    func buttonPropertiesTwo() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.9432325959, green: 0.7964989543, blue: 0.2309248745, alpha: 1)
        self.layer.cornerRadius = 8
    }
    
    func buttonPropertiesThree() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.1803921569, blue: 0.2, alpha: 1)
        self.layer.cornerRadius = 8
    }
}

// MARK: - UIView

extension UIView {
    func viewPropertiesOne() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.852740705, green: 0.268186897, blue: 0.2579083145, alpha: 1)
        self.layer.cornerRadius = 12
    }
    
    func viewPropertiesTwo() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = #colorLiteral(red: 0.852740705, green: 0.268186897, blue: 0.2579083145, alpha: 1)
        self.layer.cornerRadius = 8
    }
}

// MARK: - String
extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func removingAllWhitespaces() -> String {
        return removingCharacters(from: .whitespaces)
    }
    
    func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func htmlAttributedString(family: String?, size: CGFloat, hexString: String) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(hexString) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    //get Date string and split it
    func getDateString() -> String {
        let dateStr = self
        let dateValue = dateStr.components(separatedBy: " ")
        let date = dateValue[0]
        return date
    }
    
    func getYearDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    func getYearDateSlash() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self)
    }
    
    func getStandardDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func timeAgoDisplay() -> String {
        
        let secondsAgo = Int(self.getStandardDate().timeIntervalSince(Date()))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < 10 {
            return "Now"
        } else if secondsAgo < minute {
            return "\(secondsAgo) sec left"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) min left"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hrs left"
        } else if secondsAgo < week {
            let dayValue = secondsAgo / day
            if dayValue == 1 {
                return "\(secondsAgo / day) day left"
            } else {
                return "\(secondsAgo / day) days left"
            }
        }
        
        let weekValue = secondsAgo / week
        if weekValue == 1 {
            return "\(secondsAgo / week) week left"
        } else {
            return "\(secondsAgo / week) weeks left"
        }
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    var numberOfWords: Int {
        let inputRange = CFRangeMake(0, utf16.count)
        let flag = UInt(kCFStringTokenizerUnitWord)
        let locale = CFLocaleCopyCurrent()
        let tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, self as CFString, inputRange, flag, locale)
        var tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        var count = 0

        while tokenType != [] {
            count += 1
            tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        return count
    }
}
