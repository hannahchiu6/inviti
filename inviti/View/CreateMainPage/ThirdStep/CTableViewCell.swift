//
//  CTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//
import Foundation
import UIKit

class CTableViewCell: UITableViewCell {
    
    var viewModel: CalendarViewModel?
    
    var createOptionViewModel = CreateOptionViewModel()
    
    var selectedOptionViewModel = SelectOptionViewModel()
    
    var optionViewModel: OptionViewModel?
    
    var option: Option = Option(id: "", startTime: 0, endTime: 0, optionTime: OptionTime(year: 2021, month: 5, day: 5), duration: 60)
    
    var selectedOptions: [String] = []
    
    var completionHandler: ((Int) -> Void)?
    
    var meeting: Meeting?
    
    var meetingID: String = ""
    
    var selectDay: Date = Date(millis: 1622185470000)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookingMeetingButton.isHidden = true
        eventView.isHidden = true
        self.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func bookingAction(_ sender: UIButton) {
        
        //        let cell = CTableViewCell()
        
        sender.isSelected = !sender.isSelected
        
        if bookingButton.isSelected {
            
            createOptionViewModel.onStartTimeChanged(sender.tag, date: selectDay)
            
            createOptionViewModel.onEndTimeChanged(sender.tag, date: selectDay)
            
            createOptionViewModel.onOptionTimeChanged(selectDay)
            
            createOptionViewModel.onOptionCreated = {
                
                self.selectedOptionViewModel.fetchData(meetingID: self.meetingID)
            }
            
            createOptionViewModel.createWithEmptyData(with: meetingID, option: &createOptionViewModel.option)
            
        } else {
            
            
            let bookingDate = OptionTime(year: selectDay.year, month: selectDay.month, day: selectDay.day)
            
            let newVM = selectedOptionViewModel.createSelectedOption(in: selectedOptionViewModel.optionViewModels.value, selectedDate: bookingDate)
            
            let newHour = selectedOptionViewModel.createTimeData(in: newVM)
            
            if newHour.contains(sender.tag) {
                
                let optionID = selectedOptionViewModel.getOptionID(in: newVM, index: sender.tag)
                
                selectedOptionViewModel.onEmptyTap(optionID, meetingID: meetingID)
                
                selectedOptionViewModel.fetchData(meetingID: meetingID)
                
            }
        }
    }
    
    @IBOutlet weak var bookingMeetingButton: UIView!
    
    @IBOutlet weak var bookingButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(index: Int) {
        bookingButton.tag = index
        
        if index < 10 {
            timeLabel.text = "0" + "\(index)" + ":00"
        } else {
            timeLabel.text = "\(index)" + ":00"
        }
    }
    
    func setupEmptyStatus() {
        
        eventView.isHidden = true
        bookingButton.isHidden = false
        
    }
    
    func hasEventStatus() {
        
        eventView.isHidden = false
        bookingButton.isHidden = true
        
    }
    
    func selectedMeetingTime() {
        bookingMeetingButton.isHidden = false
        self.titleLabel.text = "Book the Time!"
        self.titleLabel.textColor = UIColor.white
        self.bookingButton.setImage(UIImage(systemName: "minus"), for: .selected)
        
    }
    
    func deselectedMeetingTime() {
        bookingMeetingButton.isHidden = true
        self.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        bookingButton.isSelected = false
        bookingMeetingButton.isHidden = true
        eventView.isHidden = true
        
    }
    
    private func setupText(hour: Int) {
        
        self.timeLabel.setupTextInPB(text: String(hour) + ":00")
        self.timeLabel.textAlignment = .center
        bookingButton.tag = hour
    }
}
