//
//  PropertyListViewModel.swift
//  PropertyMap
//
//  Created by Mostafa Mazrouh on 2023-05-12.
//

import Foundation


@MainActor
class PropertyListViewModel: ObservableObject {
    
    @Published var propertyItemArray: [PropertyItemDataModel] = []
    
    let propertyRepository: PropertyRepositoryInterface
    
    init(propertyRepository: PropertyRepositoryInterface = PropertyRepository()) {
        self.propertyRepository = propertyRepository
    }
    
    func getPropertyList() async {
        Task {
            self.propertyItemArray = await propertyRepository.getPropertyList()
        }
    }
    
}
