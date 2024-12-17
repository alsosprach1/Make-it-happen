import SwiftUI

struct TwoStepModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentStep = 1 // Stato per le fasi
    @State private var selectedTime = Date() // Per il DatePicker
    @State private var selectedPurpose = "Relax" // Per il Picker
    let giftPurposes = ["Therapy", "Celebrate", "Reward"] // Opzioni per il Picker

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                if currentStep == 1 {
                    // Fase 1: Selezione dell'orario
                    VStack(spacing: 20) {
                        Image(systemName: "clock")
                            .font(.system(size: 80))
                            .foregroundColor(.black)

                        Text("Choose the perfect time to enjoy your today's gift!")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(CompactDatePickerStyle())
                            .padding(.horizontal, 50)
                    }
                } else if currentStep == 2 {
                    // Fase 2: Scelta dello scopo del regalo
                    VStack(spacing: 20) {
                        Image(systemName: "gift")
                            .font(.system(size: 80))
                            .foregroundColor(.black)

                        Text("What's the purpose of today's gift?")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        Picker("Purpose", selection: $selectedPurpose) {
                            ForEach(giftPurposes, id: \.self) { purpose in
                                Text(purpose)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .padding(.horizontal, 50)
                    }
                }

                Spacer()

                // Pulsante grande e centrato
                Button(action: {
                    withAnimation {
                        if currentStep == 1 {
                            currentStep = 2
                        } else {
                            // Azione finale
                            print("Time: \(selectedTime), Purpose: \(selectedPurpose)")
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }) {
                    Text(currentStep == 1 ? "Next" : "Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 50)
                }
            }
            .navigationTitle("Today")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct TwoStepModalView_Previews: PreviewProvider {
    static var previews: some View {
        TwoStepModalView()
    }
}
