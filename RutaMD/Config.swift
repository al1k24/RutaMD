//
//  Config.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 20.04.2022.
//

import Foundation

let BASE_URL = "https://autogara.md"
let BASE_API_URL = BASE_URL + "/gam2020/"

func LOG(_ closure: @autoclosure () -> Any,
         functionName: StaticString = #function,
         fileName: StaticString = #file,
         lineNumber: Int = #line
) {
    #if DEBUG
    guard let swiftFile = String(describing: fileName).components(separatedBy: "/").last else {
        return
    }
    
    let date = String(Date().formatted(date: .omitted, time: .standard))
    print("[EBSDebug] \(date) [\(swiftFile):\(lineNumber)] \(String(describing: functionName)) > \(String(describing: closure()))")
    #endif
}
