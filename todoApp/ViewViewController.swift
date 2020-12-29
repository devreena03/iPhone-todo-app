//
//  ViewViewController.swift
//  todoApp
//
//  Created by Kumari, Reena on 29/12/20.
//

import UIKit
import RealmSwift

class ViewViewController: UIViewController {
    
       public var item: ToDoItems?
       public var deletionHandler: (() -> Void)?

       @IBOutlet var itemLabel: UILabel!
       @IBOutlet var dateLabel: UILabel!

       private let realm = try! Realm()

       static let dateFormatter: DateFormatter = {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .medium
           return dateFormatter
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @IBAction func didTapDelete() {
            guard let myItem = self.item else {
                return
            }

            realm.beginWrite()
            realm.delete(myItem)
            try! realm.commitWrite()

            deletionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }

}
