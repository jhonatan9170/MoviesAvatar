
import Foundation

extension String {
    func toLegibleDate(inputFormat:String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat

        guard let date = inputFormatter.date(from: self) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .long
        outputFormatter.timeStyle = .none

        return outputFormatter.string(from: date)
    }
}
