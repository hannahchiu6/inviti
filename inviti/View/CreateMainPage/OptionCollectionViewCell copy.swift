//
//  OptionCollectionViewCell.swift
//  inviti
//
//  Created by Hannah.C on 13.05.21.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var events = ["讀書會", "牙醫洗牙", "行銷會議面談", "打疫苗去", "我是歌手", "選秀比賽"]
    private var startTime = ["09:30", "13:00", "15:00", "17:00", "19:00", "22:00"]
    private var endTime = ["11:00", "13:40", "16:30", "17:30", "20:40","22:30"]
    
    func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: bottomView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bottomView.bounds
        maskLayer.path = path.cgPath
        bottomView.layer.mask = maskLayer
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        
        setupTableView()
        
        tableView.delegate = self
        
        tableView.dataSource = self
    }
    func setupTableView() {
        tableView.do_registerCellWithNib(
            identifier: String(describing: OptionEventTableViewCell.self),
            bundle: nil
        )
    }
    
    
    func setupCollectionView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        
        layer.backgroundColor = UIColor.clear.cgColor
        
        contentView.layer.masksToBounds = true
        bottomView.layer.cornerRadius = 8
        roundCorners(cornerRadius: 8.0)
    }
}

extension OptionCollectionViewCell: UITableViewDelegate {
}

extension OptionCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OptionEventTableViewCell.self), for: indexPath) as! OptionEventTableViewCell
        
        cell.subjectLabel.text = events[indexPath.row]
        cell.startTimeLabel.text = startTime[indexPath.row]
        cell.endTimeLabel.text = endTime[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(0.2 * layer.frame.height))
    }
    
}
