//
//  ToDoTableVC.swift
//  DataSaverPractice
//
//  Created by Nataliia on 11.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class ToDoTableVC: UITableViewController {
        
    
    @IBAction func addToDoItem(_ sender: Any) {
        
    let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
          //  alertController.view.layoutIfNeeded()
            alertController.addTextField { (textField) in
                textField.placeholder = "New item name"
            }
            
            let alertAction1 = UIAlertAction(title: "Cancel", style: .destructive) { (alert) in
            }
            let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
                let newItem = alertController.textFields![0].text
                if newItem != "" {
                    addItem(nameItem: newItem!)
                    self.tableView.reloadData()
                }
            }
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            present(alertController, animated:  true, completion: nil)
        }
        
  
    @IBAction func edittodoItems(_ sender: Any) {

    tableView.setEditing(!tableView.isEditing, animated: true)
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
                self.tableView.reloadData()
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor.darkGray
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return todoItems.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let currentItem = todoItems[indexPath.row]
            cell.textLabel?.text = currentItem["Name"] as? String
            cell.backgroundColor = UIColor.lightGray
            
            if (currentItem["isCompleted"] as? Bool) == true {
                cell.imageView?.image = UIImage(named: "check")
            } else {
                cell.imageView?.image = UIImage(named: "blackUncheck")
            }
            
            if tableView.isEditing {
                cell.textLabel?.alpha = 0.4
                cell.imageView?.alpha = 0.4
            } else {
                cell.textLabel?.alpha = 1
                cell.imageView?.alpha = 1
            }
            return cell
        }
        
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                removeItem(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
            }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            if  changeState(at: indexPath.row) {
                tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check")
            } else {
                tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "blackUncheck")
            }
        }
    
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            
            moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
            tableView.reloadData()
        }
        
        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            if tableView.isEditing {
                return .none
            } else {
                return .delete
            }
        }
        
        override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return false
        }
    }
