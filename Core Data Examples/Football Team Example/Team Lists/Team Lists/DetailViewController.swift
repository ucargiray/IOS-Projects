//
//  DetailViewController.swift
//  Team Lists
//
//  Created by Giray Uçar on 13.11.2020.
//  Copyright © 2020 Ahmet Giray Uçar. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet var teamImageView: UIImageView!
    @IBOutlet var teamNameTextField: UITextField!
    @IBOutlet var teamCountryTextField: UITextField!
    @IBOutlet var teamCupsTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    var chosenTeam = ""
    var chosenTeamID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        if chosenTeam != "" {
            saveButton.isHidden = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
            let idString = chosenTeamID?.uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let name = result.value(forKey: "name") as? String {
                            teamNameTextField.text = name
                        }
                        if let cups = result.value(forKey: "cup") as? Int {
                            teamCupsTextField.text = String(cups)
                        }
                        if let country = result.value(forKey: "country") as? String {
                            teamCountryTextField.text = country
                        }
                        if let image = result.value(forKey: "image") as? Data {
                            teamImageView.image = UIImage(data: image)
                        }
                    }
                }
            }catch {
                
            }
        }
        
    
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(voidTapped))
        view.addGestureRecognizer(gestureRecognizer)
        
        teamImageView.isUserInteractionEnabled = true
        let imageGestureRec = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        teamImageView.addGestureRecognizer(imageGestureRec)
        
        
        
    }
    
    @objc func voidTapped(){
        view.endEditing(true)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           teamImageView.image = info[.originalImage] as? UIImage
           saveButton.isEnabled = true
           self.dismiss(animated: true, completion: nil)
       }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
               
        let newTeam = NSEntityDescription.insertNewObject(forEntityName: "Team", into: context)
        
        if teamNameTextField.text != "" {
            newTeam.setValue(teamNameTextField.text, forKey: "name")
            newTeam.setValue(teamCountryTextField.text, forKey: "country")
            newTeam.setValue(UUID(), forKey: "id")
        }
        
        if let cups = Int(teamCupsTextField.text!){
            newTeam.setValue(cups, forKey: "cup")
        }
        let data = teamImageView.image!.jpegData(compressionQuality: 0.5)
        newTeam.setValue(data, forKey: "image")
        do {
            try context.save()
        }catch{
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveClicked"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
