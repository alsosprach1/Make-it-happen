//
//  ContentView.swift
//  Make it happen
//
//  Created by Gianmaria Longobucco on 18/12/24.
//


import SwiftUI
import AVFoundation


struct button: View {
    @State private var isTapped = false
    @State private var audioPlayer: AVAudioPlayer?
    
    let gradientColors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        ZStack {
            // Gradiente animato che cambia da nero al gradiente e poi ritorna a nero
            LinearGradient(gradient: Gradient(colors: isTapped ? gradientColors : [.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 2), value: isTapped)
            
            VStack {
                Button(action: {
                    // Cambia lo stato per avviare l'animazione e riprodurre il suono
                    isTapped = true
                    
                    // Dopo 2 secondi, torna a nero
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isTapped = false
                    }
                }) {
                    Text("Tocca il bottone")
                        .font(.title)
                        .padding()
                        .background(Capsule().fill(Color.white.opacity(0.7)))
                        .foregroundColor(.black)
                        .shadow(radius: 10)
                }
            }
        }
    }
    
    // Funzione per riprodurre l'effetto sonoro
    
    // Funzione per riprodurre l'effetto sonor
}

#Preview {
    button()
}
