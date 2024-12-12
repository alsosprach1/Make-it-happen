//
//  HomeView.swift
//  Make it happen
//
//  Created by Gianmaria Longobucco on 13/12/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
struct HomeView: View {
    @State private var showModal = false // Stato per mostrare la modale
    @State private var selectedTime = Date() // Stato per l'orario
    @State private var selectedOption = 0 // Stato per il segmented control

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                              colors: [
                                  Color(hex: "#3A1C71"),
                                  Color(hex: "#D76D77"),
                                  Color(hex: "#FFAF7B")
                              ],
                              startPoint: .bottomLeading,
                              endPoint: .topTrailing
                          )
                          .ignoresSafeArea() // Importante per coprire tutta l'area

                VStack {
                    Spacer()
                    // Bottone con effetto vetro
                    Button(action: {
                        showModal.toggle() // Mostra la modale
                    }) {
                        Text("Plan your gift")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
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
            .navigationTitle("Welcome")
            .sheet(isPresented: $showModal) {
                // Contenuto della Modale
                ModalView(
                    selectedTime: $selectedTime,
                    selectedOption: $selectedOption
                
                )
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
