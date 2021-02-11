//
//  DayPicker.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 05.01.2021.
//

import UIKit

class DayPicker: UIControl {

    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    var selectedDay: Days? = nil {
        didSet {
            updateSelectedDay()
            sendActions(for: .valueChanged)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUi()
    }
    
    private func setupUi() {
        for day in Days.allCases {
            let button = UIButton(type: UIButton.ButtonType.system)
            button.setTitle(day.title, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectDay), for: .touchUpInside)
            buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.frame = bounds
        addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    @objc func selectDay(_ sender: UIButton) {
        
        guard let index = buttons.firstIndex(of: sender),
              let day = Days(rawValue: index)
        else { return }
          
        selectedDay = day
    }
    
    private func updateSelectedDay() {
        for (index, button) in buttons.enumerated() {
            guard let day = Days(rawValue: index) else { return }
            button.isSelected = day == selectedDay
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }

}
