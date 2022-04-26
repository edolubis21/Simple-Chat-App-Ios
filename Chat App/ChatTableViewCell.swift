//
//  ChatTableViewCell.swift
//  Chat App
//
//  Created by Rekeningku on 26/04/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    static let identifier = "ChatTableViewCell"
    
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMesage : ChatMessage! {
        didSet {
            NSLayoutConstraint.deactivate([trailingConstraint])
            NSLayoutConstraint.deactivate([leadingConstraint])
            if chatMesage.isIncoming {
                NSLayoutConstraint.activate([leadingConstraint])
                NSLayoutConstraint.deactivate([trailingConstraint])
            } else {
                NSLayoutConstraint.activate([trailingConstraint])
                NSLayoutConstraint.deactivate([leadingConstraint])
            }
            label.text = chatMesage.text
            backgroundMessage.backgroundColor = chatMesage.isIncoming ? .white : .darkGray
            label.textColor = chatMesage.isIncoming ? .black : .white
        }
    }
    
    lazy var backgroundMessage : UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    lazy var label: UILabel = {
        let uiLabel = UILabel()
        uiLabel.numberOfLines = 0
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(){
        
        contentView.addSubview(backgroundMessage)
        contentView.addSubview(label)
        
        let constrainst = [
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            backgroundMessage.topAnchor.constraint(equalTo: label.topAnchor,constant: -16),
            backgroundMessage.bottomAnchor.constraint(equalTo: label.bottomAnchor,constant: 16),
            backgroundMessage.leadingAnchor.constraint(equalTo: label.leadingAnchor,constant: -16),
            backgroundMessage.trailingAnchor.constraint(equalTo: label.trailingAnchor,constant: 16),
        ]
        
        NSLayoutConstraint.activate(constrainst)
        
        leadingConstraint = label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
        trailingConstraint = label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        
    }
    
}
