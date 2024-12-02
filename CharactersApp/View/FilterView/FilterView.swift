//
//  FilterView.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 30/11/2024.
//

import UIKit

protocol FilterHeaderViewDelegate: AnyObject {
    func didTapFilterButton(withStatus status: String)
}

class FilterView: UIView {
    
    @IBOutlet weak var aliveButton: UIButton!
    @IBOutlet weak var deadButton: UIButton!
    @IBOutlet weak var unknownButton: UIButton!
    
    weak var delegate: FilterHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    
    private func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "FilterView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func setupButtons() {
        let buttons = [aliveButton, deadButton, unknownButton]
        for button in buttons {
            button?.titleLabel?.font = UIFont(name: "Avenir", size: 16)
            button?.layer.cornerRadius = 20
            button?.layer.borderWidth = 0.5
            button?.layer.borderColor = UIColor.lightGray.cgColor
            button?.clipsToBounds = true
            button?.layer.masksToBounds = true
        }
    }
    
    @IBAction func aliveButtonTapped(_ sender: UIButton) {
        delegate?.didTapFilterButton(withStatus: "Alive")
    }
    
    @IBAction func deadButtonTapped(_ sender: UIButton) {
        delegate?.didTapFilterButton(withStatus: "Dead")
    }
    
    @IBAction func unknownButtonTapped(_ sender: UIButton) {
        delegate?.didTapFilterButton(withStatus: "unknown")
    }
    
}
