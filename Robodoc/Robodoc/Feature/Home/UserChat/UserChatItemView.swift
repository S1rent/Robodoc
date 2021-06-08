//
//  UserChatItemView.swift
//  Robodoc
//
//  Created by IT Division on 08/06/21.
//

import UIKit

class UserChatItemView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bindNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindNib() {
        Bundle.main.loadNibNamed("UserChatItemView", owner: self, options: nil)
        self.addSubview(containerView)
        
        containerView.frame = self.bounds
        containerView.layer.masksToBounds = true
        
        self.setupView()
    }
    
    private func setupView() {
        self.messageView.layer.cornerRadius = 6
        self.messageView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.messageView.layer.shadowOpacity = 0.2
        self.messageView.layer.shadowRadius = 3
        self.messageView.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}
