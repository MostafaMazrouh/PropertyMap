//
//  PropertyDetailViewModel.swift
//  PropertyMap
//
//  Created by Mostafa Mazrouh on 2023-05-14.
//

import Foundation

@MainActor
class PropertyDetailViewModel: ObservableObject {
    
    @Published var propertyItemDetailsModel: PropertyItemDataModel!
    
    let propertyRepository: PropertyRepositoryInterface
    
    init(propertyRepository: PropertyRepositoryInterface = PropertyRepository()) {
        self.propertyRepository = propertyRepository
    }
    
    func getPropertyDetails() async {
        
        Task {
            self.propertyItemDetailsModel = await propertyRepository.getPropertyDetails()
        }
    }
    
}
