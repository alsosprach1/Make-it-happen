import Foundation

class DataManager {
    private let giftDataKey = "giftDataKey"
    
    // Funzione per salvare i dati
    func saveGiftData(giftData: GiftData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(giftData) {
            UserDefaults.standard.set(encoded, forKey: giftDataKey)
        }
    }
    
    // Funzione per caricare i dati
    func loadGiftData() -> GiftData? {
        if let savedData = UserDefaults.standard.data(forKey: giftDataKey) {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(GiftData.self, from: savedData) {
                return loadedData
            }
        }
        return nil
    }
}
