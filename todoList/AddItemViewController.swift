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
            let realm = try! Realm()
            realm.beginWrite()
            let newItem = TodoItem.init()
            newItem.item = itemTV.text!
            realm.create(TodoItem.self, value: newItem)
            try! realm.commitWrite()
            itemTV.text = ""
            self.dismiss(animated: true, completion: nil)
            
        }
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


