//
//  PropertyListViewModelTests.swift
//  PropertyMapTests
//
//  Created by Mostafa Mazrouh on 2023-05-15.
//

import XCTest
@testable import PropertyMap

class PropertyRepositoryMock: PropertyRepositoryInterface {
    
    var bundel: Bundle = Bundle(for: PropertyListViewModelTests.self)
    
    func getPropertyList() async -> [PropertyMap.PropertyItemDataModel] {
        
        if let path = bundel.path(forResource: "PropertyList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                if let propertyListModel = try? JSONDecoder().decode(PropertyListDataModel.self, from: data) {
                    
                    return propertyListModel.items
                }
            }
            catch {
                XCTFail("Can't read PropertyList.json")
            }
        } else {
            XCTFail("Can't get path to PropertyList.json")
        }
        
        return []
    }
    
    func getPropertyDetails() async -> PropertyMap.PropertyItemDataModel? {
        return nil
    }
    
}


@MainActor
final class PropertyListViewModelTests: XCTestCase {

    var propertyListViewModel: PropertyListViewModel!
    
    override func setUpWithError() throws {
        let propertyRepositoryMock: PropertyRepositoryInterface = PropertyRepositoryMock()
        propertyListViewModel = PropertyListViewModel(propertyRepository: propertyRepositoryMock)
    }

    override func tearDownWithError() throws {
        propertyListViewModel = nil
    }

    func testExample() async throws {
        
        let propertyList = await propertyListViewModel.propertyRepository.getPropertyList()
        
        let propertyItemType = propertyList[0].propertyItemType
        let itemArea = propertyList[0].itemArea
        
        XCTAssert(propertyItemType == .HighlightedProperty, "Wrong property type")
        XCTAssert(itemArea == "Heden", "Area is Heden")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
