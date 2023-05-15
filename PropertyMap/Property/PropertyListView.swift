//
//  PropertyView.swift
//  PropertyMap
//
//  Created by Mostafa Mazrouh on 2023-05-12.
//

import SwiftUI

struct PropertyListView: View {
    
    @StateObject var propertyListViewModel = PropertyListViewModel()
    
    @State private var showingSheet = false
    
    var body: some View {
        
        List(propertyListViewModel.propertyItemArray) { propertyItem in
            
            if(propertyItem.propertyItemType == .Area) {
                AreaView(propertyItemDataModel: propertyItem)
                    .listRowSeparator(.hidden)
            } else {
                PropertyItemView(propertyItemDataModel: propertyItem)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        showingSheet =
                        (propertyItem.propertyItemType == .HighlightedProperty)
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .task {
            await propertyListViewModel.getPropertyList()
        }
        .sheet(isPresented: $showingSheet) {
            PropertyDetailView()
        }
    }
}


struct PropertyItemView: View {
    
    var propertyItemDataModel: PropertyItemDataModel
    
    var isHighlighted: Bool {
        propertyItemDataModel.propertyItemType == .HighlightedProperty
    }
    
    var body: some View {
            
            VStack(alignment: .leading) {
                
                PropertyImageView(propertyURL: propertyItemDataModel.image, isHighlighted: isHighlighted)
                Spacer()
                
                Text(propertyItemDataModel.itemStreetAddress)
                    .bold()
                Spacer()
                
                Text(propertyItemDataModel.itemCombinedAddress)
                Spacer()
                
                HStack(alignment: .top) {
                    Text(propertyItemDataModel.itemAskingPrice)
                        .bold()
                    Spacer()
                    Text("120")
                        .bold()
                    Spacer()
                    Text("5 rooms")
                        .bold()
                }
                
                Spacer(minLength: 40)
        }
    }
}


struct AreaView: View {
    
    var propertyItemDataModel: PropertyItemDataModel
    
    var body: some View {
            
            VStack(alignment: .leading) {
                
                Text("Area")
                    .bold()
                
                PropertyImageView(propertyURL: propertyItemDataModel.image, isHighlighted: false)
                Spacer()
                
                Text(propertyItemDataModel.itemArea)
                    .bold()
                Spacer()
                
                Text(propertyItemDataModel.itemRatingFormatted)
                Spacer()
                
                Text(propertyItemDataModel.itemAveragePrice)
                Spacer(minLength: 40)
        }
    }
}


struct PropertyImageView: View {
    
    var propertyURL: String
    
    var isHighlighted: Bool
    
    var body: some View {
        AsyncImage(url: URL(string: propertyURL)) { phase in
            switch phase {
                
            case .empty:
                ProgressView()
                
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .border(isHighlighted ? Color.yellow : Color.clear, width: 4)
                    .cornerRadius(10)
                
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            @unknown default:
                // Since the AsyncImagePhase enum isn't frozen,
                // we need to add this currently unused fallback
                // to handle any new cases that might be added
                // in the future:
                EmptyView()
            }
        }
    }
}


struct PropertyListView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyListView()
    }
}


