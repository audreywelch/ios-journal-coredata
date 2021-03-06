
import Foundation
import CoreData


class EntryController {
    

    
    
    // Saves core data stack's mainContext
    // This will bundle the changes in the context, pass them to the persistent store coordinator, who will then put those changes in the persistent store.
    func saveToPersistentStore() {
        
        let moc = CoreDataStack.shared.mainContext
        
        do {
            try moc.save()
        } catch {
            fatalError("Error saving to core data: \(error)")
        }
    }
    
    func loadFromPersistentStore() -> [Entry] {
        var entry: [Entry] {
            do {
                let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
                let resualt = try CoreDataStack.shared.mainContext.fetch(fetchRequest)
                return resualt
            }catch {
                fatalError("Cant fetch Data \(error)")
            }
        }
        return entry
    }
    
//    func loadFromPersistentStore() -> [Entry]
//
//
//        var entries: [Entry] {
//
//            // Create NSFetchReqeust for Entry objects
//            let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
//
//            // Perform fetch request on the core data stack's mainContext
//            let moc = CoreDataStack.shared.mainContext
//
//
//            // Return the results of the fetch request & handle errors
//            do {
//                let result = try moc.fetch(fetchRequest)
//                return result
//
//            } catch {
//                print("error fetching: \(error)")
//                //return []
//            }
//        }
//        return entries
//    }

    var entries: [Entry] {
    
    // This allows any changes to the persistent store to become imediately visible when accessing the array (i.e. in the table view showing a list of entries)
        return loadFromPersistentStore()
    }
    
    
    func createEntry(title: String, bodyText: String) {
        
        // Initialize an Entry object
        let newEntry = Entry(context: CoreDataStack.shared.mainContext)
        newEntry.title = title
        newEntry.bodyText = bodyText
        
        // Save to the persistent store
        saveToPersistentStore()
        
    }
    
    // Have title and bodyText parameters as well as the Entry you want to update
    func updateEntry(entry: Entry, title: String, bodyText: String) {
        
        // Change the title and bodyText of the Entry to the new values passed in as parameters to the function
        entry.title = title
        entry.bodyText = bodyText

        // Update the entry's timestamp to the current time
        entry.timestamp = Date.init()
        
        // Save changes to the persistent store
        saveToPersistentStore()
        
    }
    
    
    func deleteEntry(entry: Entry) {
        
        CoreDataStack.shared.mainContext.delete(entry)
        
        // Save this deletion to the persistent store
        saveToPersistentStore()
        
    }
    

    
    

    
}
