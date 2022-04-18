//
//  Model.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 10/04/22.
//

import Foundation

struct TaskModel: Identifiable {
    var id: UUID = UUID()
    var title: String
    var desc: String
    var startDate: Date
    var endDate: Date
    var isDone: Bool
    var isDeleted: Bool
    var alert: AlertPattern
}

enum AlertPattern: String, CaseIterable {
    case none = "None"
    case sameTime = "At time of event"
    case fiveMin = "5 minutes before"
    case tenMin = "10 minutes before"
    case fifteenMin = "15 minutes before"
    case thirthyMin = "30 minutes before"
    case oneHour = "1 hour before"
    case twoHour = "2 hour before"
    case oneDay = "1 day before"
    case twoDay = "2 days before"
    case oneWeek = "1 week before"
}
