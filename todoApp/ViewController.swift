//
//  ViewController.swift
//  todoApp
//
//  Created by Kumari, Reena on 29/12/20.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!

    private let realm = try! Realm()
    private var data = [ToDoItems]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL);
        
        data = realm.objects(ToDoItems.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        
    }
    
    //mark table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            // Open the screen where we can see item info and dleete
            let item = data[indexPath.row]

            guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ViewViewController else {
                return
            }

            vc.item = item
            vc.deletionHandler = { [weak self] in
                self?.refresh()
            }
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = item.item
            navigationController?.pushViewController(vc, animated: true)
        }

    @IBAction func addItem(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {
                    return
                }
                vc.completionHandler = { [weak self] in
                    self?.refresh()
                }
                vc.title = "New Item"
                vc.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh() {
            data = realm.objects(ToDoItems.self).map({ $0 })
            table.reloadData()
        }

}

