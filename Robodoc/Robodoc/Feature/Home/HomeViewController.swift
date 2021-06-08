//
//  HomeViewController.swift
//  Robodoc
//
//  Created by IT Division on 08/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var initView: UIView!
    
    //Keyboard View
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var keyboardField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var isOpeningQuestion = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Consultation"

        self.setupView()
    }
    
    private func setupView() {
        self.stackView.removeAllArrangedSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.isNavigationBarHidden = false
        self.keyboardView.layer.cornerRadius = 20
        self.keyboardView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.keyboardView.layer.shadowOpacity = 0.2
        self.keyboardView.layer.shadowRadius = 3
        self.keyboardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.keyboardField.layer.cornerRadius = 10
        self.keyboardField.layer.borderColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        self.keyboardField.layer.borderWidth = 2
        self.keyboardField.setLeftPaddingPoints(8)
        
        self.addRobotChat(message: "*If you wish to reset the consultation, type reset")
        self.addRobotChat(message: "Hello there, do you already know what you suffer from ?")
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if self.keyboardField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return }
        let userMessage: String = self.keyboardField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? "-"
        self.addUserChat()
        
        if userMessage == "reset" {
            isOpeningQuestion = true
            self.stackView.removeAllArrangedSubviews()
            self.addRobotChat(message: "*If you wish to reset the conversation, type reset")
            self.addRobotChat(message: "Hello there, do you already know what you suffer from ?")
            return
        }
        
        if isOpeningQuestion {
            if userMessage.checkNegativeAnswer() {
                self.isOpeningQuestion = false
                self.addRobotChat(message: "Alright, can you describe what you feel ?\nPlease describe it one by one.")
            } else if userMessage.checkPositiveAnswer() {
                self.isOpeningQuestion = false
                self.addRobotChat(message: "Okay, what do you suffer from ?")
            } else {
                self.addRobotChat(message: "Sorry, i couldn't catch that, please answer correctly.")
            }
        } else {
            
        }
    }
    
    func addRobotChat(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self = self else { return }
            
            let robotView = RobotChatItemView()
            robotView.messageLabel.text = message
            self.stackView.addArrangedSubview(robotView)
        })
    }
    
    func addUserChat() {
        let userView = UserChatItemView()
        userView.messageLabel.text = self.keyboardField.text
        self.stackView.addArrangedSubview(userView)

        self.keyboardField.text = ""
    }
}
