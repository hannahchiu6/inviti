//
//  CTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//

import UIKit

class CTableViewCell: UITableViewCell {

    var viewModel: EventViewModel?

    var event: Event?

    var completionHandler: ((Int) -> Void)?

    private enum TitleText: String {
        case user = "您預定的時間"
        case firebase = "此時間已被預訂囉"
    }

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bookingView: UIView!

    @IBOutlet weak var timeLabel: UILabel!

    @IBAction func bookingAction() {

    }

    @IBOutlet weak var bookingButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        print("--------- CalendarVCell ---------)")
        print("\(viewModel?.event.returnTimeToDateType(time: (viewModel?.event.startTime)!))")
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func prepareForReuse() {

        bookingButton.isHidden = false
    }

//    func setupCell(hour: Int) {
//
//        setupText(hour: hour)
//        bookingView.isHidden = true
//        bookingView.backgroundColor = UIColor.white
//        bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
//    }

    func setup(viewModel: EventViewModel) {
        self.viewModel = viewModel
        layoutCell()
    }

    func layoutCell() {
        event = viewModel?.event
        titleLabel.text = viewModel?.subject
        print("-------- Cell viewModel?.startTime ------")
        print("\(String(describing: viewModel?.startTime))")

//        titleLabel.text = viewModel?.subject

    }

    func userBookingSetup(hour: Int) {

        setupText(hour: hour)
        bookingView.isHidden = false
        bookingButton.setImage(UIImage(systemName: "minus"), for: .normal)
        bookingView.backgroundColor = UIColor.myColorEnd
        titleLabel.text = TitleText.user.rawValue
    }

    func fireBaseBookingSetup(text: String, hour: Int) {

        setupText(hour: hour)
        bookingButton.isHidden = true
        bookingView.isHidden = false
        bookingView.backgroundColor = UIColor.myColorPinkRed
        titleLabel.text = viewModel?.subject
        titleLabel.text = "忙碌的時間"
    }

    private func setupText(hour: Int) {

        self.timeLabel.setupTextInPB(text: String(hour) + ":00")
        self.timeLabel.textAlignment = .center
        bookingButton.tag = hour
    }
}
