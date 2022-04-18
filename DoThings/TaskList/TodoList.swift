//
//  TodoList.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 06/04/22.
//

import SwiftUI

struct TodoList: View {
    var listType: String
    @State var isChecked: Bool = false
    @ObservedObject var globalObj: GlobalObject
    
    var body: some View {
        let isTodoPage = listType == "To do"
        let todoList = self.$globalObj.taskList.filter({!$0.isDone.wrappedValue && !$0.isDeleted.wrappedValue}).sorted(by: {$0.startDate.wrappedValue < $1.startDate.wrappedValue})
        let doneList = self.$globalObj.taskList.filter({$0.isDone.wrappedValue && !$0.isDeleted.wrappedValue}).sorted(by: {$0.startDate.wrappedValue < $1.startDate.wrappedValue})
        
        List {
            if (isTodoPage) {
                ForEach(todoList, id: \.id) {$taskDetail in
                    TaskRow(taskDetail: taskDetail, isTodoPage: isTodoPage, globalObj: globalObj) {
                        TaskDetail(task: taskDetail, globalObj: globalObj)
                    }
                    .swipeActions(edge: .leading) {
                        Button("Done", action: {
                            withAnimation{
                                taskDetail.isDone.toggle()
                                globalObj.currentPoint += 15
                            }
                        })
                        .tint(.green)
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Delete") {
                            withAnimation{
                                taskDetail.isDeleted.toggle()
                            }
                        }
                        .tint(.red)
                    }
                    .padding(.vertical, 10)
                }
            } else {
                ForEach(doneList, id: \.id) {$taskDetail in
                    TaskRow(taskDetail: taskDetail, isTodoPage: isTodoPage, globalObj: globalObj) {
                        TaskDetail(task: taskDetail, globalObj: globalObj)
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Delete") {
                            withAnimation{
                                taskDetail.isDeleted.toggle()
                            }
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Back to do", action: {
                            withAnimation{
                                taskDetail.isDone.toggle()
                                if (globalObj.currentPoint > 0) {
                                    globalObj.currentPoint -= 15
                                }
                            }
                        })
                        .tint(.indigo)
                    }
                    .padding(.vertical, 10)
                }
            }
        }
        
        .navigationBarTitle(listType)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {globalObj.isSheetOpen.toggle()}) {
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
    }
}
