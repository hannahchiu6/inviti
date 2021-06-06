//
//  EventTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit
import Foundation

class EventTableViewCell: UITableViewCell {

    var viewModel: CalendarViewModel?

    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventSubject: UILabel!
    @IBOutlet weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

//        setupMainView()

    }
//
//
//    func setupMainView() {
//        let borderLine = UIView(frame: CGRect(x: 0, y: mainView.frame.height, width: mainView.frame.width, height: 1))
//
//        borderLine.backgroundColor = UIColor(red: 0.9876, green: 0.9373, blue: 0.9294, alpha: 1.0)
//
//        mainView.addSubview(borderLine)
//
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(vm: EventViewModel) {

        startTime.text = vm.event.startTimeToTime()

        eventSubject.text = vm.event.subject

        endTime.text =  vm.event.endTimeToTime()

        eventLocation.text = vm.event.location
    }
}
