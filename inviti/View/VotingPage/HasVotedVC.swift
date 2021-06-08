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

    var meetingSubject: String?

    weak var delegate: HasVotedVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAnimation()
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
