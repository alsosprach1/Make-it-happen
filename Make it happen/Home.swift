//
//  HomeView.swift
//  Make it happen
//
//  Created by Gianmaria Longobucco on 13/12/24.
//

import SwiftUI

struct Home: View {
    @State private var showModal = false // Stato per mostrare la modale
    @State var selectedPurpose = "Therapeutic"
    @State var showCard = false
    @State private var selectedTime = Date()
    @State var isTapped = false
    let gradientColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: isTapped ? gradientColors : [.black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 2), value: isTapped)
                //                LinearGradient(
                //                    colors: [
                //                        Color(hex: "#3A1C71"),
                //                        Color(hex: "#D76D77"),
                //                        Color(hex: "#FFAF7B")
                //                    ],
                //                    startPoint: .bottomLeading,
                //                    endPoint: .topTrailing
                //                )
                    .ignoresSafeArea() // Importante per coprire tutta l'area
                if showCard{
                    CardView(isTapped:$isTapped,selectedTime:$selectedTime, selectedPurpose: $selectedPurpose)
                }else{
                    VStack {
                        Spacer()
                        // Bottone con effetto vetro
                        Button(action: {
                            showModal.toggle() // Mostra la modale
                        }) {
                            Text("Plan your gift")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.white.opacity(0.3),
                                                Color.white.opacity(0.1)
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                        .blur(radius: 10)
                                        
                                        Color.white.opacity(0.2)
                                    }
                                )
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.white.opacity(0.6),
                                                    Color.white.opacity(0.2)
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1
                                        )
                                )
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 60)
                        Spacer()
                    }
                    
                }
            }
            .navigationTitle("Make it happen!")
            .sheet(isPresented: $showModal) {
                // Contenuto della Modale
                TwoStepModalView(selectedTime: $selectedTime, selectedPurpose: $selectedPurpose, showCard: $showCard)
            }
        }
    }
}
    
    #Preview {
        Home()
    }

