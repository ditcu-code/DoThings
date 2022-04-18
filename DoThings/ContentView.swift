//
//  ContentView.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 05/04/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var globalData = GlobalObject()
    
    @State var height: CGFloat = 70
    let cardData: [CardModel] = [
        CardModel(id: 1, symbol: "list.bullet.circle.fill", title: "To do", color: Color.orange),
        CardModel(id: 2, symbol: "tray.circle.fill", title: "Done", color: Color.blue)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .opacity(0.2)
                    .ignoresSafeArea()
                VStack {
                    DailyGoal(height: $height, globalObj: self.globalData)
                    ScrollView{
                        ForEach(cardData) {row in
                            HomeCardView(data: row, globalObj: self.globalData) {
                                TodoList(listType: row.title, globalObj: self.globalData)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .animation(.linear, value: height)
            }
            .navigationTitle("DoThings")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {self.globalData.isSheetOpen.toggle()}) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Task")
                                .fontWeight(.bold)
                        }
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }

            }
            .sheet(isPresented: self.$globalData.isSheetOpen){
                NewTask(globalObj: self.globalData)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
