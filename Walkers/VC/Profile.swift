//
//  Profile.swift
//  Walkers
//
//  Created by Никита Васильев on 09.10.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        addGradient()
        addViews()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        title = "Мой профиль"
        setup()
    }
    
    // MARK: - UIElements
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Редактировать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        button.alpha = 0.8
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.backgroundColor = .white
        stackView.layer.borderColor = UIColor.systemGray.cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Имя:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let age: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Возраст:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let radius: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Радиус поиска, км:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private lazy var userAge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private lazy var currentRadius: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let hobbies: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Интересы:"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private let userHobbies: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    // MARK: - Funcs
    let defaults = UserDefaults.standard
    
    func setup() {
        guard let data = UserDefaults.standard.data(forKey: .myCustomKey) else { return }
        let decoder = JSONDecoder()
        guard let user = try? decoder.decode(NewUser.self, from: data) else { return }
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            userName.text = user.name
            userAge.text = user.age
            currentRadius.text = user.radius
            userHobbies.text = user.hobbies
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            userName.text = ""
            userAge.text = ""
            currentRadius.text = ""
            userHobbies.text = ""
        }
    }
    
    @objc func edit() {
        let vc = ChangeUserSettings()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addViews() {
        view.addSubview(stackView)
        view.addSubview(editButton)
        stackView.addSubview(name)
        stackView.addSubview(userName)
        stackView.addSubview(age)
        stackView.addSubview(userAge)
        stackView.addSubview(radius)
        stackView.addSubview(currentRadius)
        stackView.addSubview(hobbies)
        stackView.addSubview(userHobbies)
    }
    
    func layout() {
        let inset: CGFloat = 150
        let inset2: CGFloat = 50
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset2 / 2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset2 / 3),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset2 / 3),
            stackView.heightAnchor.constraint(equalToConstant: 2 * inset),
            
            editButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: inset2 / 2),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset/2),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset/2),
            
            name.topAnchor.constraint(equalTo: stackView.topAnchor, constant: inset2 / 4),
            name.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: inset2 / 2),
            name.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -inset2 / 2),
            
            userName.topAnchor.constraint(equalTo: name.topAnchor),
            userName.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant:  -inset2 / 2),
            
            age.topAnchor.constraint(equalTo: name.bottomAnchor, constant: inset2 / 2),
            age.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            age.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            userAge.topAnchor.constraint(equalTo: age.topAnchor),
            userAge.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
            
            radius.topAnchor.constraint(equalTo: age.bottomAnchor, constant: inset2 / 2),
            radius.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            radius.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            currentRadius.topAnchor.constraint(equalTo: radius.topAnchor),
            currentRadius.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
            
            hobbies.topAnchor.constraint(equalTo: radius.bottomAnchor, constant: inset2 / 2),
            hobbies.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            hobbies.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            userHobbies.topAnchor.constraint(equalTo: hobbies.bottomAnchor, constant: inset2 / 2),
            userHobbies.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            userHobbies.trailingAnchor.constraint(equalTo: userName.trailingAnchor),
        ])
    }
}

// MARK: - Extensions

extension ProfileViewController {
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [color, UIColor.systemGray6.cgColor]
        view.layer.insertSublayer(gradient, at: 100)
    }
}



