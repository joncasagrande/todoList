//
//  ViewController.swift
//  todoList
//
//  Created by Jonathan on 25/09/17.
//  Copyright © 2017 com.jonathan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    let realm = try! Realm()
    var todo = try! Realm().objects(TodoItem.self)
    var filtered = try! Realm().objects(TodoItem.self)
    var searchActive : Bool = false
    
    @IBOutlet weak var tabView: UITableView!
    
    @IBOutlet weak var searchViewController: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(searchActive) {
            return filtered.count
        }
        return todo.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row].item
        } else {
            cell.textLabel?.text = todo[indexPath.row].item
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            realm.beginWrite()
            realm.delete(todo[indexPath.row])
            try! realm.commitWrite()
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "itemDetail", sender: self)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let predicate = NSPredicate(format: "item CONTAINS %@", searchText.lowercased())

        filtered = try! Realm().objects(TodoItem.self).filter(predicate)
        print(filtered.count)
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tabView.reloadData()
    }
    
}
protocol ViewControllerItemDelete {
    func sendItem(itemId: TodoItem)
}
