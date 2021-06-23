//
//  ResultClosedCell.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit

class ResultClosedCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle.self = .none
        
        setUpView()
    }
    
    @IBOutlet weak var timeGrayView: UIView!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func setUpView() {
        
        timeGrayView.layer.shadowOpacity = 0.4
        timeGrayView.layer.shadowOffset = CGSize(width: 0, height: 0)
        timeGrayView.layer.shadowRadius = 3
        timeGrayView.layer.shadowColor = UIColor.lightGray.cgColor
        timeGrayView.layer.masksToBounds = false
        
    }
    
    func setupCell(option: FinalOption) {
        
        let startTime = option.makeStartTimeToString()
        
        let endTime = option.makeEndTimeToTimeString()
        
        let month = String(describing: option.optionTime!.month)
        
        let day = String(describing: option.optionTime!.day)
        
        yearLabel.text = String(describing: option.optionTime!.year)
        
        dateLabel.text = "\(month)".localized + "\(day)" + "day-for-calendar".localized
        
        timeLabel.text = "\(startTime) - \(endTime)"
        
    }
    
}
