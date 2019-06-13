//
//  EntryListTableViewController.swift
//  Journal2iOS27
//
//  Created by Austin West on 6/13/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = EntryController.shared.entries[indexPath.row]
        let formattedDate = DateFormatter.localizedString(from: entry.timestamp, dateStyle: .medium, timeStyle: .none)
        // Setting the title and the date created on the journal cells
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = formattedDate
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source when you swipe right to left
            let ec = EntryController.shared
            let entry = ec.entries[indexPath.row]
            ec.remove(entry: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toShowEntry" {
            
            if let detailViewController = segue.destination as? EntryDetailViewController,
                let selectedRow = tableView.indexPathForSelectedRow?.row {
                
                let entry = EntryController.shared.entries[selectedRow]
                detailViewController.entry = entry
            }
        }
    }
    
}
