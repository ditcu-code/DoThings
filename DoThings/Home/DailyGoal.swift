//
//  DailyGoal.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 10/04/22.
//

import SwiftUI

struct DailyGoal: View {
    let goalList: [Double] = [50, 75, 100, 150]
    let MIN_HEIGHT: CGFloat = 70
    let MAX_HEIGHT: CGFloat = 300
    @Binding var height: CGFloat
    @ObservedObject var globalObj: GlobalObject
    
    var body: some View {
        let isExpand = height > MAX_HEIGHT/3
        ZStack(alignment: .top) {
            VStack {
                Rectangle()
                    .fill(.background)
                    .background(Color(red: 51/255, green: 150/255, blue: 255/255))
                    .frame(height: height)
                    .overlay(
                        isExpand ?
                        VStack {
                            ProgressCircle(progress: Double(height / MAX_HEIGHT * globalObj.currentPoint), total: globalObj.dailyGoal)
                            Text("\(Int(globalObj.currentPoint)) / \(Int(globalObj.dailyGoal))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }.scaleEffect(height/MAX_HEIGHT).padding(.top, 20)
                        : nil
                    )
                RoundedRectangle(cornerRadius: 5)
                    .offset(x: 0, y: -24)
                    .opacity(0.5)
                    .frame(width: 60, height: 5)
                    .padding(.top, 5)
                    .padding(.bottom, -20)
                    .background(.background)
            }
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        let down = value.translation.height + MIN_HEIGHT
                        let up = value.translation.height + MAX_HEIGHT
                        withAnimation(.linear) {
                            if (down > MIN_HEIGHT && down < MAX_HEIGHT && height < MAX_HEIGHT) {
                                height = down
                            } else if (down < MIN_HEIGHT && up > MIN_HEIGHT && height > MIN_HEIGHT) {
                                height = up
                            } else if (height == MAX_HEIGHT) {
                                height = MAX_HEIGHT + MIN_HEIGHT/2
                            } else if (height == MIN_HEIGHT) {
                                height = MIN_HEIGHT - 10
                            }
                        }
                    }
                    .onEnded{ value in
                        withAnimation(.spring()) {
                            if (height > MAX_HEIGHT/2) {
                                height = MAX_HEIGHT
                            } else if (height < MAX_HEIGHT/2) {
                                height = MIN_HEIGHT
                            }
                        }
                    }
            )
            VStack {
                HStack{
                    Text("Daily Goal")
                        .font(isExpand ? .headline : .subheadline)
                        .foregroundColor(Color.gray)
                    Spacer()
                    Picker("", selection: $globalObj.dailyGoal) {
                        ForEach(goalList, id: \.self) {
                            Text("\(Int($0)) pts/day").tag($0)
                        }
                    }
                    .disabled(!isExpand)
                }
                .padding(.top, 10)
                if (!isExpand) {
                    ProgressView("", value: globalObj.currentPoint, total: globalObj.dailyGoal)
                        .padding(.top, -30)
                }
            }
            .animation(.linear, value: height)
            .padding(.horizontal, 20)
        }
    }
}
