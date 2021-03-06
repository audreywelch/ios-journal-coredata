
import UIKit

class EntriesTableViewController: UITableViewController {

    let entryController = EntryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return entryController.entries.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EntryTableViewCell.reuseIdentifier, for: indexPath) as? EntryTableViewCell else {
            fatalError("Could not dequeue cell")
        }

        // Pass an Entry to the cell's entry property in order for it to call the updateViews() method to fill in the information for the cell's labels
        cell.entry = entryController.entries[indexPath.row]

        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let entry = entryController.entries[indexPath.row]
            
            // Delete the row from the data source
            entryController.deleteEntry(entry: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        
            
        }
    }




    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create entry - pass empty detail view controller
        guard let destination = segue.destination as? EntryDetailViewController else { return }
        
        destination.entryController = entryController
        
        // Get the new view controller using segue.destination.
        if segue.identifier == "ViewEntry" {
            // the user tapped on a cell
            let destination = segue.destination as! EntryDetailViewController
            // get the tapped row (it's optional)
            if let tappedRow = tableView.indexPathForSelectedRow {
                // Pass the entryController and the Entry that correspond to the tapped row
                destination.entry = entryController.entries[tappedRow.row]
            }
        }
        
        // Don't need to handle the CreateEntry segue because we want it to show a blank Detail View Controller
        
    }


}
