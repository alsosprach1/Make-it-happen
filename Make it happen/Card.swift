
//: A SwiftUI based Playground for testing out views

import SwiftUI

struct CardView: View {
    @State var dragOffset: CGSize = .zero
    @State var isDragging: Bool = false
    @State var isFlipped: Bool = false
    @Binding var isTapped: Bool
    @Binding var selectedTime: Date
    @Binding var selectedPurpose: String
    
    let imageGift: [String: String] = [
           "Therapeutic": "cross.vial",
           "Celebration": "fireworks",
           "Reward": "star"
       ]
    let giftMessage: [String: String] = [
        "Therapeutic": "A therapy gift is a kind gesture you offer yourself to support healing and growth after challenging times.",
        "Celebration": "A celebration gift is a joyful gesture to honor special moments and create lasting memories of happiness and gratitude.",
        "Reward": "A reward gift is a well-deserved token of appreciation you give yourself to celebrate hard work and personal achievements."
    ]
    
    func formattedTime() -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "HH:mm" // Ora in formato 24 ore
          return dateFormatter.string(from: selectedTime)
      }
    var body: some View {
        ZStack {
            
            //Front of the card
            if !isFlipped {
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.3),
                                Color.white.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.3),
                                        Color.white.opacity(0.1)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 5
                            )
                            .blur(radius: 10)
                    )
                    .frame(width: 300, height: 350)
                    .shadow(radius: 15)
                    .overlay(
                        Image(systemName: imageGift[selectedPurpose] ?? "questionmark")
                            .font(.system(size: 128))
                            .foregroundColor(Color.white)
                            .padding(.bottom, 50)
                            
                    )
                    .overlay(
                        Text("Today's gift · \(selectedPurpose)")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .padding(.top, 250)
                            .padding(.trailing, 50)
                            .frame(width: 500)
                    )
                    .overlay(
                        Text("Today at \(formattedTime())")
                            .font(.body)
                            .foregroundStyle(.white)
                            .padding(.top,300)
                            .padding(.trailing,150)
                            .italic()
                    )

            } else {
                //Back of the card
                RoundedRectangle(cornerRadius: 25)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.3),
                                Color.white.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 300, height: 350)
                    .shadow(radius: 15)
                    .overlay(
                        Text(giftMessage[selectedPurpose] ?? "Choose a purpose to see the message.")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding(.bottom, 200)
                            .frame(maxWidth: 250)
                    )
                    .overlay(
                        Button(action: {
                            isTapped = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isTapped = false
                            }
                          
                        }) {
                            Text("Enjoy your gift")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 200)
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
                            .padding(.top,200)
                    )
                    
                    
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
               
        }
        
        
        
        //: code for the movement
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.init(degrees: Double(dragOffset.width) / 10), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.init(degrees: Double(dragOffset.height) / -10), axis: (x: 1, y: 0, z: 0))
        .gesture(DragGesture().onChanged { value in
            isDragging = true
            dragOffset = value.translation
        }.onEnded { _ in
            isDragging = false
            withAnimation(.spring) { dragOffset = .zero }
        })
        .onTapGesture {
            withAnimation(.spring) {
                isFlipped.toggle()
            }
        }
        
        
        
        .animation(isDragging ? .none : .spring(), value: dragOffset)
        
    }
}


#Preview {
    @Previewable @State var selectedTime = Date()
    @Previewable @State var selectedPurpose = "Therapy"
    @Previewable @State var isTapped=false
    CardView(isTapped: $isTapped,selectedTime: $selectedTime, selectedPurpose: $selectedPurpose ) // Passa un valore di esempio
}
