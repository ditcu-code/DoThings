//
//  TaskRow.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 10/04/22.
//

import SwiftUI

struct TaskRow<Content: View>: View {
    var taskDetail: TaskModel
    var isTodoPage: Bool
    @ObservedObject var globalObj: GlobalObject
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack(alignment: .top) {
            let isDatePast = taskDetail.startDate < Date.now
            NavigationLink(destination: content){
                VStack(alignment: .leading) {
                    Text(taskDetail.title)
                        .font(.headline)
                        .tracking(0.4)
                        .lineLimit(2)
                        .padding(.bottom, -2)
                    Text(dateCaller(taskDetail.startDate).uppercased())
                        .font(.caption)
                        .tracking(0.2)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(isTodoPage ? (isDatePast ? .orange : .blue) : .gray)
                        .background(RoundedRectangle(cornerRadius: 5)
                            .fill(isTodoPage ? (isDatePast ? .orange : .blue) : .gray)
                            .opacity(0.1)
                        )
                }
            }
        }
    }
}
