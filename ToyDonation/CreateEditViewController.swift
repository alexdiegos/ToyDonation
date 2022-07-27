//
//  CreateEditViewController.swift
//  ToyDonation
//
//  Created by Alexandre Silva on 26/07/22.
//  Copyright © 2022 AlexDiegoS. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CreateEditViewController: UIViewController {
    @IBOutlet weak var toyName: UITextField!
    @IBOutlet weak var toyState: UISegmentedControl!
    @IBOutlet weak var donorName: UITextField!
    @IBOutlet weak var donorAddress: UITextField!
    @IBOutlet weak var donorPhone: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var toy: ToyItem?
    let collection = "toysList"
    var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.keyboardDismissMode = .interactive
        if let toy = toy {
            title = "Edição"
            toyName.text = toy.name
            toyState.selectedSegmentIndex = toy.state
            donorName.text = toy.donorName
            donorAddress.text = toy.donorAddress
            donorPhone.text = toy.donorPhone
            
            saveBtn.setTitle("Alterar", for: .normal)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }
        
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    @IBAction func save(_ sender: UIButton) {
        let data: [String: Any] = [
            "name": toyName.text ?? "",
            "state": toyState.selectedSegmentIndex,
            "donorName": donorName.text ?? "",
            "donorAddress": donorAddress.text ?? "",
            "donorPhone": donorPhone.text ?? ""
        ]
        if let toy = toy {
            firestore.collection(collection).document(toy._id).updateData(data)
        } else {
            firestore.collection(collection).addDocument(data: data)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
