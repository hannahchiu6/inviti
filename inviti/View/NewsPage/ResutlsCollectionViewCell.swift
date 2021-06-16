//
//  ResutlsCollectionViewCell.swift.swift
//  inviti
//
//  Created by Hannah.C on 01.06.21.
//

import UIKit

class ResutlsCollectionViewCell: UICollectionViewCell {
    
    var viewModel = VotingViewModel()
    
    var voteViewModel = VoteViewModel(model: SelectedOption(isSelected: false, selectedUser: ""))
    
    var optionViewModel = OptionViewModel(model: Option(id: "", startTime: 0, endTime: 0, optionTime: OptionTime(year: 2021, month: 5, day: 5), duration: 60))
    
    var meetingID: String = ""
    
    var optionID: String = ""
    
    // top 1 part
    @IBOutlet weak var topWhoVoteYesLabel: UILabel!
    @IBOutlet weak var topTimeLabel: UILabel!
    @IBOutlet weak var topDateLabel: UILabel!
    @IBOutlet weak var topYearLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //        viewModel.voteViewModels.bind { [weak self] votes in
        //            self?.viewModel.onRefresh()
        //
        //        }
        
        //        viewModel.fetchData(optionID: optionID, meetingID: meetingID)
        
    }
    
    func setupCell(model: Option?) {
        
        topTimeLabel.text = "\(viewModel.onTimeChanged(model!.startTime)) - \(viewModel.onTimeChanged(model!.endTime))"
        
        if let optionTime = model?.optionTime {
            topDateLabel.text = "\(optionTime.month)/\(optionTime.day)"
            topYearLabel.text = "\(optionTime.year)"
        }
        
        
        topWhoVoteYesLabel.text = "\(String(describing: model?.selectedOptions?.count)) 人可以出席"

    }
    
}
