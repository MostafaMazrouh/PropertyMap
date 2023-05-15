//
//  PropertyDataModel.swift
//  PropertyMap
//
//  Created by Mostafa Mazrouh on 2023-05-15.
//

import Foundation


struct PropertyListDataModel: Codable {
    let items: [PropertyItemDataModel]
}


struct PropertyItemDataModel: Codable, Identifiable {
    let type: String
    let id: String
    let askingPrice: Int?
    let monthlyFee: Int?
    let municipality: String?
    let area: String?
    let ratingFormatted: String?
    let averagePrice: Int?
    let daysSincePublish: Int?
    let livingArea: Int?
    let numberOfRooms: Int?
    let streetAddress: String?
    let image: String
    
    let description: String?
    let patio: String?
    
    var itemCombinedAddress: String {
        "\(area ?? ""), \(municipality ?? "")"
    }
    
    var itemStreetAddress: String {
        streetAddress ?? ""
    }
    
    var itemArea: String {
        area ?? ""
    }
    
    var itemRatingFormatted: String {
        "Rating: \(ratingFormatted ?? "")"
    }
    
    var itemAveragePrice: String {
        let formattedPrice = formatedPrice(price: averagePrice ?? 0)
        return "Average price: \(formattedPrice) m²"
    }
    
    var itemAskingPrice: String {
        let formattedPrice = formatedPrice(price: askingPrice ?? 0)
        return "\(formattedPrice) SEK"
    }
    
    var itemDescription: String {
        "\(description ?? "")"
    }
    
    var itemLivingArea: String {
        "\(livingArea ?? 0) m²"
    }
    
    var itemNumberOfRooms: String {
        "\(numberOfRooms ?? 0)"
    }
    
    var itemPatio: String {
        "\(patio ?? "")"
    }
    
    var itemDaysSincePublish: String {
        "\(daysSincePublish ?? 0)"
    }
    
    var propertyItemType: PropertyItemType {
        switch type {
        case "HighlightedProperty":
            return .HighlightedProperty
            
        case "Property":
            return .Property
         
        default: //case: "Area"
            return .Area
        }
    }
    
    
    enum PropertyItemType {
        case HighlightedProperty
        case Property
        case Area
    }
    
    func formatedPrice(price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        let number = NSNumber(value: price)
        guard let formattedValue = formatter.string(from: number) else {
            return ""
        }
        
        return formattedValue
    }
}
