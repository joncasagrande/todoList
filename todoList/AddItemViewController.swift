//
//  AddItemViewController.swift
//  todoList
//
//  Created by Jonathan on 25/09/17.
//  Copyright © 2017 com.jonathan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
class AddItemViewController: UIViewController{
    let realm = try! Realm()
    var todo = TodoItem.init()
    @IBOutlet weak var itemTV: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addItem(_ sender: Any) {
        if(itemTV.text != ""){
            realm.beginWrite()
            if(todo.item == ""){
                let newItem = TodoItem.init()
                newItem.item = itemTV.text!
                realm.create(TodoItem.self, value: newItem)
            }else{
               todo.item = itemTV.text!
            }
            try! realm.commitWrite()
        }
        itemTV.text = ""
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddItemViewController: ViewControllerItemDelete{
    func sendItem(item: TodoItem){
        todo = item
    }
}


