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

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

//    func setup(viewModel: EventViewModel) {
//
//        startTime.text = Date.dayFormatter.string(from: Date.init(millis: viewModel.event.startTime))
//
//        eventSubject.text = viewModel.event.subject
//
//        endTime.text = Date.dayFormatter.string(from: Date.init(millis: viewModel.event.endTime))
//    }

    func setup(vm: EventViewModel) {

        startTime.text =  Date.timeFormatter.string(from: Date.init(millis: vm.event.startTime))

        eventSubject.text = vm.event.subject

        endTime.text =  Date.timeFormatter.string(from: Date.init(millis: vm.event.endTime))

        eventLocation.text = vm.event.location
    }
}
