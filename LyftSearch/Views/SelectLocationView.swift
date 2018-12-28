//
//  SelectLocationView.swift
//  LyftSearch
//
//  Created by Muhammad Salman Zafar on 26/12/2018.
//  Copyright © 2018 Muhammad Salman Zafar. All rights reserved.
//

import UIKit

class SelectLocationView {
    
    private let contentView: UIView
    private let locationView = UIView()
    
    let mainView = UIView()
    let locationLabel = UILabel()
    let selectLocationBtn = UIButton()
    let backView = UIView(frame: CGRect(x: 15, y: 0, width: 40, height: 40))
    
    
    init(contentView: UIView) {
        self.contentView = contentView
        
        setViews()
    }
    
    private func setViews() {
        
        contentView.addSubview(mainView)
        //mainView.backgroundColor = .white
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 250)
            ])
        
        backView.layer.shadowRadius = 4
        backView.layer.shadowOpacity = 0.1
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 20
        mainView.addSubview(backView)
        
        let backImageView = UIImageView(image: #imageLiteral(resourceName: "back_arrow"))
        backView.addSubview(backImageView)
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backImageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            backImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            backImageView.widthAnchor.constraint(equalToConstant: 24),
            backImageView.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        locationView.backgroundColor = .white
        mainView.addSubview(locationView)
        
        locationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            locationView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            locationView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        
        setUpLocationViews()
        
    }
    
    private func setUpLocationViews() {
        
        let label = UILabel()
        label.text = "Pick Location"
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        
        locationView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -25),
            locationView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            locationView.topAnchor.constraint(equalTo: label.topAnchor, constant: -20)
            ])
        
        let locRoundView = UIView()
        locRoundView.layer.borderColor = #colorLiteral(red: 0.5294117647, green: 0.5294117647, blue: 0.6039215686, alpha: 1)
        locRoundView.layer.borderWidth = 0.25
        locRoundView.layer.cornerRadius = 8
        locationView.addSubview(locRoundView)
        
        locRoundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: locRoundView.topAnchor, constant: -10),
            locationView.leadingAnchor.constraint(equalTo: locRoundView.leadingAnchor, constant: -15),
            locationView.trailingAnchor.constraint(equalTo: locRoundView.trailingAnchor, constant: 15),
            locRoundView.heightAnchor.constraint(equalToConstant: 47)
            ])
        
        let roundPickView = UIView()
        roundPickView.layer.cornerRadius = 10
        roundPickView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.0431372549, blue: 0.5490196078, alpha: 1)
        
        let roundWhiteView = UIView()
        roundWhiteView.layer.cornerRadius = 2.5
        roundWhiteView.backgroundColor = .white
        roundWhiteView.center = roundPickView.center
        roundPickView.addSubview(roundWhiteView)
        
        locRoundView.addSubview(roundPickView)
        
        roundPickView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locRoundView.leadingAnchor.constraint(equalTo: roundPickView.leadingAnchor, constant: -10),
            locRoundView.centerYAnchor.constraint(equalTo: roundPickView.centerYAnchor),
            roundPickView.widthAnchor.constraint(equalToConstant: 20),
            roundPickView.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        roundWhiteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roundPickView.centerYAnchor.constraint(equalTo: roundWhiteView.centerYAnchor),
            roundPickView.centerXAnchor.constraint(equalTo: roundWhiteView.centerXAnchor),
            roundWhiteView.heightAnchor.constraint(equalToConstant: 5),
            roundWhiteView.widthAnchor.constraint(equalToConstant: 5)
            ])
        
        locationLabel.text = "G 10 Islamabad Pakistan"
        locationLabel.font = UIFont(name: "Avenir-Book", size: 17)
        
        locRoundView.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locRoundView.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 10),
            roundPickView.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: -10),
            locRoundView.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor)
            ])
        
        setUpLocationBtn()
    }
    
    private func setUpLocationBtn() {
        
        selectLocationBtn.backgroundColor = #colorLiteral(red: 0.5137254902, green: 0, blue: 1, alpha: 1)
        selectLocationBtn.setTitle("Select Location", for: .normal)
        selectLocationBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        selectLocationBtn.setTitleColor(.white, for: .normal)
        selectLocationBtn.layer.cornerRadius = 30
        locationView.addSubview(selectLocationBtn)
        
        selectLocationBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationView.leadingAnchor.constraint(equalTo: selectLocationBtn.leadingAnchor, constant: -30),
            locationView.trailingAnchor.constraint(equalTo: selectLocationBtn.trailingAnchor, constant: 30),
            locationView.bottomAnchor.constraint(equalTo: selectLocationBtn.bottomAnchor, constant: 10),
            selectLocationBtn.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
}
