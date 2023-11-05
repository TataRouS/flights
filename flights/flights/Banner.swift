//
//  Banner.swift
//  flights
//
//  Created by Nata Kuznetsova on 04.11.2023.
//

import Foundation
import UIKit

final class Banner: UIView {
    
    private let networkService = NetworkService()
    private var model: Copyright?
    
    private var label: UILabel = {
        let label = UILabel()
 //       label.text = "Description"
        label.textColor = .black
        label.backgroundColor = .yellow
        label.textAlignment = .center
        return label
    }()
    
    private var label2: UILabel = {
           let label = UILabel()
   //        label.text = "Option"
           label.textColor = .black
           label.backgroundColor = .yellow
        label.textAlignment = .center
           return label
       }()

    func setupTextBanner(banner: Copyright) {
        let text = banner.text
        let url = banner.url
        label.text = "\(text ?? "")"
        label2.text = "\(url ?? "")"
    }
    
    
    private func setupViews() {
       addSubview(label)
        addSubview(label2)
        setupConstraints()
        setupTextBanner(banner: model ?? Copyright(text: "Нет данных", url: "Нет данных"))
    }

    private func setupConstraints() {
       label.translatesAutoresizingMaskIntoConstraints = false
       label2.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 40),

            label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            label2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            label2.centerXAnchor.constraint(equalTo: centerXAnchor),
            label2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
        ])
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    


   
