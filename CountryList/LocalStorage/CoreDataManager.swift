//
//  CoreDataManager.swift
//  CountryList
//
//  Created by MACM06 on 11/06/25.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - Variable
    static let shared = CoreDataManager()
    // Init
    private init() {}
    // CoreData Container
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Country")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // Save a country
    func saveCountry(country: CountryResponse) {
        let entity = CDCountry(context: context)
        entity.id = country.id
        entity.name = country.name
        entity.capital = country.capital
        entity.flag = country.flags?.png
        entity.currencyName = country.currencies?.first?.name
        entity.isSelected = false
        saveContext()
    }
    
    // Save all countries
    func saveCountries(_ countries: [CountryResponse]) {
        countries.forEach { saveCountry(country: $0) }
    }
    
    // Fetch all countries
    func fetchCountries() -> [CountryResponse] {
        let fetchRequest: NSFetchRequest<CDCountry> = CDCountry.fetchRequest()
        
        do {
            let entities = try context.fetch(fetchRequest)
            return entities.map {
                CountryResponse(
                    name: $0.name,
                    capital: $0.capital,
                    flags: Flags(png: $0.flag),
                    currencies: [Currency(code: "", name: $0.currencyName, symbol: "")],
                    isSelected: $0.isSelected
                )
            }
        } catch {
            return []
        }
    }
    
    // Select and Unselect country
    func toggleCountrySelection(for id: String) {
        let fetchRequest: NSFetchRequest<CDCountry> = CDCountry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let countryEntity = try context.fetch(fetchRequest).first {
                countryEntity.isSelected.toggle()
                try context.save()
            } else {
            }
        } catch {
        }
    }
    
    // Save in to the CoreData
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
            }
        }
    }
}
