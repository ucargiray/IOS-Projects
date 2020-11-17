//
//  ViewController.swift
//  Team Lists
//
//  Created by Giray Uçar on 13.11.2020.
//  Copyright © 2020 Ahmet Giray Uçar. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var teamNames = [String]()
    var teamIDs = [UUID]()
    var selectedTeam = ""
    var selectedTeamID : UUID?
    
    @objc func getDataFromCoreData(){
        self.teamNames.removeAll(keepingCapacity: false)
        self.teamIDs.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context?.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    self.teamNames.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID {
                    self.teamIDs.append(id)
                }
            }
            
        }catch{
            
        }
        self.teamTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailPage"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.chosenTeam = selectedTeam
            detailVC.chosenTeamID = selectedTeamID
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeam = teamNames[indexPath.row]
        selectedTeamID = teamIDs[indexPath.row]
        performSegue(withIdentifier: "toDetailPage", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = teamNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
            
            let idString = teamIDs[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id=%@", idString)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == teamIDs[indexPath.row] {
                                
                                context.delete(result)
                                teamNames.remove(at: indexPath.row)
                                teamIDs.remove(at: indexPath.row)
                                tableView.deleteRows(at: [indexPath], with: .fade)
                                
                                do {
                                    try context.save()
                                }
                                catch {
                                    
                                }
                            }
                        }
                    }
                }
            }catch{
                
            }
            
        }
    }
    
    @IBOutlet var teamTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamTableView.dataSource = self
        teamTableView.delegate = self
        
        getDataFromCoreData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getDataFromCoreData), name: NSNotification.Name(rawValue: "saveClicked"), object: nil)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        selectedTeam = ""
        performSegue(withIdentifier: "toDetailPage", sender: nil)
    }
    
}

