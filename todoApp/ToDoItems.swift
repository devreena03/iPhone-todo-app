//
//  ToDoItems.swift
//  todoApp
//
//  Created by Kumari, Reena on 29/12/20.
//

import Foundation
import RealmSwift

class ToDoItems:Object{
    @objc dynamic var item: String?
    @objc dynamic var date: Date = Date()
}
