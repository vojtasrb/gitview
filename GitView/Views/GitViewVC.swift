//
//  ViewController.swift
//  GitView
//
//  Created by Vojtěch Srb on 19/01/2020.
//  Copyright © 2020 Vojtěch Srb. All rights reserved.
//

import UIKit
import SwiftyJSON

class GitViewVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var gitHubRepos: [GitHubRepo] = []
    
    @IBOutlet weak var gitView: UITableView!
    @IBOutlet weak var gitUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        /*
        GitViewAccess().getAllRepos() { json in
            do {
                for (index,subJson):(String, JSON) in json {                    
                    let newRepo = GitHubRepo(name: subJson["name"].stringValue, language: subJson["language"].stringValue, lastUpdated: subJson["updated_at"].stringValue)
                    self.gitHubRepos.append(newRepo)
                }
                self.gitView.reloadData()
            }
        }
        */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "ShowGitHubRepoDetail" {

        let detailVC = segue.destination as! DetailVC
        let myIndexPath = self.gitView.indexPathForSelectedRow!
        let row = myIndexPath.row
        detailVC.branchName = gitHubRepos[row].name
        }
    }

    // MARK: - Table View Repositories
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gitHubRepos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "gitViewCell", for: indexPath) as! gitViewCell

        cell.gitRepoName.text = gitHubRepos[indexPath.row].name
        cell.gitRepoLanguage.tintColor = gitHubRepos[indexPath.row].getLangColor()
        cell.gitLastUpdated.text = gitHubRepos[indexPath.row].lastUpdated
      return cell

    }
    @IBAction func usernameDidChangeOnExit(_ sender: Any) {
            
        GitViewAccess().getAllRepos(username: gitUsername.text!) { json in
            do {
                for (index,subJson):(String, JSON) in json {
                    let newRepo = GitHubRepo(name: subJson["name"].stringValue, language: subJson["language"].stringValue, lastUpdated: subJson["updated_at"].stringValue)
                    self.gitHubRepos.append(newRepo)
                }
                self.gitView.reloadData()
            }
        }
        
    }
    @IBAction func usernameDidChange(_ sender: Any) {
        
        self.gitView.reloadData()
    }
}

