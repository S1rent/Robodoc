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
    
    var userDiseasePrediction: Set<String> = []
    
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
            self.addRobotChat(message: "*If you wish to reset the consultation, type reset")
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
                self.addRobotChat(message: "Sorry, I have tried my best and didn't come up with a solution to that disease(\(stemmedUserMessage)).")
                self.prepareForNewConsultation(message: self.failDisclaimerMessage)
            } else {
                let stemmedUserMessage = userMessage.stemmed(withoutSeparator: false)
                let stemmedUserWithSeparator = userMessage.stemmed()
                
                let repository = DiseasePredictionRepository.shared.db
                let rep = DiseaseTreatmentRepository.shared.db
                
                var tmp: Set<String> = []
                for it in self.userDiseasePrediction {
                    tmp.insert(it.lowercased())
                }
                
                if tmp.contains(stemmedUserMessage.trimmingCharacters(in: .whitespacesAndNewlines)) {
                    for diseaseInfo in rep {
                        if stemmedUserWithSeparator.contains(diseaseInfo.0.lowercased()) {
                            self.addRobotChat(message: "The suggested treatment for \(stemmedUserWithSeparator) is\n\(diseaseInfo.1)")
                            self.prepareForNewConsultation(message: self.disclaimerMessage)
                            return
                        }
                    }
                }
                
                if self.userDiseasePrediction.count == 0 {
                    for item in repository {
                        let symtoms = item.1.stemmed(withoutSeparator: false)
                        let disease = item.0
                        
                        let splitSymtoms = symtoms.split(separator: " ")
                        let splitMessage = stemmedUserMessage.split(separator: " ")
                        for wSymptoms in splitSymtoms {
                            for wMessage in splitMessage {
                                if(wSymptoms.lowercased() == wMessage.lowercased())
                                {
                                    self.userDiseasePrediction.insert(disease)
                                }
                            }
                        }
                    }
                    
                    if self.userDiseasePrediction.count == 1 {
                        self.addRobotChat(message: "According to my analysis, you have been potentially suffered from \(userDiseasePrediction.first ?? "").")
                        
                        let treatmenRepo = DiseaseTreatmentRepository.shared.db
                        for diseaseInfo in treatmenRepo {
                            guard let firstItem = userDiseasePrediction.first else { return }
                            if firstItem.lowercased().contains(diseaseInfo.0.lowercased()) {
                                self.addRobotChat(message: "The suggested treatment for \(firstItem) is\n\(diseaseInfo.1)")
                                self.prepareForNewConsultation(message: self.disclaimerMessage)
                                return
                            }
                        }
                    }
                    
                } else {
                    var newPrediction: Set<String> = []
                    for item in repository {
                        let symtoms = item.1.stemmed(withoutSeparator: false)
                        let disease = item.0
                        
                        let splitSymtoms = symtoms.split(separator: " ")
                        let splitMessage = stemmedUserMessage.split(separator: " ")
                        for wSymptoms in splitSymtoms {
                            for wMessage in splitMessage {
                                if(wSymptoms.lowercased() == wMessage.lowercased())
                                {
                                    newPrediction.insert(disease)
                                }
                            }
                        }
                    }
                    
                    var updatedDisease: Set<String> = []
                    
                    for oldDisease in self.userDiseasePrediction {
                        if newPrediction.contains(oldDisease) {
                            if oldDisease.lowercased() == "corona" && updatedDisease.contains("Covid") {
                            } else {
                                updatedDisease.insert(oldDisease)
                            }
                        }
                    }
                    self.userDiseasePrediction = updatedDisease
                    if self.userDiseasePrediction.count == 1 {
                        self.addRobotChat(message: "According to my analysis, you have been potentially suffered from \(userDiseasePrediction.first ?? "").")
                        
                        let treatmenRepo = DiseaseTreatmentRepository.shared.db
                        for diseaseInfo in treatmenRepo {
                            guard let firstItem = userDiseasePrediction.first else { return }
                            if firstItem.lowercased().contains(diseaseInfo.0.lowercased()) {
                                self.addRobotChat(message: "The suggested treatment for \(firstItem) is\n\(diseaseInfo.1)")
                                self.prepareForNewConsultation(message: self.disclaimerMessage)
                                return
                            }
                        }
                        
                        
                        self.prepareForNewConsultation(message: self.disclaimerMessage)
                        return
                    }
                }
                
                var possibleSymtomps = ""
                for (index, disease) in self.userDiseasePrediction.enumerated() {
                    possibleSymtomps += disease
                    if index != self.userDiseasePrediction.count - 1 {
                        possibleSymtomps += ", "
                    }
                }
                
                if self.userDiseasePrediction.count != 0 {
                    self.addRobotChat(message: "According to my analysis, you have been potentially suffered from either one of these disease\n\n\(possibleSymtomps).\n\nYou can tell me more about the symtomps you felt to make the analysis better.")
                    self.addRobotChat(message: "If you feel that you have suffered from one of those disease, you can type the disease and i will give recommend you a treatment.")
                } else {
                    self.prepareForNewConsultation(message: "Sorry, I have tried my best and didn't know the disease you have.\nI recommend you to go to the hospital.")
                }
            }
        }
    }
    
    func prepareForNewConsultation(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self = self else { return }
            
            self.addRobotChat(message: message, true)
            self.reset()
        })
    }
    
    func reset() {
        self.userDiseasePrediction = []
        isOpeningQuestion = true
        self.addRobotChat(message: "Hello there, do you already know what you suffer from ?")
    }
    
    func addRobotChat(message: String, _ isEnd: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [weak self] in
            guard let self = self else { return }
            
            self.scrollToBottom()
        })
    }
    
    func addUserChat() {
        let userView = UserChatItemView()
        userView.messageLabel.text = self.keyboardField.text
        self.stackView.addArrangedSubview(userView)

        self.keyboardField.text = ""
        self.scrollToBottom()
    }
    
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        if scrollView.contentSize.height - scrollView.bounds.size.height > 0 {
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
}
