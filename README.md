# Horizontal_Calendar

Just add Calendar as an external view and you are done.

	//MARK:- Add calender to view
    private func addCalendar() {
        if let calendar = CalendarView.addCalendar(self.calendar) {
            self.calendarObj = calendar
            self.calendarObj?.delegate = self
            
            guard let currDateStr = self.calendarObj?.currentDate?.toString() else {return}
            self.getSelectedDate(currDateStr)
        }
    }
	
Using Calendar's delegate, you can get selected Date in a string. You can also convert that dateString variable to Date object and use whenever required !

