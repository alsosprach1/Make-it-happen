
//: A SwiftUI based Playground for testing out views

import SwiftUI

struct CardView: View {
    @State var dragOffset: CGSize = .zero
    @State var isDragging: Bool = false
    @State var isFlipped: Bool = false
    @Binding var selectedTime: Date
    @Binding var selectedPurpose: String
    
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
                    .frame(width: 300, height: 400)
                    .shadow(radius: 15)
                    .overlay(
                        Text("Your gift time is : \(formattedTime())")
                            .font(.title)
                            .foregroundStyle(.white)
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
                    .frame(width: 300, height: 400)
                    .shadow(radius: 15)
                    .overlay(
                        Text("Your gift purpose is:\(selectedPurpose)")
                            .font(.title)
                            .foregroundStyle(.white)
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
    @State var selectedTime = Date()
    @State var selectedPurpose = "Therapy"
    CardView(selectedTime: $selectedTime, selectedPurpose: $selectedPurpose) // Passa un valore di esempio
}
