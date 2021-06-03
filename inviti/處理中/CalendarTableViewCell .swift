//
//  CalendarTableViewCell .swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//


import UIKit

class CalendarTableViewCell: UITableViewCell {

    var viewModel: EventViewModel?

    var event: Event?

    private enum TitleText: String {
        case user = "您預定的時間"
        case firebase = "此時間已被預訂囉"
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookingView: UIView! {
        didSet {
            bookingView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var timeLabel: UILabel!

    @IBAction func bookingAction() {

    }

    @IBOutlet weak var bookingButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {

        bookingButton.isHidden = false
    }

    func setupCell(hour: Int) {

        setupText(hour: hour)
        bookingView.isHidden = true
        bookingView.backgroundColor = UIColor.white
        bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }

    func setup(viewModel: EventViewModel) {
        self.viewModel = viewModel
        layoutCell()
    }

    func layoutCell() {

        event = viewModel?.event
        titleLabel.text = viewModel?.subject

    }

    func userBookingSetup(hour: Int) {

        setupText(hour: hour)
        bookingView.isHidden = false
        bookingButton.setImage(UIImage(systemName: "minus"), for: .normal)
        bookingView.backgroundColor = UIColor.myColorEnd
        titleLabel.text = TitleText.user.rawValue
    }

    func fireBaseBookingSetup(text: String = TitleText.firebase.rawValue, hour: Int) {

        setupText(hour: hour)
        bookingButton.isHidden = true
        bookingView.isHidden = false
        bookingView.backgroundColor = UIColor.myColorPinkRed
        titleLabel.text = text
    }
    
    private func setupText(hour: Int) {

        self.timeLabel.setupTextInPB(text: String(hour) + ":00")
        self.timeLabel.textAlignment = .center
        bookingButton.tag = hour
    }
}
