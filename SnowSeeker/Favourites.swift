//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Oliver Lippold on 19/04/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import SwiftUI

class Favourites: ObservableObject {
    // the actual resorts the user has favourited
    private var resorts: Set<String>
    
    // the key that we're using to read/writer in UserDefaults
    private let saveKey = "Favourites"
    
    init() {
        // Load our saved data
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: saveKey) as? Data {
            if let decodedData = try? JSONDecoder().decode(Set<String>.self, from: savedData) {
                self.resorts = decodedData
                return
            }
        }
        // Still here? Use an empty array
        self.resorts = []
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // Adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write our data
        if let savedData = try? JSONEncoder().encode(resorts) {
              let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: saveKey)
        }
    }
}
