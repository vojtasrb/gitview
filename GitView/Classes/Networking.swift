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

class Networking {
    
    var commits:[String] = []
    var branches:[String] = []
    /*
    var repoNames:[String] = []
    var gitHubRepos: [GitHubRepo] = []

    
    func getRepNames(username: String, completionBlock: @escaping ([String]) -> Void) {
        
        AF.request("https://api.github.com/users/" + username + "/repos", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for (index,subJson):(String, JSON) in json {
                    let repoName = subJson["name"].stringValue
                    self.repoNames.append(repoName)
                    
                    let thisObject = GitHubRepo(name: subJson["name"].stringValue, language: subJson["language"].stringValue, lastUpdated: subJson["updated_at"].stringValue)
                    self.gitHubRepos.append(thisObject)
                }
                
                print(self.gitHubRepos)
                print(self.repoNames[5])
                completionBlock(self.repoNames)
                
            case .failure(let error):
                print(error)
            }
        }
}
    */
    
    func getAllRepos(completionBlock: @escaping (JSON) -> Void) {
            
            AF.request("https://api.github.com/users/inza/repos", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    completionBlock(json)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getRepoInfo(repo: String, completionBlock: @escaping (JSON) -> Void) {
            
            AF.request("https://api.github.com/repos/inza/" + repo + "/branches", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    for (index,subJson):(String, JSON) in json {
                        let name = subJson["name"].stringValue
                        self.branches.append(name)
                    }
                    
                    completionBlock(json)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getCommitsInfo(repo: String, completionBlock: @escaping ([String]) -> Void) {
            
            AF.request("https://api.github.com/repos/inza/" + repo + "/commits", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    for (index,subJson):(String, JSON) in json {
                        let message = subJson["commit"]["message"].stringValue
                        self.commits.append(message)
                    }

                    
                    completionBlock(self.commits)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
