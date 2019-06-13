//
//  EntryController.swift
//  Journal2iOS27
//
//  Created by Austin West on 6/13/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    init() {
        loadFromPersistentStorage()
    }
    
    //  creating an array called entries that store my Entry objects.
    var entries: [Entry] = []
    //  Add a new Entry to the entries array
   func addEntryWith(title: String, text: String) {
    
    let entry = Entry(title: title, bodyText: text)
    entries.append(entry)
    saveToPersistentStorage()
    }
    
    //  Remove an entry from the entries array
    func remove(entry: Entry) {
        // Searches to find the specific index point/location of an entry and then removes it from the array
        if let entryIndex = entries.firstIndex(of: entry) {
        entries.remove(at: entryIndex)
            saveToPersistentStorage()
        }
    }
    
    func update(entry: Entry, with title: String, text: String) {
        
        entry.title = title
        entry.bodyText = text
        saveToPersistentStorage()
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "journal.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    //    Persistence
    //    make this a snippet!
    func createFileURLForPersistence() -> URL {
        //        grab the users document directory
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //        Create the new fileURL on the user's device
        let fileURL = urls[0].appendingPathComponent("Journal2iOS27.json")
        return fileURL
    }
    
    // Persistence
    func saveToPersistentStorage() {
        
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(entries)
            try data.write(to: createFileURLForPersistence())
        } catch let encodingError {
            print("There was an error saving the data as JSON!! \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistentStorage() {
        
        //        The data we want will be JSON, and I want it to be a Playlist
        let jsonDecoder = JSONDecoder()
        //        Decode the data
        do {
            
            let jsonData = try Data(contentsOf: createFileURLForPersistence())
            let decodedEntries = try jsonDecoder.decode([Entry].self, from: jsonData)
            entries = decodedEntries
            self.entries = decodedEntries
        } catch let decodingError {
            print("There was an error decoding!! \(decodingError.localizedDescription)")
        }
        
    }
    
    
}
