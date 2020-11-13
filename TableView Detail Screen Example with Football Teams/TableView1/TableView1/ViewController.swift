//
//  ViewController.swift
//  TableView1
//
//  Created by Giray Uçar on 12.11.2020.
//  Copyright © 2020 Ahmet Giray Uçar. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var teamList = [Team]()
    var selectedTeam : Team?
    
    @IBOutlet var teamTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        cell.textLabel?.text = teamList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeam = teamList[indexPath.row]
        performSegue(withIdentifier: "toDetailPage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailPage" {
            let detailVC = segue.destination as? DetailViewController
            detailVC?.selectedTeam = selectedTeam
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamTableView.dataSource = self
        teamTableView.delegate = self
        let team1 = Team(name: "Liverpool", image: UIImage(named: "liverpool")!, cups: 10)
        let team2 = Team(name: "Chelsea", image: UIImage(named: "chelsea")!, cups: 5)
        let team3 = Team(name: "Crystal Palace", image: UIImage(named: "crystal_palace")!, cups: 1)
        let team4 = Team(name: "Manchester United", image: UIImage(named: "manchester_united")!, cups: 15)
        
        teamList.append(team1)
        teamList.append(team2)
        teamList.append(team3)
        teamList.append(team4)
    }


}

