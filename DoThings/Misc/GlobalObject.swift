//
//  DataUser.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 07/04/22.
//

import Foundation

class GlobalObject: ObservableObject {
    
    func dateMaker(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: date)
        return someDateTime ?? Date.now
    }
    
    @Published var taskList: [TaskModel] = [
        TaskModel(title: "Redesign personal website", desc: "Check on awwwards for inspiration", startDate: Date("2022/04/01 08:30"), endDate: Date("2022/04/04 11:30"), isDone: true, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Slicing interface", desc: "Target: homepage is done", startDate: Date("2022/04/01 13:00"), endDate: Date("2022/04/01 16:30"), isDone: true, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Purchase the domain", desc: "Check on niagahoster for eligible coupons", startDate: Date("2022/04/02 07:00"), endDate: Date("2022/04/02 09:30"), isDone: true, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Push to the moon", desc: "Push your website to the domain", startDate: Date("2022/04/2 10:00"), endDate: Date("2022/04/02 12:00"), isDone: true, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Get user's feedbacks", desc: "Check email for the user list", startDate: Date("2022/04/04 08:30"), endDate: Date("2022/04/04 10:00"), isDone: false, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Synthesize the solution", desc: "Make the solution from feedbacks", startDate: Date.yesterday, endDate: Date.yesterday, isDone: false, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Validate proposed solution", desc: "Make sure it could solve their problem", startDate: Date.now, endDate: Date.now, isDone: false, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Project finalization", desc: "", startDate: Date.tomorrow, endDate: Date.tomorrow, isDone: false, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "Prototype", desc: "", startDate: Date("2022/04/13 10:00"), endDate: Date("2022/04/13 10:00"), isDone: false, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "D-Day presentation", desc: "", startDate: Date("2022/04/20 10:00"), endDate: Date("2022/04/20 12:00"), isDone: false, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "SV sharing session", desc: "Don't forget to attend as speaker", startDate: Date("2022/04/22 10:00"), endDate: Date("2022/04/22 12:00"), isDone: false, isDeleted: false, alert: AlertPattern.none),
        TaskModel(title: "WWDC submission", desc: "Make sure everything is fulfilled the requirements", startDate: Date("2022/04/23 10:00"), endDate: Date("2022/04/20 12:00"), isDone: false, isDeleted: false, alert: AlertPattern.none)
    ]
    
    @Published var isSheetOpen: Bool = false
    
    @Published var dailyGoal: Double = 50.0
    
    @Published var currentPoint: Double = 30.0
}
