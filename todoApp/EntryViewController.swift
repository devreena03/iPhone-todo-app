//
//  EntryViewController.swift
//  todoApp
//
//  Created by Kumari, Reena on 29/12/20.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate  {
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completionHandler: (() -> Void)? //when entry got inserted , other block will know to refresh the data

    private let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
        datePicker.setDate(Date(), animated: true)
        // Do any additional setup after loading the view.
        
        //manual way of loading bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    
    @IBAction func didTapSaveButton() {
        print("save")
            if let text = textField.text, !text.isEmpty {
                let date = datePicker.date
                
                realm.beginWrite()
                let newItem = ToDoItems()
                newItem.date = date
                newItem.item = text
                realm.add(newItem)
                try! realm.commitWrite()

                completionHandler?()
                navigationController?.popToRootViewController(animated: true)
            }
            else {
                print("Add something")
            }
        }
    


}
