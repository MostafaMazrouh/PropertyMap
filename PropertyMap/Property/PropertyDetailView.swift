//
//  PropertyDetailView.swift
//  PropertyMap
//
//  Created by Mostafa Mazrouh on 2023-05-14.
//

import SwiftUI

struct PropertyDetailView: View {
    
    @StateObject var propertyDetailViewModel = PropertyDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if propertyDetailViewModel.propertyItemDetailsModel == nil {
                ProgressView()
            } else {
                
                PropertyImageView(propertyURL: propertyDetailViewModel.propertyItemDetailsModel.image, isHighlighted: false)
                
                Text(propertyDetailViewModel.propertyItemDetailsModel.itemStreetAddress)
                    .bold()
                    .font(.system(size: 28))
                Spacer()
                
                Text(propertyDetailViewModel.propertyItemDetailsModel.itemCombinedAddress)
                    .foregroundColor(Color.gray)
                Spacer()
                
                Text(propertyDetailViewModel.propertyItemDetailsModel.itemAskingPrice)
                    .bold()
                Spacer(minLength: 30)
                
                Text(propertyDetailViewModel.propertyItemDetailsModel.itemDescription)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    ItemView(key: "Living area:", value: propertyDetailViewModel.propertyItemDetailsModel.itemLivingArea)
                    
                    ItemView(key: "Number of rooms:", value: propertyDetailViewModel.propertyItemDetailsModel.itemNumberOfRooms)
                    
                    ItemView(key: "Patio:", value: propertyDetailViewModel.propertyItemDetailsModel.itemPatio)
                    
                    ItemView(key: "Days since publish:", value: propertyDetailViewModel.propertyItemDetailsModel.itemDaysSincePublish)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .task {
            await propertyDetailViewModel.getPropertyDetails()
        }
    }
}

struct PropertyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyDetailView()
    }
}


struct ItemView: View {
    
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key)
                .bold()
            Text(value)
        }
    }
}
