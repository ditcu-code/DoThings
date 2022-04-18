//
//  HomeCardView.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 10/04/22.
//

import SwiftUI

struct CardModel: Identifiable {
    let id: Int
    let symbol: String
    let title: String
    let color: Color
}

struct HomeCardView<Content: View>: View {
    let data: CardModel
    
    @ObservedObject var globalObj: GlobalObject
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationLink(destination: content) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: self.data.symbol)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .leading)
                        .foregroundColor(self.data.color)
                    Spacer()
                    Text(String(
                        self.data.title == "Done" ?
                        globalObj.taskList.filter({$0.isDone && !$0.isDeleted}).count :
                        globalObj.taskList.filter({!$0.isDone && !$0.isDeleted}).count
                    ))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .opacity(0.8)
                }
                Text(self.data.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
            }
            .padding()
            .background(.background)
            .cornerRadius(20)
        }
        
    }
}

