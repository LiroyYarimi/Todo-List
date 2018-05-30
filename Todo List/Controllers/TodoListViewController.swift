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

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard //varibale that can save data even user terminate our app
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "buy milk"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destory Demagorgon"
        itemArray.append(newItem3)

//        if let item = defaults.array(forKey: "TodoListArray") as? [Item] { //get from our saving box
//            itemArray = item
//        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    // number of row in our table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //print row by row in our table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueTrue : valueFalse
        cell.accessoryType = item.done ? .checkmark : .none //short way to make if else
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    //this func call automatic when user pressed on cell in our table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()//call the method cellForRowAt
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo List Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            //self.itemArray.append(textField.text ?? "new item")
            self.itemArray.append(newItem)
            
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

