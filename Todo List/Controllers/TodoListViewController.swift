//
//  ViewController.swift
//  Todo List
//
//  Created by liroy yarimi on 29.5.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
// we don't need to declare a delegate like the group chat project because it's UITableViewController

    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItem() //call only if selectedCategory not nil (if it's change)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        /*
         how to delete
         context.delete(itemArray[indexPath.row])
         itemArray.remove(at: indexPath.row)
         */
        
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
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        self.tableView.reloadData() //call the method cellForRowAt - refresh the table view
    }
    
    //request use in the method. with use to call this function
    //request have default value "Item.fetchRequest()"
    //predicate have default value of optional nil
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil){

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let addtionalPredicate = predicate{//if predicate != nil
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,addtionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetch data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
}

//MARK: - Search bar methods

//extension our TodoListViewController for the search bar with all the methods inside.
extension TodoListViewController : UISearchBarDelegate{
    //we order the searchbar.Delegte = salf, in out Main.storyboard
    
    //tel the delegate (us) that the search bar is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //search in the title string that contains the search words
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)] //order the result alphabetically
        
        loadItem(with: request, predicate: predicate)
    }
    
    //tel the delegate (us) that the user is typing
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {//number of character is zero
            loadItem()
            
            DispatchQueue.main.async { //make this task (dismiss the keyboard) work on the background so isn't freeze the app
                searchBar.resignFirstResponder()//dismiss the keyboard
            }
            
        }
    }
}

