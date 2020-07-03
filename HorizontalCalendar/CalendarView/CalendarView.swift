//
//  CalendarView.swift
//  Calendar
//
//  Test Project
//

import UIKit

protocol CalendarDelegate: class {
    func getSelectedDate(_ date: String)
}

class CalendarView: UIView {

    @IBOutlet weak var monthAndYear: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    var calendarArray:[Date] = [Date]()

    var currentDate: Date?
    var currentMonth:Int = 0
    var currentYear: Int = 0

    let calendar = Calendar.current
    private let cellID = "DayCell"
    weak var delegate: CalendarDelegate?
    
    //MARK:- Initialize calendar
    private func initialize() {
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.daysCollectionView.register(nib, forCellWithReuseIdentifier: self.cellID)
        self.daysCollectionView.delegate = self
        self.daysCollectionView.dataSource = self
        self.calendarArray = self.arrayOfDates()
        initCalendar()
    }

    func arrayOfDates() -> [Date] {
        let date = Date().startOfMonth
        return date.currentMonthDates
    }
    
    func initCalendar() {
        // Set Today's Date
        self.currentDate = Date()
        
        // Pre-select today's date
        self.preselectTodaysDate()
        
        currentMonth = calendar.component(.month, from: currentDate!)
        currentYear = calendar.component(.year, from: currentDate!)

        didChangeMonth(monthIndex: currentMonth, year: currentYear)
    }
    
    //MARK:- Change month when left and right arrow button tapped
    @IBAction func arrowTapped(_ sender: UIButton) {
        //When Right Arrow button is tapped
        if sender == rightBtn {
            //Increment the index of the current month:
            currentMonth += 1
            //Check if next month is January of the next year:
            if currentMonth > 11 {
                //Reset the current month index:
                currentMonth = 0
                //Increment the current year:
                currentYear += 1
            }
        } else {
            //Decrement the index of the current month:
            currentMonth -= 1
            //Check if previous month is December of the last year:
            if currentMonth < 0 {
                //Reset the current month index:
                currentMonth = 11
                //Decrement the current year:
                currentYear -= 1
            }
        }

        //Call didChangeMonth function:
        didChangeMonth(monthIndex: currentMonth, year: currentYear)
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        let dateComponents = DateComponents(year: year, month: monthIndex)
        
        guard let date = calendar.date(from: dateComponents) else {
            return
        }
        
        // Set label text for Month-Year:
        monthAndYear.text="\(date.monthName) \(date.year)"

        self.calendarArray = date.currentMonthDates
        daysCollectionView.reloadData()
        daysCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        
        // Pre-select today's date
        self.preselectTodaysDate()
    }
    
    fileprivate func preselectTodaysDate() {
        // Preselect today's date in Collectionview
        for (idx, date) in self.calendarArray.enumerated() {
            if calendar.isDateInToday(date) {
                let selectionIP = IndexPath(item: idx, section: 0)
                daysCollectionView.selectItem(at: selectionIP, animated: true, scrollPosition: .centeredHorizontally)
            }
        }
        
    }
}

//MARK:- Calendar collection view delegate and datasource methods
extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.calendarArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! DayCell
        let date = self.calendarArray[indexPath.row]
        cell.date = date
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentDate = self.calendarArray[indexPath.item]
        
        self.delegate?.getSelectedDate(self.currentDate?.toString() ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DayCell
        cell.isSelected = false
    }
}

//MARK:- Add calendar to the view
extension CalendarView {
    
    public class func addCalendar(_ superView: UIView) -> CalendarView? {
        var calendarView: CalendarView?
        if calendarView == nil {
            calendarView = UINib(nibName: "CalendarView", bundle: nil).instantiate(withOwner: self, options: nil).last as? CalendarView
            guard let calenderView = calendarView else { return nil }
            calendarView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(calenderView)
            calenderView.initialize()
            return calenderView
        }
        return nil
    }
}
