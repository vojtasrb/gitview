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
        if language == "Ruby" {
            return UIColor.red
        }
        else if language == "Objective-C" {
            return UIColor.blue
        }
        else if language == "Go" {
            return UIColor.cyan
        }
        else if language == "PLpgSQL" {
            return UIColor.darkGray
        }
        else if language == "Arduino" {
            return UIColor.gray
        }
        else if language == "JavaScript" {
            return UIColor.brown
        }
        else { return UIColor.white }
    }
}
