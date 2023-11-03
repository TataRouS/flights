//
//  ArrivalCell.swift
//  flights
//
//  Created by Nata Kuznetsova on 03.11.2023.
//

import UIKit

final class ArrivalCell: UITableViewCell {
    
    private var time: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = .black
        return label
    }()
    
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
    
  
    
    func setupTextFlightDetails(departure: Flight) {
        let number = departure.thread.number
        let title = departure.thread.title
        let vehicle = departure.thread.vehicle
        let time = departure.departure
        text1.text = "\(number)"
        text2.text = "\(title)"
        text3.text = "\(vehicle)"
      //  time.text = "\(time)"
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
        contentView.addSubview(time)
        contentView.addSubview(text1)
        contentView.addSubview(text2)
        contentView.addSubview(text3)
        setupConstraints()
    }
    
    private func setupConstraints() {
        time.translatesAutoresizingMaskIntoConstraints = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        text3.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            time.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            time.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
           time.heightAnchor.constraint(equalToConstant: 50),
            time.widthAnchor.constraint(equalTo: time.heightAnchor),
          time.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            text1.trailingAnchor.constraint(equalTo: time.leadingAnchor, constant: 30),
            text1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 10),
            text2.trailingAnchor.constraint(equalTo: time.leadingAnchor, constant: 30),
            text2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 10),
            text3.trailingAnchor.constraint(equalTo: time.leadingAnchor, constant: 30),
            text3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        text1.text = nil
    }
}

