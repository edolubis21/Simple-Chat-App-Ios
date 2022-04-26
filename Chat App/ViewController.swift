//
//  ViewController.swift
//  Chat App
//
//  Created by Rekeningku on 26/04/22.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    
    static func getDateFromString(_ value:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let date = formatter.date(from: value) else {return Date()}
        return date
    }
}

class ViewController: UIViewController{
    
    let textMessages = [[
                         ChatMessage(text: "Here is my very first messages", isIncoming: true, date: Date.getDateFromString("10/07/2018")),
                         ChatMessage(text:  "I am going to give long messages hell yeah this is very long message" ,isIncoming: false, date: Date() ),
                         ChatMessage(text: "you whatsup", isIncoming: false, date: Date.getDateFromString("12/05/2019")),
                         ChatMessage(text: "Letsgo bro", isIncoming: false, date: Date.getDateFromString("12/05/2019")),
                        ],
                        [
                         ChatMessage(text: "Here is my very first messages", isIncoming: true, date: Date.getDateFromString("10/07/2018")),
                         ChatMessage(text:  "I am going to give long messages hell yeah this is very long message" ,isIncoming: false, date: Date() ),
                        ]]
    
    
    lazy var tableView : UITableView = {
        let uiTableView = UITableView()
        uiTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        uiTableView.separatorStyle = .none
        uiTableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return uiTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func setupNavigationItem(){
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension ViewController : UITableViewDataSource    , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textMessages[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return textMessages.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    class DateUILabel: UILabel{
        
        override var intrinsicContentSize: CGSize {
            let original = super.intrinsicContentSize
            let width = original.width + 24
            let height = original.height + 16
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: width, height: height)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            font = .systemFont(ofSize: 12)
            backgroundColor = .black
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firmstMessagesSection = textMessages[section].first {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let dateString = formatter.string(from: firmstMessagesSection.date)
            
            let uiView = UIView()
            let label = DateUILabel()
            label.text = dateString
            
            uiView.addSubview(label)
            
            label.centerYAnchor.constraint(equalTo: uiView.centerYAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: uiView.centerXAnchor).isActive = true
            
            return uiView
        }
        return nil
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        let message = textMessages[indexPath.section][indexPath.row]
        cell.chatMesage = message
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



