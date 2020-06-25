

import Foundation

extension Date {
//    func isSameDay(_ date: Date) -> Bool {
//        let diff = Calendar.current.dateComponents([.day], from: self, to: date)
//        if diff.day == 0 {
//            return true
//        } else {
//            return false
//        }
//    }
    
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
}
