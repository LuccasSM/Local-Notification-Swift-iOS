//
//  ViewController.swift
//  Local-Notification-Swift-iOS
//
//  Created by Luccas Santana Marinho on 04/04/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        insertItens()
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    func insertItens() {
        self.view.addSubview(button)
    }
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar".uppercased(), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(push), for: .touchUpInside)
        return button
    }()

    @objc func push() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "App"
        content.body = "Mensagem aqui."
        content.sound = .default
        content.userInfo = ["value": "Dados com notificação local"]

        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(3))

        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)

        let request = UNNotificationRequest(identifier: "lembrete", content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Erro = \(error?.localizedDescription ?? "notificação local de erro")")
            }
        }
    }
}
