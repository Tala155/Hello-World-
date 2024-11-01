//
//  AddRecipe.swift
//  Hello World!
//
//  Created by Tala Abduallah on 28/10/2024.
//

import SwiftUI

struct AddRecipe: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showIngredientPop: Bool = false
    @State private var ingredientName: String = ""
    @State private var selectedMeasurement: String = "Spoon"
    @State private var serving: Int = 1

    var body: some View {
        VStack {
            // Photo upload section
            ZStack {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundColor(.red)
                    .background(Color(.systemGray6))
                    .frame(maxWidth: .infinity, maxHeight: 250)
                VStack {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color("Orangi.Recipe"))
                    Text("Upload Photo")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.bottom, 10)
                }
            }
            .padding(.vertical, 25)
            
            // Title field
            VStack(alignment: .leading, spacing: 8) {
                Text("Title").font(.system(size: 18, weight: .bold))
                TextField("Title", text: $recipeViewModel.recipeName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            // Description field
            VStack(alignment: .leading, spacing: 8) {
                Text("Description").font(.system(size: 18, weight: .bold))
                TextField("Description",text: $recipeViewModel.recipeDescription)
                    .scrollContentBackground(.hidden)
                    .frame(height: 100)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            // Add Ingredient section
            HStack {
                Text("Add Ingredient").font(.system(size: 18, weight: .bold))
                Spacer()
                Button(action: { showIngredientPop.toggle() }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color("Orangi.Recipe"))
                        .font(.system(size: 24))
                }
            }
            .padding(.horizontal)
            
            
            ForEach(recipeViewModel.ingredients) { ingredient in
                HStack {
                    Text("\(ingredient.serving)")
                        .font(.system(size: 18, weight: .bold))
                    Text(ingredient.name)
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                    Text(ingredient.measurement)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .background(Color.gray.opacity(0.1))
                .padding(.horizontal)
                .padding(.top, 20)
            }
        }
        .navigationTitle("New Recipe")
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: MainView()) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color("Orangi.Recipe"))
                        Text("back")
                            .font(.system(size: 20))
                            .foregroundColor(Color("Orangi.Recipe"))
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Call addRecipe and dismiss the view
                    recipeViewModel.addRecipe()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .font(.system(size: 20))
                        .foregroundColor(Color("Orangi.Recipe"))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackgroundVisibility(.visible)
        .overlay(
            Group {
                if showIngredientPop {
                    // Ingredient pop-up overlay
                    Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                        .onTapGesture { showIngredientPop.toggle() }
                    VStack(spacing: 20) {
                        Text("Ingredient Name").font(.headline)
                        TextField("Ingredient Name", text: $ingredientName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        HStack {
                            Text("Measurement").font(.headline)
                            Spacer()
                        }
                        // Measurement buttons
                        HStack {
                            Button(action: { selectedMeasurement = "Spoon" }) {
                                Text("🥄 Spoon")
                                    .foregroundColor(Color.black)
                                    .padding()
                                    .background(selectedMeasurement == "Spoon" ? Color.orange : Color.gray.opacity(0.3))
                                    .cornerRadius(8)
                            }
                            Button(action: { selectedMeasurement = "Cup" }) {
                                Text("🍵 Cup")
                                    .foregroundColor(Color.black)
                                    .padding()
                                    .background(selectedMeasurement == "Cup" ? Color.orange : Color.gray.opacity(0.3))
                                    .cornerRadius(8)
                            }
                        }
                        // Serving input
                        HStack {
                            Text("Serving").font(.headline)
                            Spacer()
                        }
                        HStack {
                            Button(action: { if serving > 1 { serving -= 1 } }) {
                                Image(systemName: "minus")
                                    .foregroundColor(Color.black)
                            }
                            Text("\(serving)").padding(.horizontal)
                            Button(action: { serving += 1 }) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.black)
                            }
                            Text(selectedMeasurement).padding(.horizontal).background(Color.orange).cornerRadius(8)
                        }
                        // Cancel and Add buttons
                        HStack {
                            Button(action: { showIngredientPop = false }) {
                                Text("Cancel").foregroundColor(.red).padding().frame(maxWidth: .infinity).background(Color(.systemGray6)).cornerRadius(8)
                            }
                            Button(action: {
                              
                                recipeViewModel.addIngredient(name: ingredientName, measurement: selectedMeasurement, serving: serving)
                                
                                ingredientName = ""
                                selectedMeasurement = "Spoon"
                                serving = 1

                                showIngredientPop = false
                            }) {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .cornerRadius(8)
                            }

                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .frame(maxWidth: 300)
                    .padding()
                }
            }
        )
    }
}

#Preview {
    AddRecipe(recipeViewModel: RecipeViewModel())
}
