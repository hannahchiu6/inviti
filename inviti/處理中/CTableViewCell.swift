//
//  CTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//
import Foundation
import UIKit

protocol CTableViewCellDelegate: AnyObject {
    func tapped(_ sender: CTableViewCell, index: Int, vms: SelectVMController)
}

//struct selectedOption {
//    var optionID: String = ""
//    var optionTag: Int = 0
//}

class CTableViewCell: UITableViewCell {

    weak var delegate: CTableViewCellDelegate?

    var viewModel: CalendarVMController?

    var createOptionViewModel = CreateOptionViewModel()

    var selectedOptionViewModel = SelectVMController()

    var optionViewModel: OptionViewModel?

    var option: Option = Option(startTime: 0, endTime: 0, optionTime: OptionTime(year: 2021, month: 5, day: 5), duration: 60)

    var selectedOptions: [String] = []

    var completionHandler: ((Int) -> Void)?

    var meeting: Meeting?

    var meetingID: String = ""

//    var onRefresh: (() -> Void)

    var selectDay: Date = Date(millis: 1622185470000) {
        didSet {
            
        }
    }

    override func awakeFromNib() {
    super.awakeFromNib()
        bookingMeetingButton.isHidden = true
        bookingButton.isHidden = true
        eventView.isHidden = true

        resetCell()

//            UserDefaults.standard.set(myArray, forKey: "yourArray")
//
//       let data = UserDefaults.standard.object(forKey: "yourArray")!
//       print(data)
    }

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var eventView: UIView!

    @IBOutlet weak var timeLabel: UILabel!

    @IBAction func bookingAction(_ sender: UIButton) {

        let cell = CTableViewCell()

        sender.isSelected = !sender.isSelected

    if bookingButton.isSelected {

        print(meetingID)

        createOptionViewModel .onStartTimeChanged(sender.tag, date: selectDay)

        createOptionViewModel.onEndTimeChanged(sender.tag, date: selectDay)

        createOptionViewModel.onOptionTimeChanged(selectDay)

//        meetingTimeSelected()

        createOptionViewModel.onOptionCreated = {
            self.selectedOptionViewModel.fetchData(meetingID: self.meetingID)
        }

        createOptionViewModel.createWithEmptyData(with: meetingID, option: &createOptionViewModel .option)

//        createOptionViewModel.option = option


//        delegate?.tapped(cell, index: sender.tag, vms: selectedOptionViewModel)
        

    } else {

//        self.meetingTimeDeselected()

        selectedOptionViewModel.fetchData(meetingID: meetingID)

        let bookingDate = OptionTime(year: selectDay.year, month: selectDay.month, day: selectDay.day)

        let newVM = selectedOptionViewModel.createSelectedOption(in: selectedOptionViewModel.optionViewModels.value, selectedDate: bookingDate)

        let newHour = selectedOptionViewModel.createHourData(in: newVM)

        if selectedOptionViewModel.createTimeData(in: newVM).contains(sender.tag) {

            
            if newHour.contains(sender.tag) {

            let optionID = selectedOptionViewModel.getOptionID(in: newVM, index: sender.tag)

                selectedOptionViewModel.onEmptyTap(optionID, meetingID: meetingID)

                selectedOptionViewModel.fetchData(meetingID: meetingID)

                delegate?.tapped(cell, index: sender.tag, vms: selectedOptionViewModel)

                }

            }
        }
    }

    @IBOutlet weak var bookingMeetingButton: UIView!

    @IBOutlet weak var bookingButton: UIButton!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(index: Int) {
//        bookingMeetingButton.isHidden = true
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

    func meetingTimeSelected() {
        bookingMeetingButton.isHidden = false
//        self.eventView.backgroundColor = UIColor.orange
        self.titleLabel.text = "Book the Time!"
        self.titleLabel.textColor = UIColor.white
//        self.eventView.isHidden = false
//        self.titleLabel.isHidden = false
        self.bookingButton.setImage(UIImage(systemName: "minus"), for: .selected)

    }

    func meetingTimeDeselected() {
        bookingMeetingButton.isHidden = true
        self.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
//        self.titleLabel.isHidden = true
    }

    func resetCell() {
//        if selectDay > Date() {
//            bookingButton.isHidden = false
//            bookingMeetingButton.isHidden = true
//            eventView.isHidden = true
//            self.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
//
//        } else {
//            bookingButton.isHidden = true
//            eventView.isHidden = true
//            bookingMeetingButton.isHidden = true
//            bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
//        }
        bookingMeetingButton.isHidden = true
        eventView.isHidden = true
        self.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)


    }

    override func prepareForReuse() {

        super.prepareForReuse()
        bookingButton.isHidden = false
        self.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)

    }

    private func setupText(hour: Int) {

        self.timeLabel.setupTextInPB(text: String(hour) + ":00")
        self.timeLabel.textAlignment = .center
        bookingButton.tag = hour
    }
}
