//
//  ContentView.swift
//  FoodPicker
//
//  Created by zhaixl on 2024/8/20.
//

import SwiftUI

struct ContentView: View {
    let foods = Food.examples
    
    @State private var selectFood: Food?
    @State private var showInfo: Bool = false
    
    var body: some View {
        ScrollView{
            VStack (spacing: 30) {
                Group{
                    if selectFood != .none {
                        Image("dinner1")
                            .font(.system(size: 200)).background(Color(.red))
                    }else{
                        Image("dinner")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }.frame(height: 250)
                
                Text("今天吃什么？")
                    .bold()
                
                if selectFood != .none {
                    HStack{
                        Text(selectFood!.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.green)
                            .id(selectFood!.name)
                        
                        Button {
                            showInfo = !showInfo
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Text("热量 \(selectFood!.calorie) 大卡")
                        .font(.title2)
                    
                    VStack {
                        if showInfo {
                            HStack{
                                VStack(spacing: 12){
                                    Text("蛋白质")
                                    Text(selectFood!.protein.formatted() + "g")
                                }
                                
                                Divider().frame(width: 1).padding(.horizontal)
                                
                                VStack(spacing: 12){
                                    Text("脂肪")
                                    Text(selectFood!.fat.formatted() + "g")
                                }
                                
                                Divider().frame(width: 1).padding(.horizontal)
                                
                                VStack(spacing: 12){
                                    Text("碳水")
                                    Text(selectFood!.carb.formatted() + "g")
                                }
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.systemBackground)))
                            .transition(.move(edge: .top))
                            
                            //
                            //                    Grid {
                            //                        GridRow {
                            //                            Text("蛋白质")
                            //                            Text("脂肪")
                            //                            Text("碳水")
                            //                        }
                            //                    }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipped()
//                    .border(.green)
                }
                
                Spacer().layoutPriority(1)
                
                Button {
                    withAnimation {
                        selectFood = foods.shuffled().filter{
                            $0 != selectFood
                        }.first
                    }
                } label: {
                    Text(selectFood == .none ? "告诉我" : "换一个")
                        .frame(width: 200)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom,-15)
                
                
                Button {
                    withAnimation {
                        selectFood = .none
                    }
                } label: {
                    Text("重置")
                        .frame(width: 200)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth: .infinity,minHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .tint(.cyan)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .animation(.spring(dampingFraction: 0.5), value: showInfo)
            .animation(.easeOut, value: selectFood)
        }
        .background(Color(.secondarySystemBackground))
    }
}

extension ContentView {
    init(selectFood: Food){
        _selectFood = State(wrappedValue: selectFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectFood: .examples.first!)
    }
}
