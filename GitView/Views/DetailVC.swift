//
//  DetailVC.swift
//  GitView
//
//  Created by Vojtěch Srb on 20/01/2020.
//  Copyright © 2020 Vojtěch Srb. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailVC: UIViewController, UITableViewDataSource {

    let sections = ["Branches", "Commits"]
    
    var branchName: String = ""
    var branches: [String] = []
    var commits: [String] = []
    var completeInfo = [[String]]()
    
    
    @IBOutlet weak var gitViewDetail: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        // Do any additional setup after loading the view.
                
        Networking().getRepoInfo(repo: branchName) { branches in
            do {
                for (index,subJson):(String, JSON) in branches {
                    let name = subJson["name"].stringValue

                    self.branches.append(name)
                }
                self.completeInfo.append(self.branches)
            }
        }
        
        Networking().getCommitsInfo(repo: branchName) { commits in
            do {
                self.completeInfo.append(commits)
            }
            self.gitViewDetail.reloadData()
        }
    }
    
    // MARK: - Table View Detail

    func numberOfSections(in tableView: UITableView) -> Int {
        return completeInfo.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return completeInfo[section].count

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sections.count {
            return sections[section]
        }

        return nil    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
      // Depending on the section, fill the textLabel with the relevant text
      
        guard !branches.isEmpty else {
            print("empty branches")
            return cell
        }
        print(completeInfo)
      cell.textLabel?.text = completeInfo[indexPath.section][indexPath.row]
      // Return the configured cell
      return cell

    }
}
