//
//  HasVotedVC.swift
//  inviti
//
//  Created by Hannah.C on 19.05.21.
//

import UIKit
import Lottie

protocol HasVotedVCDelegate: AnyObject {
    func didTap()
}
class HasVotedVC: BaseViewController {
    
    @IBOutlet weak var returnBtnView: UIButton!

    @IBOutlet weak var animationView: UIView!

    var meeting: Meeting?

    var isVoted: Bool = false

    @IBOutlet weak var alertMessage: UILabel!

    weak var delegate: HasVotedVCDelegate?

    var userUID = UserDefaults.standard.string(forKey: UserDefaults.Keys.uid.rawValue) ?? ""

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        changedMessage()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAnimation()

    }

    func changedMessage() {
        
        guard let meeting = meeting else { return }
        
        if meeting.isClosed {

            alertMessage.text = "投票活動已結束囉！"

        } else if isVoted {

            alertMessage.text = "您已經投票過囉！"

        } else {
            
            alertMessage.text = "Oops，投票活動已經被刪除了。"
        }
    }

    func setUpAnimation() {

        let animView = AnimationView()
        let anim = Animation.named("49976-sdss", bundle: .main)
        animView.frame = animationView.bounds
        animView.contentMode = .scaleAspectFill
        animView.animation = anim
        animView.loopMode = .loop

        animView.play()

        animView.play(fromProgress: 0.5, toProgress: 1)

        animView.play(fromMarker: "begin", toMarker: "end")

        animationView.addSubview(animView)

        animationView.alpha = 0.8
    }

    @IBAction func returnMain(_ sender: UIButton) {

        delegate?.didTap()
    }

}
