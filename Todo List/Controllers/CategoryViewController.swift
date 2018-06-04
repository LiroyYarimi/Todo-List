//
//  CategoryViewController.swift
//  Todo List
//
//  Created by liroy yarimi on 4.6.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    //for saving our data even if the user exit from our app
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
    }
    
    //MARK: - TableView Datasource Methods
    
    // number of row in our table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //print row by row in our table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
//        //Ternary operator ==>
//        // value = condition ? valueTrue : valueFalse
//        cell.accessoryType = item.done ? .checkmark : .none //short way to make if else
//        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory(){
        
        do{
            try context.save()
        }catch{
            print("Error saving context Category \(error)")
        }
        self.tableView.reloadData() //call the method cellForRowAt - refresh the table view
    }
    
    //request use in the method. with use to call this function
    //request have default value "Item.fetchRequest()"
    func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetch data from context - Category \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo List Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in //this closure call when the pop up message display
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Delegate Methods
    
    //this called when user preesed on tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    //this function call just before the segue go to Item tableview
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{ //this two line chane the variable selectedCategory to this self category
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
}
