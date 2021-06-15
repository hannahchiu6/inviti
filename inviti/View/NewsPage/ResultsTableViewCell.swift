//
//  ResultsTableViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    var viewModel = VotingViewModel()

    var meetingID: String = ""

    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func closeStatusBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var closeStatusBtnView: UIButton!
    @IBOutlet weak var noOfParticipantsLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var meetingSubject: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
//        collectionView.delegate = self
//        collectionView.dataSource = self

//        collectionView.reloadData()

        
//        viewModel.optionViewModels.bind { [weak self] options in
//            self?.viewModel.onRefresh()
//            self?.collectionView.reloadData()
//        }
////
//        viewModel.voteViewModels.bind { [weak self] votes in
//                self?.viewModel.onRefresh()
//    
//            }

    }

    func setupView() {
        bgView.layer.cornerRadius = 5

        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        bgView.layer.shadowRadius = 6
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.masksToBounds = false

        mainView.frame = CGRect(x: 0 , y: 0, width: self.frame.width * 0.3, height: self.frame.height * 0.4)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupCell(model: MeetingViewModel) {
        noOfParticipantsLabel.text = "參與投票人數為 \(model.numOfParticipants) 人"
        meetingSubject.text = model.subject

        createdTimeLabel.text = "投票建立時間：\(Date.intDateFormatter.string(from: Date.init(millis: model.createdTime)))"

        
//        collectionView.reloadData()
        
    }

}

//extension ResultsTableViewCell:  UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return 3
//        print(viewModel.optionViewModels.value.count)
//        return viewModel.optionViewModels.value.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: "ResutlsCollectionViewCell"), for: indexPath) as! ResutlsCollectionViewCell
//
////
////        cell.setupCell(model: viewModel.optionViewModels.value[indexPath.row])
////
////        cell.optionID = viewModel.optionViewModels.value[indexPath.row].id
////
////        cell.meetingID = meetingID
//
//        return cell
//    }
//
//}
