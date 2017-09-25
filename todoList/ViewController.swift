//
//  ViewController.swift
//  todoList
//
//  Created by Jonathan on 25/09/17.
//  Copyright © 2017 com.jonathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var todo:[TodoItem] = []
    @IBOutlet weak var tabView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let item1 = TodoItem(item: "TEste 1")
        let item2 = TodoItem(item: "TEste 2")
        let item3 = TodoItem(item: "TEste 3")
        todo.append(item1)
        todo.append(item2)
        todo.append(item3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return todo.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = todo[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            todo.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}

