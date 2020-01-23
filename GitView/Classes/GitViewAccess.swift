//
//  Networking.swift
//  GitView
//
//  Created by Vojtěch Srb on 19/01/2020.
//  Copyright © 2020 Vojtěch Srb. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GitViewAccess {
    
    var commits:[String] = []
    var branches:[String] = []
    var completeInfo = [[String]]()

    func getAllRepos(username: String, completionBlock: @escaping (JSON) -> Void) {
            
            AF.request("https://api.github.com/users/\(username)/repos", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    completionBlock(json)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getCompleteInfo(repo: String, completionBlock: @escaping ([[String]]) -> Void) {
        
        // get branches
        AF.request("https://api.github.com/repos/inza/\(repo)/branches", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for (index,subJson):(String, JSON) in json {
                    let name = subJson["name"].stringValue
                    self.branches.append(name)
                }
                self.completeInfo.append(self.branches)
                
            case .failure(let error):
                print(error)
            }
        }
            // get commits
            AF.request("https://api.github.com/repos/inza/\(repo)/commits", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    for (index,subJson):(String, JSON) in json {
                        let message = subJson["commit"]["message"].stringValue
                        self.commits.append(message)
                    }
                    
                    // get last 10
                    let lastTen = Array(self.commits.prefix(10))
                    self.completeInfo.append(lastTen)
                    
                    completionBlock(self.completeInfo)

                case .failure(let error):
                    print(error)
                }
            }
    
}
}
