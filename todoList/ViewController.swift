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

    var todo:[TodoItem] = []
    var filtered:[TodoItem] = []
    let realm = try! Realm()
    let results = try! Realm().objects(TodoItem.self)
    var searchActive : Bool = false
    
    @IBOutlet weak var tabView: UITableView!
    
    @IBOutlet weak var searchViewController: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(results.count)
        print(results[0].item)
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
            todo.remove(at: indexPath.row)
            tableView.reloadData()
        }
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
        
        filtered = todo.filter({ (text) -> Bool in
            let tmp: NSString = text.item as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tabView.reloadData()
    }
}

