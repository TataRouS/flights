//
//  DepartureCell.swift
//  flights
//
//  Created by Nata Kuznetsova on 03.11.2023.
//

import UIKit

final class DepartureCell: UITableViewCell {
    
    
    private var text1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
  
    private var text2: UILabel = {
        let label = UILabel()
    //    label.text = "Description"
        label.textColor = .black
        return label
    }()
    
    private var text3: UILabel = {
        let label = UILabel()
  //      label.text = "Description"
        label.textColor = .black
        return label
    }()
    
    private var text4: UILabel = {
        let label = UILabel()
  //      label.text = "Description"
        label.textColor = .black
        return label
    }()
  
    
    func setupTextFlightDetails(departure: Flight) {
        let number = departure.thread.number
        let title = departure.thread.title
        let vehicle = departure.thread.vehicle
        let time = departure.departure ?? "время не известно"
        text1.text = "\(number)"
        text2.text = "\(title)"
        text3.text = "\(vehicle)"
        text4.text = "\(time)"
    }
    
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(text4)
        contentView.addSubview(text1)
        contentView.addSubview(text2)
        contentView.addSubview(text3)
        setupConstraints()
    }
    
    private func setupConstraints() {
        text4.translatesAutoresizingMaskIntoConstraints = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        text3.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            text4.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            text4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            text4.heightAnchor.constraint(equalToConstant: 80),
            text4.widthAnchor.constraint(equalTo: text4.heightAnchor),
            text4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            text1.trailingAnchor.constraint(equalTo: text4.leadingAnchor, constant: 30),
            text1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 10),
            text2.trailingAnchor.constraint(equalTo: text4.leadingAnchor, constant: 30),
            text2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 10),
            text3.trailingAnchor.constraint(equalTo: text4.leadingAnchor, constant: 30),
            text3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
            
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        text1.text = nil
    }
}


