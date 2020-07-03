import UIKit

//MARK:- Navigation bar clear
extension UINavigationBar {
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}

extension UIColor {
    static let daySelected = UIColor(red: 62/255.0, green: 133/255.0, blue: 112/255.0, alpha: 1.0)
}

extension String {
    func extractTimeInfo() -> String? {        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier:"UTC")

        guard let date = dateFormatter.date(from:self) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "HH:mm"
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
    
    func formattedDate(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier:"UTC")
        return dateFormatter.date(from: self)
    }
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }
    
    var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    var monthName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    
    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }
    
    var currentMonthDates: [Date] {
        let calendar = Calendar.current
        let interval = calendar.dateInterval(of: .month, for: self)!
        
        // Fetch Total days in a month
        let days = calendar.dateComponents([.day], from: self, to: interval.end).day!
        
        var dates: [Date] = []
        
        for i in 0..<days {
            let nextDay = calendar.date(byAdding: .day, value: i, to: self)
            dates.append(nextDay!)
        }
        
        return dates
    }
}
