//
//  Handlers.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-06-08.
//

import Foundation

typealias actionHandler = (_ status: Bool, _ message: String) -> ()
typealias actionHandlerForMultipleErrors = (_ status: Bool, _ message: [String]) -> ()
typealias completionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()
typealias completionHandlerWithData = (_ status: Bool, _ code: Int, _ message: String, _ data: Any?) -> ()
typealias fileDownloadHandler = (_ status: Bool, _ message: String, _ url: String?) -> ()
//typealias notificationHandler = (_ status: Bool, _ code: Int, _ message: String, _ data: _Notification?) -> ()

typealias actionHanlerSp =  (_ status: Bool, _ message: String, _ stat:Int) -> ()

func delay(_ delay: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

