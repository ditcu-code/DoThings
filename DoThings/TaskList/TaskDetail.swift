//
//  TaskDetail.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 09/04/22.
//

import SwiftUI

struct TaskDetail: View {
    var task: TaskModel
    @ObservedObject var globalObj: GlobalObject
    
    func dateDesc(_ sDate: Date,_ eDate: Date) -> String {
        let calendar = Calendar.current
        let isSameDay = calendar.isDate(sDate, inSameDayAs: eDate)
        
        if isSameDay {
            return """
                    \(sDate.formatted(date: .long, time: .omitted)) from\n\(sDate.formatted(date: .omitted, time: .shortened)) to \(eDate.formatted(date: .omitted, time: .shortened))
                    """
        } else {
            return """
                    From \(sDate.formatted(date: .long, time: .shortened))\nto \(sDate.formatted(date: .long, time: .shortened))
                    """
        }
    }
    
    var body: some View {
        List{
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 10)
                Spacer()
                Text(task.desc)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.bottom, 5)
                Divider()
                HStack(alignment: .top) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.primary)
                        .padding(.top, 3)
                    Text(dateDesc(task.startDate, task.endDate))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.all, 5)
            }
            .padding(.vertical, 5)
        }
        .navigationBarTitle("Task Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {globalObj.isSheetOpen.toggle()}) {
                    Text("Edit")
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Spacer()
            }
        }
        .sheet(isPresented: $globalObj.isSheetOpen){
            EditTask(globalObj: globalObj, editedTask: task)
        }
    }
}
