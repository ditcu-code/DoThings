//
//  NewTask.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 05/04/22.
//

import SwiftUI

struct NewTask: View {
    @ObservedObject var globalObj: GlobalObject
    @State var taskDetail: TaskModel = TaskModel(title: "", desc: "", startDate: Date.now, endDate: Date.now, isDone: false, isDeleted: false, alert: AlertPattern.none)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $taskDetail.title)
                    TextField("Description", text: $taskDetail.desc)
                }
                Section {
                    DatePicker(selection: $taskDetail.startDate, label: { Text("Start") })
                    DatePicker(selection: $taskDetail.endDate, in: taskDetail.startDate..., label: { Text("End") })
                    Picker("Alert", selection: $taskDetail.alert) {
                        ForEach(AlertPattern.allCases, id: \.self) { alert in
                            Text(alert.rawValue)
                        }
                    }
                }
            }
            .padding(.top, 30)
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.all)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.globalObj.isSheetOpen.toggle()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if (taskDetail.alert != .none) {
                            let content = UNMutableNotificationContent()
                            content.title = taskDetail.title
                            content.body = dateCaller(taskDetail.startDate)
                            
                            //TODO: Step 2b - Trigger the notification
                            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: alertDate(taskDetail.startDate, taskDetail.alert)), repeats: false)
                            
                            //TODO: Step 2c - Add content & trigger to the request
                            
                            let request = UNNotificationRequest(identifier: taskDetail.id.uuidString, content: content, trigger: trigger)
                            
                            //TODO: Step 2d - Add request to notification center
                            UNUserNotificationCenter.current().add(request)
                        }
                        globalObj.taskList.append(taskDetail)
                        self.globalObj.isSheetOpen.toggle()
                    }, label: {
                        Text("Save").fontWeight(.bold)
                    })
                    .disabled(taskDetail.title.isEmpty)
                }
            }
        }
    }
}
