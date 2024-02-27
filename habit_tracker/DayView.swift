//
//  DayView.swift
//  habit_tracker
//
//  Created by Ulia on 2/26/24.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var habitsManager: HabitsManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("February 26, 2024")
                    
                    Spacer()
                                
                    if !habitsManager.allHabits.isEmpty {
                        VStack {
                            ForEach(habitsManager.allHabits) { habit in
                                Text(habit.name)
                            }
                        }
                        .padding()
                    } else {
                        Text("No habits yet.")
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Monday")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//#Preview {
//    DayView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let habitsManager = HabitsManager()
        habitsManager.allHabits = [
            Habit(name: "Exercise"),
            Habit(name: "Read"),
            Habit(name: "Meditate")
        ]
        return ContentView().environmentObject(habitsManager)
    }
}
