//
//  HomeView.swift
//  Make it happen
//
//  Created by Gianmaria Longobucco on 12/12/24.
//


import SwiftUI

struct GiftCard: Identifiable {
    let id = UUID()
    var time: Date
    var option: String
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedTime: Date
    @Binding var selectedOption: Int
    
    var onSave: (() -> Void)?
    let options = ["Reward", "Celebration", "Therapeutic"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Scegli l'orario")) {
                    DatePicker("Orario", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(CompactDatePickerStyle())
                }
                Section(header: Text("Scegli un'opzione")) {
                    Picker("Options", selection: $selectedOption) {
                        ForEach(0..<options.count) { index in
                            Text(options[index]).tag(index)
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
            }
            .navigationTitle("Pianifica Regalo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salva") {
                        onSave?()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(selectedTime: .constant(Date()), selectedOption: .constant(0))
    }
}
