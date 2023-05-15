//
//  PropertyRepository.swift
//  PropertyMap
//
//  Created by Mostafa Mazrouh on 2023-05-15.
//

import Foundation

protocol PropertyRepositoryInterface {
    func getPropertyList() async -> [PropertyItemDataModel]
    func getPropertyDetails() async -> PropertyItemDataModel?
}

class PropertyRepository: PropertyRepositoryInterface {
    
    func getPropertyList() async -> [PropertyItemDataModel] {
        
        guard let url = URL(string: "https://pastebin.com/raw/nH5NinBi") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let propertyListModel = try? JSONDecoder().decode(PropertyListDataModel.self, from: data) {
                
                return propertyListModel.items
            }
            
        } catch {
            print("Invalid data")
        }
        
        return []
    }
    
    func getPropertyDetails() async -> PropertyItemDataModel? {
        
        guard let url = URL(string: "https://pastebin.com/raw/uj6vtukE") else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let propertyItemDetails = try? JSONDecoder().decode(PropertyItemDataModel.self, from: data) {
                
                return propertyItemDetails
            }
            
        } catch {
            print("Invalid data")
        }
        
        return nil
    }
}


