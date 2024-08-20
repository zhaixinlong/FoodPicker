//
//  ContentView.swift
//  FoodPicker
//
//  Created by zhaixl on 2024/8/20.
//

import SwiftUI

struct ContentView: View {
    let foods = ["刀削面","炒面","汉堡","沙拉"]
    
    @State private var selectFood: String?
    
    
    var body: some View {
        VStack (spacing: 30) {
            
            Image("dinner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                                              
                           
            Text("今天吃什么？")
                .bold()
            
            if selectFood != .none {
                Text(selectFood ?? "")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
            }
            
            Button {
                selectFood = foods.shuffled().filter{
                    $0 != selectFood
                }.first
            } label: {
                Text(selectFood == .none ? "告诉我" : "换一个")
                    .frame(width: 200)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom,-15)

            
            Button {
                selectFood = .none
            } label: {
                Text("重置")
                    .frame(width: 200)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .font(.title)
        .tint(.cyan)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .animation(.easeOut, value: selectFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
