//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Oliver Lippold on 13/04/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favourites = Favourites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                    .resizable()
                    .scaledToFit()
                        .frame(width: 40, height: 25)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                    )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favourites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favourite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
        .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
    .environmentObject(favourites)
    .phoneOnlyStackNavigationView()
       
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
