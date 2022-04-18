//
//  EditTask.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 10/04/22.
//

import SwiftUI

struct EditTask: View {
    @ObservedObject var globalObj: GlobalObject
    var editedTask: TaskModel
    @State var taskDetail: TaskModel = TaskModel(title: "", desc: "", startDate: Date.now, endDate: Date.now, isDone: false, isDeleted: false, alert: AlertPattern.none)
    
    var body: some View {
        let index = globalObj.taskList.firstIndex(where: {$0.id == editedTask.id})
        let data = $globalObj.taskList[index ?? 0]
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
                .onAppear(perform: {
                    if (taskDetail.id != editedTask.id) {
                        taskDetail = data.wrappedValue
                    }
                })
            }
            .padding(.top, 30)
            .navigationTitle("Edit Task")
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
                        if index != nil {
                            self.globalObj.taskList[index!] = self.taskDetail
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
                        }
                        self.globalObj.isSheetOpen.toggle()
                    }, label: {
                        Text("Save")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}
