//
//  CategoryViewController.swift
//  Todoey
//
//  Created by MacBook Pro on 9/16/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()

    }

    //MARK : - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
        //MARK : - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    //MARK : - Data Manipulation Methods
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error with save category in Core data --+-+++-++++-+--+-++---Caterogry--+--+--+-++--++- \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        //        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            self.categoryArray = try context.fetch(request)
            
        } catch {
            print("Error with fetch data for category -+-+-+--+--+--Category Fetch--+-----+-+--+-+- \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK : - Add New Categories
    
      
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFieldAlert = UITextField()
       
        let alert = UIAlertController(title: "Add new Todoey category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in

            let newCategry = Category(context: self.context)
            newCategry.name = textFieldAlert.text
            self.categoryArray.append(newCategry)
            
            self.saveCategory()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category name"
            textFieldAlert = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    

    
    
}
