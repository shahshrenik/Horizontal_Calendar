//
//  DayCell.swift
//  Calendar
//
//  Test Project
//

import UIKit

class DayCell: UICollectionViewCell {

    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weekday: UILabel!
    
    var date: Date? {
        didSet {
            self.day.text = date?.toString(format: "d")
            self.weekday.text = date?.dayOfWeek()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dayView!.backgroundColor = UIColor.daySelected
                dayView.layer.cornerRadius = dayView.frame.width / 2
                dayView.layer.masksToBounds = true
            } else {
                dayView!.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dayView.layer.cornerRadius = self.dayView.frame.width / 2.0
        self.dayView.backgroundColor = .clear
    }
    

    
}
