//
//  HomeViewController.swift
//  Robodoc
//
//  Created by IT Division on 08/06/21.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var initView: UIView!
    
    //Keyboard View
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var keyboardField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var isOpeningQuestion = true
    var isUserKnowTheDisease = false
    
    let disclaimerMessage = """
    *Please note that I could be wrong, to be 100% sure you must do a proper consultation with the professional.\n\n
    If the disease only gets worse, or you haven't been cured, you MUST get proper treatment from the hospital.
    """
    
    let failDisclaimerMessage = """
    *Please note that I don't know everything, you MUST get proper consultation and treatment from the hospital.
    """

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
        self.handleConversation()
    }
    
    func handleConversation() {
        if self.keyboardField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return }
        let userMessage: String = self.keyboardField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? "-"
        self.addUserChat()
        
        if userMessage == "reset" {
            self.stackView.removeAllArrangedSubviews()
            reset()
            return
        }
        
        if isOpeningQuestion {
            if userMessage.checkNegativeAnswer() {
                self.isOpeningQuestion = false
                self.addRobotChat(message: "Alright, can you describe what you feel ?\nPlease describe it one by one.")
                self.isUserKnowTheDisease = false
            } else if userMessage.checkPositiveAnswer() {
                self.isOpeningQuestion = false
                self.addRobotChat(message: "Okay, what do you suffer from ?")
                self.isUserKnowTheDisease = true
            } else {
                self.addRobotChat(message: "Sorry, i couldn't catch that, please answer correctly.")
            }
        } else {
            if self.isUserKnowTheDisease {
                let stemmedUserMessage = userMessage.stemmed()
                
                let repository = DiseaseTreatmentRepository.shared.db
                for diseaseInfo in repository {
                    if stemmedUserMessage.contains(diseaseInfo.0.lowercased()) {
                        self.addRobotChat(message: "The suggested treatment for \(stemmedUserMessage) is\n\(diseaseInfo.1)")
                        self.prepareForNewConsultation(message: self.disclaimerMessage)
                        return
                    }
                }
                self.addRobotChat(message: "Sorry, I have tried my best and didn't come up with a solution to that disease.")
                self.prepareForNewConsultation(message: self.failDisclaimerMessage)
            } else {
                
            }
        }
    }
    
    func prepareForNewConsultation(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            guard let self = self else { return }
            
            self.addRobotChat(message: message, true)
            self.reset()
        })
    }
    
    func reset() {
        isOpeningQuestion = true
        self.addRobotChat(message: "Hello there, do you already know what you suffer from ?")
    }
    
    func addRobotChat(message: String, _ isEnd: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self = self else { return }
            
            let robotView = RobotChatItemView()
            robotView.messageLabel.text = message
            self.stackView.addArrangedSubview(robotView)
            
            if isEnd {
                let separatorView = UIView()
                separatorView.layer.backgroundColor = UIColor.lightGray.cgColor
                self.stackView.addArrangedSubview(separatorView)
                separatorView.snp.makeConstraints { make in
                    make.height.equalTo(1)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                }
            }
        })
    }
    
    func addUserChat() {
        let userView = UserChatItemView()
        userView.messageLabel.text = self.keyboardField.text
        self.stackView.addArrangedSubview(userView)

        self.keyboardField.text = ""
    }
}
