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
    
    //Create new plist named Item and there we will save our data
    //we can't use UserDefault becuase you can't save there object of type Item class
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItem()

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
        
        saveItem()// refresh Item.plist with our change
        
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
            
            self.saveItem()
            
        }
        
        alert.addTextField { (alertTextField) in //this closure call when the pop up message display
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveItem(){
        //save itemArray (with the newItem) in our Item.plist
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write( to: dataFilePath!) //the address to our plist
        }
        catch{
            print("error encoding item array: \(error)")
        }
        self.tableView.reloadData() //call the method cellForRowAt - refresh the table view
    }
    
    func loadItem(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self , from: data)
            }
            catch{
                print("Error decoding item array : \(error)")
            }
        }
    }
}

