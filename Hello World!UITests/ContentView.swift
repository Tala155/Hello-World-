//
//  ContentView.swift
//  Hello World!
//
//  Created by Tala Abdullah on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            VStack{
                HStack{
                    VStack{
                        Text("Food Recipes")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(width: 361.0, height: 41.0)
                            .padding()
                    }; Button("+") {
                            
                        }.frame(width: 44.0, height: 44.0) .foregroundColor(Color(red: 0.967, green: 0.377, blue: 0.068))
                }.padding(.trailing,100)
                .background(Color(red: 0.106, green: 0.106, blue: 0.106))
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .foregroundColor(Color(red: 0.985, green: 0.379, blue: 0.072))
                    .frame(width: 325.0, height: 327.0)
                Text("There's no recipe yet")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 330.0, height: 40.0)
                Text("Please add your recipes")
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .frame(width: 238.0)
            }
            }
        
       
        .padding()
    }
}

 #Preview {
    ContentView()
}
