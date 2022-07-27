//
//  ToysTableViewController.swift
//  ToyDonation
//
//  Created by Alexandre Silva on 26/07/22.
//  Copyright © 2022 AlexDiegoS. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ToysTableViewController: UITableViewController {
    
    let collection = "toysList"
    var toysList:[ToyItem] = []
    var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadToysList()
    }
    
    func loadToysList() {
        listener = firestore.collection(collection).order(by: "name", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: {(snapshot, error) in
            if let error = error {
                print(error)
            } else {
                guard let snapshot = snapshot else {return}
                if snapshot.metadata.isFromCache || snapshot.documentChanges.count > 0{
                    self.showItensFrom(snapshot)
                }
            }
        })
    }
    
    func showItensFrom(_ snapshot:QuerySnapshot) {
        toysList.removeAll()
        for document in snapshot.documents {
            let data = document.data()
            
            if  let name = data["name"] as? String,
                let state = data["state"] as? Int,
                let donorName = data["donorName"] as? String,
                let donorAddress = data["donorAddress"] as? String,
                let donorPhone = data["donorPhone"] as? String {
                let toyItem = ToyItem(_id: document.documentID, name: name, state: state, donorName: donorName, donorAddress: donorAddress, donorPhone: donorPhone)
                toysList.append(toyItem)
            }
        }
        
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createEditViewController = segue.destination as? CreateEditViewController,
           let indexPath = tableView.indexPathForSelectedRow{
            let toyItem = toysList[indexPath.row]
            createEditViewController.toy = toyItem
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toysList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellToy", for: indexPath) as? ToyTableViewCell else {
            return UITableViewCell()
        }
        let toyItem = toysList[indexPath.row]
        cell.configureWith(toyItem)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toyItem = toysList[indexPath.row]
            firestore.collection(collection).document(toyItem._id).delete()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
