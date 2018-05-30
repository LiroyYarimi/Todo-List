//
//  ViewController.swift
//  Todo List
//
//  Created by liroy yarimi on 29.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
// we don't need to declare a delegate like the group chat project because it's UITableViewController

    var itemArray = ["buy milk","buy Eggos", "Destory Demagorgon"]
    
    let defaults = UserDefaults.standard //varibale that can save data even user terminate our app
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = defaults.array(forKey: "TodoListArray") as? [String] { //get from our saving box
            itemArray = item
        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    // number of row in our table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //print row by row in our table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    //this func call automatic when user pressed on cell in our table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo List Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            print("Success!")
            
            //self.itemArray.append(textField.text ?? "new item")
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") //add itemArray to our saving box
            
            self.tableView.reloadData() //refresh the table view
        }
        
        alert.addTextField { (alertTextField) in //this closure call when the pop up message display
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

