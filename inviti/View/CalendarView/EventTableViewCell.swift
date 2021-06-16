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

    func setup(vm: EventViewModel) {

        startTime.text = vm.event.makeStartTimeToTimeString()

        eventSubject.text = vm.event.subject

        endTime.text =  vm.event.makeEndTimeToTimeString()

        eventLocation.text = vm.event.location
    }
}
