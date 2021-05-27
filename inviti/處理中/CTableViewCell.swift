//
//  CTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 24.05.21.
//
import Foundation
import UIKit

protocol CTableViewCellDelegate: AnyObject {
    func tapped(_ sender: CTableViewCell, index: Int)
}

class CTableViewCell: UITableViewCell {

    weak var delegate: CTableViewCellDelegate?

    var viewModel: CalendarVMController?

    var options: [Option] = []

    var completionHandler: ((Int) -> Void)?

    private enum TitleText: String {
        case user = "您預定的時間"
        case firebase = "此時間已被預訂囉"
    }

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bookingView: UIView!

    @IBOutlet weak var timeLabel: UILabel!

    @IBAction func bookingAction(_ sender: UIButton) {

        let cell = CTableViewCell()

        delegate?.tapped(cell, index: sender.tag)

        bookingButton.showAnimation {

            if self.bookingButton.isSelected {

                self.bookingButton.setImage(UIImage(systemName: "plus"), for: .normal)
                self.bookingView.isHidden = false
                self.bookingView.backgroundColor = UIColor.orange
                self.titleLabel.text = "Book the Time!"

            } else {

                self.bookingButton.showAnimation {
                self.bookingButton.setImage(UIImage(systemName: "minus"), for: .normal)
                self.bookingView.isHidden = true
                self.titleLabel.isHidden = true

                }
            }

        }

    }

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

        bookingView.isHidden = true
        bookingButton.isHidden = false

    }

    func hasEventStatus() {

        bookingView.isHidden = false
        bookingButton.isHidden = true

    }

    override func prepareForReuse() {

        super.prepareForReuse()
        bookingButton.isHidden = false
    }


    private func setupText(hour: Int) {

        self.timeLabel.setupTextInPB(text: String(hour) + ":00")
        self.timeLabel.textAlignment = .center
        bookingButton.tag = hour
    }
}
