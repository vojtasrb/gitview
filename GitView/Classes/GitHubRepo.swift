//
//  GitHubRepo.swift
//  GitView
//
//  Created by Vojtěch Srb on 20/01/2020.
//  Copyright © 2020 Vojtěch Srb. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GitHubRepo: Codable {
    
    var name: String
    var language: String
    var lastUpdated: String
    
    func getLangColor() -> UIColor {
        switch language {
        case "Ruby":
            return UIColor.red
        case "Objective-C":
            return UIColor.blue
        case "Go":
            return UIColor.cyan
        case "PLpgSQL":
            return UIColor.darkGray
        case "Arduino":
            return UIColor.gray
        case "JavaScript":
            return UIColor.brown
        default:
            return UIColor.white
        }
    }
}
