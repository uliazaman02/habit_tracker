//
//  ContentView.swift
//  habit_tracker
//
//  Created by Ulia on 2/21/24.
//

import SwiftUI


struct ContentView: View {
    @State private var newHabit: String = ""
    
    var body: some View {
        VStack {
            Text("Habit Tracker")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
            
            Spacer()
            
            TextField("New Habit", text: $newHabit)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            Button("Add New Habit") {
                if !newHabit.isEmpty {
                    Text("\(newHabit)")
                }
            }
                .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        
//        Image(systemName: "globe")
//            .imageScale(.large)
//            .foregroundStyle(.tint)
    }
}

#Preview {
    ContentView()
}
