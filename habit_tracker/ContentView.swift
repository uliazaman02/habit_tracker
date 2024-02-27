//
//  ContentView.swift
//  habit_tracker
//
//  Created by Ulia on 2/21/24.
//

import SwiftUI

class HabitsManager: ObservableObject {
    @Published var allHabits: [Habit] = []
}

extension Color {
    static let lightestPink = Color(red: 254/255, green: 218/255, blue: 225/255)
    static let backgroundYellow = Color(red: 255/255, green: 255/255, blue: 232/255)
    static let midnightBlue = Color(red: 22/255, green: 61/255, blue: 106/255)
    static let lightBlue = Color(red: 173/255, green: 231/255, blue: 255/255)
    static let buttonBlue = Color(red: 98/255, green: 179/255, blue: 241/255)
    
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.buttonBlue)
//            .background(configuration.isPressed ? Color.white : Color.pink)
//            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .cornerRadius(8)
//            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct Habit: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted = false
}

struct ContentView: View {
    @State private var newHabitInput: String = ""
//    @State private var allHabits: [Habit] = []
    @State private var mainButton: Bool = false
    @StateObject private var habitsManager = HabitsManager()
    
    var body: some View {
        VStack {
            Text("Habit Tracker")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.title)
                .foregroundColor(.midnightBlue)
                .padding()
            
            Spacer()
            
            if mainButton && !habitsManager.allHabits.isEmpty {
                VStack {
                    HStack {
                        Spacer()
                    }
                    
                    ForEach(habitsManager.allHabits) { habit in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.pink, lineWidth: 2)
                                .padding(10)
                            
                            HStack {
                                Text(habit.name)
                                    .padding(.leading, 30)
                                
                                Spacer()
                                
                                Button(action: {
                                    toggleCompletion(for: habit)
                                }) {
                                    Image(systemName: habit.isCompleted ? "circle.fill" : "circle")
                                        .foregroundColor(habit.isCompleted ? .pink : .black)
                                }
                                .padding(.trailing, 30)
                            }
                        }
                        .frame(width: .infinity, height: 100)
                    }
                }
                .padding()
            }
            
            TextField("New Habit", text: $newHabitInput)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightBlue))
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.midnightBlue, lineWidth: 1)
                            .padding()
                )
            
            Button("Add New Habit") {
                mainButton = true
                habitsManager.allHabits.append(Habit(name: newHabitInput))
                newHabitInput = ""
            }
            .buttonStyle(CustomButtonStyle())
            
            Spacer()
        }.background(Color.backgroundYellow)
    }
    
    private func toggleCompletion(for habit: Habit) {
        if let index = habitsManager.allHabits.firstIndex(where: { $0.id == habit.id }) {
            habitsManager.allHabits[index].isCompleted.toggle()
        }
    }
    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//        }
//    }
}

#Preview {
    ContentView()
}
